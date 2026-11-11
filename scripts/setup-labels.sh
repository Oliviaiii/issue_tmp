#!/usr/bin/env bash
set -euo pipefail

repository=""
update_existing=false
remove_default_english=false

while (($# > 0)); do
  case "$1" in
    --repo)
      repository="${2:?--repo 需要 OWNER/REPO}"
      shift 2
      ;;
    --update-existing)
      update_existing=true
      shift
      ;;
    --remove-default-english-labels)
      remove_default_english=true
      shift
      ;;
    -h|--help)
      printf '%s\n' "用法：bash scripts/setup-labels.sh [--repo OWNER/REPO] [--update-existing] [--remove-default-english-labels]"
      exit 0
      ;;
    *)
      printf '未知參數：%s\n' "$1" >&2
      exit 2
      ;;
  esac
done

if ! command -v gh >/dev/null 2>&1; then
  printf '%s\n' "找不到 GitHub CLI（gh）。請先安裝並完成 gh auth login。" >&2
  exit 1
fi

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd -- "$script_dir/.." && pwd)"
labels_path="$repo_root/config/labels.tsv"

repo_args=()
if [[ -n "$repository" ]]; then
  repo_args=(--repo "$repository")
fi

declare -A existing_labels=()
if ! existing_output="$(gh label list "${repo_args[@]}" --limit 1000 --json name --jq '.[].name')"; then
  printf '%s\n' "無法讀取目標 repository 的 Labels。請確認 gh 登入狀態、repository 與權限。" >&2
  exit 1
fi

while IFS= read -r existing_name; do
  existing_name="${existing_name%$'\r'}"
  [[ -n "$existing_name" ]] && existing_labels["${existing_name,,}"]=1
done <<< "$existing_output"

while IFS=$'\t' read -r name color description; do
  name="${name%$'\r'}"
  color="${color%$'\r'}"
  description="${description%$'\r'}"
  [[ "$name" == "name" || -z "$name" ]] && continue

  normalized_name="${name,,}"
  if [[ -n "${existing_labels[$normalized_name]:-}" && "$update_existing" != true ]]; then
    printf '保留既有 Label：%s\n' "$name"
    continue
  fi

  force_args=()
  [[ -n "${existing_labels[$normalized_name]:-}" ]] && force_args=(--force)
  gh label create "$name" --color "$color" --description "$description" "${force_args[@]}" "${repo_args[@]}"
done < "$labels_path"

if [[ "$remove_default_english" == true ]]; then
  for label in "bug" "documentation" "duplicate" "enhancement" "good first issue" "help wanted" "invalid" "question" "wontfix"; do
    gh label delete "$label" --yes "${repo_args[@]}" 2>/dev/null || true
  done
fi

printf '%s\n' "Labels 處理完成。預設保留同名 Label；使用 --update-existing 才會同步顏色與說明。"
