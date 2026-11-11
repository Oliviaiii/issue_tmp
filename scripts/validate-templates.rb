#!/usr/bin/env ruby
# frozen_string_literal: true

require "csv"
require "pathname"
require "set"
require "yaml"

ROOT = Pathname.new(__dir__).parent
FORM_DIR = ROOT.join(".github", "ISSUE_TEMPLATE")
ALLOWED_TOP_LEVEL = Set.new(%w[name description title labels assignees projects type body]).freeze
ALLOWED_TYPES = Set.new(%w[markdown input textarea dropdown checkboxes upload]).freeze
errors = []

labels_path = ROOT.join("config", "labels.tsv")
labels = CSV.read(labels_path, headers: true, col_sep: "\t", encoding: "UTF-8").map { |row| row["name"] }
label_set = labels.to_set
errors << "config/labels.tsv 有重複名稱" unless labels.length == label_set.length

form_paths = Dir[FORM_DIR.join("[0-9]*.yml").to_s].sort
errors << "找不到 Issue Form" if form_paths.empty?

form_paths.each do |path_string|
  path = Pathname.new(path_string)
  relative = path.relative_path_from(ROOT).to_s
  begin
    form = YAML.safe_load(path.read(encoding: "UTF-8"), permitted_classes: [], aliases: false)
  rescue Psych::SyntaxError => e
    errors << "#{relative}: YAML 無法解析（#{e.message.lines.first.strip}）"
    next
  end

  unless form.is_a?(Hash)
    errors << "#{relative}: 頂層必須是 mapping"
    next
  end

  unknown_keys = form.keys.map(&:to_s).to_set - ALLOWED_TOP_LEVEL
  errors << "#{relative}: 不支援的頂層欄位 #{unknown_keys.to_a.join(', ')}" unless unknown_keys.empty?

  %w[name description body].each do |key|
    errors << "#{relative}: 缺少 #{key}" unless form.key?(key)
  end
  errors << "#{relative}: name 必須超過 3 個字元" if form["name"].to_s.length <= 3

  referenced_labels = case form["labels"]
                      when Array then form["labels"]
                      when String then form["labels"].split(",").map(&:strip)
                      else []
                      end
  referenced_labels.each do |label|
    errors << "#{relative}: Label「#{label}」未定義於 config/labels.tsv" unless label_set.include?(label)
  end

  body = form["body"]
  unless body.is_a?(Array) && !body.empty?
    errors << "#{relative}: body 必須是非空陣列"
    next
  end

  ids = Set.new
  body.each_with_index do |element, index|
    prefix = "#{relative}: body[#{index}]"
    unless element.is_a?(Hash)
      errors << "#{prefix} 必須是 mapping"
      next
    end

    type = element["type"].to_s
    errors << "#{prefix}: 不支援的 type「#{type}」" unless ALLOWED_TYPES.include?(type)

    id = element["id"]
    if type == "markdown" && id
      errors << "#{prefix}: markdown 不可設定 id"
    elsif id
      errors << "#{prefix}: id「#{id}」格式不合法" unless id.match?(/\A[A-Za-z0-9_-]+\z/)
      errors << "#{prefix}: id「#{id}」重複" if ids.include?(id)
      ids << id
    end

    attributes = element["attributes"]
    unless attributes.is_a?(Hash)
      errors << "#{prefix}: attributes 必須是 mapping"
      next
    end

    if type == "markdown"
      errors << "#{prefix}: markdown 缺少 attributes.value" if attributes["value"].to_s.empty?
    else
      errors << "#{prefix}: 缺少 attributes.label" if attributes["label"].to_s.empty?
    end

    validations = element["validations"] || {}
    unless validations.is_a?(Hash)
      errors << "#{prefix}: validations 必須是 mapping"
      next
    end
    if validations.key?("required") && ![true, false].include?(validations["required"])
      errors << "#{prefix}: validations.required 必須是 boolean"
    end
    if validations.key?("min_length")
      value = validations["min_length"]
      errors << "#{prefix}: min_length 只適用於 input／textarea" unless %w[input textarea].include?(type)
      errors << "#{prefix}: min_length 必須是非負整數" unless value.is_a?(Integer) && value >= 0
    end

    if type == "dropdown"
      options = attributes["options"]
      unless options.is_a?(Array) && !options.empty?
        errors << "#{prefix}: dropdown.options 必須是非空陣列"
        next
      end
      errors << "#{prefix}: dropdown 選項不可重複" unless options.length == options.uniq.length
      default = attributes["default"]
      if default && (!default.is_a?(Integer) || default.negative? || default >= options.length)
        errors << "#{prefix}: dropdown.default 超出選項範圍"
      end
      if default && options.any? { |option| %w[none n/a].include?(option.to_s.downcase) }
        errors << "#{prefix}: 設定 default 時不可使用 None／n/a 選項"
      end
    end

    if type == "checkboxes"
      options = attributes["options"]
      unless options.is_a?(Array) && !options.empty?
        errors << "#{prefix}: checkboxes.options 必須是非空陣列"
        next
      end
      options.each_with_index do |option, option_index|
        unless option.is_a?(Hash) && !option["label"].to_s.empty?
          errors << "#{prefix}: option[#{option_index}] 缺少 label"
        end
        if option.is_a?(Hash) && option.key?("required") && ![true, false].include?(option["required"])
          errors << "#{prefix}: option[#{option_index}].required 必須是 boolean"
        end
      end
    end

    if type == "upload" && validations.key?("accept") && !validations["accept"].is_a?(String)
      errors << "#{prefix}: upload.validations.accept 必須是逗號分隔字串"
    end
  end
end

begin
  manifest = YAML.safe_load(ROOT.join("install-manifest.yml").read(encoding: "UTF-8"), permitted_classes: [], aliases: false)
  manifest.fetch("profiles").each do |profile_name, profile|
    profile.fetch("files").each do |file|
      errors << "install-manifest.yml: #{profile_name} 引用不存在檔案 #{file}" unless ROOT.join(file).file?
    end
    profile.fetch("labels").each do |label|
      errors << "install-manifest.yml: #{profile_name} 引用未定義 Label「#{label}」" unless label_set.include?(label)
    end
  end
  manifest.fetch("install_rules").fetch("repository_url_rewrites", []).each do |rewrite|
    rewrite_path = ROOT.join(rewrite.fetch("path"))
    errors << "install-manifest.yml: URL 轉換引用不存在檔案 #{rewrite['path']}" unless rewrite_path.file?
    next unless rewrite_path.file?

    source = rewrite.fetch("source")
    target = rewrite.fetch("target")
    errors << "install-manifest.yml: #{rewrite['path']} 找不到待轉換網址 #{source}" unless rewrite_path.read(encoding: "UTF-8").include?(source)
    unless target.include?("{owner}") && target.include?("{repo}")
      errors << "install-manifest.yml: URL 轉換 target 必須包含 {owner} 與 {repo}"
    end
  end
rescue KeyError, Psych::SyntaxError => e
  errors << "install-manifest.yml 無效：#{e.message}"
end

if errors.empty?
  puts "Issue Forms、Labels 與安裝 manifest 驗證通過（#{form_paths.length} 份表單）。"
  exit 0
end

warn "驗證失敗："
errors.each { |error| warn "- #{error}" }
exit 1

