#!/usr/bin/env bash
set -euo pipefail

create_label() {
  gh label create "$1" --color "$2" --description "$3" --force
}

create_label "錯誤回報" "d73a4a" "回報系統異常或不符合預期的行為"
create_label "功能新增" "0e8a16" "提出全新功能、流程或頁面需求"
create_label "功能修改" "1d76db" "調整既有功能的行為或流程"
create_label "任務追蹤" "fbca04" "追蹤具體且可驗收的工作項目"
create_label "樣式調整" "c5def5" "版型、介面與視覺樣式調整"
create_label "技術調研" "5319e7" "技術研究、試作與可行性驗證"
create_label "文件需求/修正" "0075ca" "新增、補充或修正文件"
create_label "提問" "cc317c" "使用支援與一般問題"
create_label "線上事故" "b60205" "正式環境重大異常或服務退化"
create_label "待確認" "ededed" "尚待確認內容、範圍或優先順序"
create_label "重複問題" "cfd3d7" "已有相同或高度相關的 Issue"
create_label "適合新手" "7057ff" "適合第一次參與本專案的人處理"
create_label "歡迎協助" "008672" "歡迎社群成員協助處理"
create_label "無效回報" "e4e669" "資訊不足、無法重現或不屬於有效問題"
create_label "暫不處理" "ffffff" "目前沒有規劃處理"

if [[ "${1:-}" == "--remove-default-english-labels" ]]; then
  for label in "bug" "documentation" "duplicate" "enhancement" "good first issue" "help wanted" "invalid" "question" "wontfix"; do
    gh label delete "$label" --yes 2>/dev/null || true
  done
fi

printf '%s\n' "繁體中文 Labels 已建立完成。"
