# GitHub Issue Forms 與 Projects 繁體中文教學

這是一套可直接套用的 **GitHub Issue 表單、Pull Request 模板與 Projects 教學**。目標不是只提供 YAML 範例，而是讓產品經理、工程師與開源維護者可以實際體驗「需求進 Issue、進度進 Project、完成後由 Pull Request 關聯」的完整流程。

> 最後驗證日期：2026-07-17

## 快速開始

- [使用此範本建立新 repository](https://github.com/Oliviaiii/issue_tmp/generate)
- [實際開一張 Issue 試用表單](https://github.com/Oliviaiii/issue_tmp/issues/new/choose)
- [查看公開 Projects 範例](https://github.com/users/Oliviaiii/projects/1)
- [提出問題或交流使用方式](https://github.com/Oliviaiii/issue_tmp/discussions)

> GitHub 的 Template Repository 只會複製檔案與目錄，不會複製 Labels、Issues 或 Project。建立新 repository 後，請執行下方的 Labels 初始化腳本。

## 教學路線

| 想完成的事 | 建議閱讀 |
| --- | --- |
| 直接套用繁中 Issue／PR 模板 | 本 README 的[套用方式](#套用方式) |
| 自己修改 Issue Form YAML | [GitHub Issue Form 語法教學](docs/issue-form-語法教學.md) |
| 用同一批資料建立 Table、Board、Roadmap | [GitHub Projects 完整教學](docs/github-projects-教學.md) |
| 讓狀態與項目自動流轉 | [GitHub Projects 自動化教學](docs/github-projects-workflow教學.md) |

## 內容結構

```text
.github/
├── ISSUE_TEMPLATE/
│   ├── config.yml
│   ├── 1-bug.yml
│   ├── 2-feature_add.yml
│   ├── 3-feature_change.yml
│   ├── 4-task.yml
│   ├── 5-feature_ui.yml
│   ├── 6-spike_research.yml
│   ├── 7-documentation.yml
│   ├── 8-support_question.yml
│   └── 9-incident_prod.yml
├── PULL_REQUEST_TEMPLATE.md
├── CONTRIBUTING.md
└── CODE_OF_CONDUCT.md
docs/                         # Issue Forms 與 Projects 完整教學
scripts/                      # 繁中 Labels 初始化腳本
```

## Issue 表單一覽

| 表單 | 適用情境 | 標題前綴 | 自動 Labels |
| --- | --- | --- | --- |
| 錯誤回報 | 系統異常或行為不符合預期 | `[錯誤]` | `錯誤回報`、`待確認` |
| 功能新增 | 新流程、新頁面或新能力 | `[功能新增]` | `功能新增`、`待確認` |
| 功能修改 | 調整既有功能行為 | `[功能修改]` | `功能修改`、`待確認` |
| 任務追蹤 | 有明確交付物的工作 | `[任務]` | `任務追蹤`、`待確認` |
| 樣式調整 | 版型、UI 與視覺調整 | `[樣式調整]` | `樣式調整`、`待確認` |
| 技術調研 | 需求不確定、試作或估工前研究 | `[技術調研]` | `技術調研`、`待確認` |
| 文件需求／修正 | README、規格、API 文件與 SOP | `[文件]` | `文件需求/修正`、`待確認` |
| 支援／提問 | 非錯誤、非需求的使用問題 | `[提問]` | `提問`、`待確認` |
| 線上事故 | 重大異常、服務退化與事故追蹤 | `[線上事故]` | `線上事故`、`待確認` |

## 套用方式

### 方式一：使用 Template Repository

按 repository 頁面上方的 **Use this template**，或直接開啟[建立頁面](https://github.com/Oliviaiii/issue_tmp/generate)。建立完成後，進入新 repository 執行 Labels 初始化腳本。

Windows PowerShell：

```powershell
.\scripts\setup-labels.ps1
```

macOS／Linux：

```bash
bash scripts/setup-labels.sh
```

若希望一併移除 GitHub 預設的英文 Labels：

```powershell
.\scripts\setup-labels.ps1 -RemoveDefaultEnglishLabels
```

```bash
bash scripts/setup-labels.sh --remove-default-english-labels
```

### 方式二：套用到既有 repository

把本 repository 的 `.github/` 與 `scripts/` 複製到既有專案，再執行上方 Labels 初始化腳本。Issue Forms 必須位於 default branch 的 `.github/ISSUE_TEMPLATE/` 才會出現在建立 Issue 的選單。

### 方式三：設定帳號或組織的預設社群檔案

建立一個名為 `.github` 的特殊 repository，將 Issue／PR 模板放入其中。沒有自行定義模板的 repositories 便可沿用這些預設檔案。

## 繁體中文 Labels

本範例使用兩種 Label：

- **需求類型**：`錯誤回報`、`功能新增`、`功能修改`、`任務追蹤`、`樣式調整`、`技術調研`、`文件需求/修正`、`提問`、`線上事故`
- **協作狀態**：`待確認`、`重複問題`、`適合新手`、`歡迎協助`、`無效回報`、`暫不處理`

Status、Priority、Iteration 等流程資訊建議放在 GitHub Projects 欄位，不要再用 Labels 重複維護，避免同一狀態出現兩份資料。

## 公開 Projects 範例

[Penance Manager｜GitHub 專案管理繁中範例](https://github.com/users/Oliviaiii/projects/1)示範：

- Issue 與 Pull Request 如何成為 Project 項目
- Status、Priority、Iteration、日期與估工欄位
- Table、Board 與 Roadmap 如何共用同一份資料
- 新項目、關閉、重新開啟與合併時的自動化流程

Project 是個人或組織層級的資源，不會隨 Template Repository 一起複製。需要相同 Project 結構時，請使用 Project 選單中的 **Make a copy**。

## 客製化提醒

- Labels 必須先存在，Issue Form 才能自動套用。
- `projects:` 只有在開票者對指定 Project 具有寫入權限時才能自動加入；公開表單建議使用 Project 的 Auto-add Workflow。
- Issue Type 是組織層級功能，個人帳號 repository 請使用 Labels 分類。
- 複製後請調整表單欄位、Project 欄位與貢獻規範，不要把所有範例原封不動帶進正式專案。

## 授權與貢獻

本 repository 採用 [MIT License](LICENSE)。你可以複製、修改與再散布模板及教學內容，但請保留授權聲明。

若想回報問題或補充範例，請閱讀[貢獻指南](.github/CONTRIBUTING.md)。
