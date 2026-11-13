# GitHub Issue Forms 與 Projects 繁體中文教學

這是一套可直接套用的 **GitHub Issue 表單、Pull Request 模板、Agent Skills 與 Projects 教學**。目標不是只提供 YAML 範例，而是讓產品經理、工程師與開源維護者可以實際體驗「需求進 Issue、Agent 建立隔離環境、進度進 Project、完成後由 Pull Request 關聯」的完整流程。

> 最後驗證日期：2026-11-13

## 快速開始

- [交給 AI 自動盤點與安裝](AI_INSTALL.md)
- [使用此範本建立新 repository](https://github.com/Oliviaiii/issue_tmp/generate)
- [實際開一張 Issue 試用表單](https://github.com/Oliviaiii/issue_tmp/issues/new/choose)
- [查看公開 Projects 範例](https://github.com/users/Oliviaiii/projects/1)
- [複製 Issue Agent Skills](docs/agent-skills-使用指南.md)
- [提出問題或交流使用方式](https://github.com/Oliviaiii/issue_tmp/discussions)

> GitHub 的 Template Repository 只會複製檔案與目錄，不會複製 Labels、Issues 或 Project。建立新 repository 後，請執行下方的 Labels 初始化腳本。

## 最推薦：讓 AI 讀取後安裝

如果使用的 AI 可以連接 GitHub MCP、GitHub CLI 或本機 Git，不需要手動逐個複製檔案。把以下提示詞交給 AI：

```text
請閱讀 https://github.com/Oliviaiii/issue_tmp/blob/main/AI_INSTALL.md
以及 https://github.com/Oliviaiii/issue_tmp/blob/main/install-manifest.yml

把 starter profile 安裝到 <OWNER/REPO 或本機完整路徑>
先盤點 default branch、現有 Issue Templates、PR Template、SECURITY.md 與 Labels
先回報新增／保留／衝突項目，等我確認後再執行
不要覆蓋或刪除既有內容
檔案請建立新 branch 與 Pull Request
Labels 只建立缺少的項目
完成後重新讀取 GitHub 並提供可驗證結果
```

可用 profile：`starter`、`product`、`agent`、`full`。`agent` 與 `full` 會包含四個 Agent Skills 與專案環境設定範本。完整的安全規則、衝突處理與驗證方式見 [`AI_INSTALL.md`](AI_INSTALL.md)。

## 教學路線

| 想完成的事 | 建議閱讀 |
| --- | --- |
| 直接套用繁中 Issue／PR 模板 | 本 README 的[套用方式](#套用方式) |
| 自己修改 Issue Form YAML | [GitHub Issue Form 語法教學](docs/issue-form-語法教學.md) |
| 用同一批資料建立 Table、Board、Roadmap | [GitHub Projects 完整教學](docs/github-projects-教學.md) |
| 讓狀態與項目自動流轉 | [GitHub Projects 自動化教學](docs/github-projects-workflow教學.md) |
| 讓 AI 安裝範本與建立 Labels | [AI 安裝教學](AI_INSTALL.md) |
| 讓 Agent 依 Issue 建立隔離環境與交付證據 | [Issue Agent Skills 使用指南](docs/agent-skills-使用指南.md) |

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
│   ├── 9-incident_prod.yml
│   └── 10-ai_agent_task.yml
├── PULL_REQUEST_TEMPLATE.md
├── SECURITY.md
├── CONTRIBUTING.md
├── CODE_OF_CONDUCT.md
├── skills/
│   ├── issue-start/SKILL.md
│   ├── issue-check/SKILL.md
│   ├── issue-qa/SKILL.md
│   └── pr-review/SKILL.md
└── workflows/validate-templates.yml
config/labels.tsv             # Labels 的單一資料來源
config/agent-workflow.example.yml # 專案環境命令設定範本
docs/                         # Issue Forms 與 Projects 完整教學
scripts/                      # 繁中 Labels 初始化腳本
AI_INSTALL.md                 # 給 AI Agent 閱讀的安裝規格
install-manifest.yml          # starter / product / agent / full 安裝清單
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
| AI Agent 任務 | 範圍、限制、驗證與人工關卡已明確的 Agent 工作 | `[AI 任務]` | `AI 任務`、`待確認` |

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

要替另一個 repository 建立缺少的 Labels：

```powershell
.\scripts\setup-labels.ps1 -Repository OWNER/REPO
```

```bash
bash scripts/setup-labels.sh --repo OWNER/REPO
```

腳本預設保留同名 Label 的顏色與說明。只有明確要同步時才使用 `-UpdateExisting` 或 `--update-existing`。

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

- **需求類型**：`錯誤回報`、`功能新增`、`功能修改`、`任務追蹤`、`樣式調整`、`技術調研`、`文件需求/修正`、`提問`、`線上事故`、`AI 任務`
- **協作狀態**：`待確認`、`重複問題`、`適合新手`、`歡迎協助`、`無效回報`、`暫不處理`

Status、Priority、Iteration 等流程資訊建議放在 GitHub Projects 欄位，不要再用 Labels 重複維護，避免同一狀態出現兩份資料。

所有 Label 名稱、顏色與說明統一維護在 [`config/labels.tsv`](config/labels.tsv)。PowerShell 與 Bash 腳本都讀取同一份資料，避免兩套清單不同步。

> 若用 AI 安裝或手動複製到其他 repository，記得把 `.github/ISSUE_TEMPLATE/config.yml` 的 Security／Discussions 連結改成目標 repository。沒有啟用 Discussions 時，請移除該 contact link。

## Issue Agent Skills

`.github/skills/` 提供四個去識別化、可依專案調整的範例：

- `issue-start`：依 Issue 建立 branch、worktree、獨立資料庫與預覽網址
- `issue-check`：開 PR 前核對 Issue、驗收條件、Diff 與測試證據
- `issue-qa`：操作實際網址或 API，記錄預期、實際結果與證據
- `pr-review`：依 PR Diff、CI 與關聯 Issue 做範圍內 Review

資料庫、Preview 與清理命令會依技術架構不同，因此範例不包含會直接操作環境的通用腳本。請先把 [`config/agent-workflow.example.yml`](config/agent-workflow.example.yml) 複製成目標 Repo 的 `.github/agent-workflow.yml`，再由人確認真正要執行的命令。

完整安裝方式、安全邊界與流程見 [Issue Agent Skills 使用指南](docs/agent-skills-使用指南.md)。

## 公開 Projects 範例

[Penance Manager｜GitHub 專案管理繁中完整範例](https://github.com/users/Oliviaiii/projects/1)示範：

- Issue 與 Pull Request 如何成為 Project 項目
- 7 階段 Status、Priority、Iteration、日期、估工、環境與驗收欄位
- 9 個 Table、Board 與 Roadmap Views 如何共用同一份資料
- Milestone、父子 Issue、Linked pull requests 與人工驗收如何串成完整流程
- 新項目、關閉、重新開啟、合併與自動加入 Project 的 Workflow
- `AI Ready` 任務佇列與 AI 認領欄位的安全示意（不會自動執行）
- Status、各模組預估工時與各 Sprint 狀態分布的 Insights 圖表

### 跟著公開資料看一次完整流程

1. 從 [AI 任務範例 #8](https://github.com/Oliviaiii/issue_tmp/issues/8)觀察「開發就緒但尚未認領」。
2. 從[每週摘要父議題 #11](https://github.com/Oliviaiii/issue_tmp/issues/11)展開 [#12](https://github.com/Oliviaiii/issue_tmp/issues/12) 與 [#13](https://github.com/Oliviaiii/issue_tmp/issues/13)兩張子議題。
3. 從[文件任務 #6](https://github.com/Oliviaiii/issue_tmp/issues/6)查看關聯 Pull Request、驗證結果與合併後的自動結案。
4. 到 [`v1.0 教學範例` Milestone](https://github.com/Oliviaiii/issue_tmp/milestone/1)查看版本範圍與完成比例。
5. 回到 [Project 工作流程看板](https://github.com/users/Oliviaiii/projects/1/views/1)確認狀態、驗證與發布資訊。

Project 是個人或組織層級的資源，不會隨 Template Repository 一起複製。需要相同 Project 結構時，請使用 Project 選單中的 **Make a copy**。

> Project 複製後仍要重新檢查預設 Repository、Auto-add 條件、協作者權限與 Repository Rules；這些設定可能依擁有者與權限而不同。

## 客製化提醒

- Labels 必須先存在，Issue Form 才能自動套用。
- `projects:` 只有在開票者對指定 Project 具有寫入權限時才能自動加入；公開表單建議使用 Project 的 Auto-add Workflow。
- Issue Type 是組織層級功能，個人帳號 repository 請使用 Labels 分類。
- GitHub 官方目前說明 `required` 只會在 public repository 阻止未完成的表單送出；private repository 不要把 YAML 驗證當成唯一流程控制。
- 安全性漏洞不要透過公開 Issue 回報；請先客製化 [安全政策](.github/SECURITY.md)，並評估啟用 Private vulnerability reporting。
- 複製後請調整表單欄位、Project 欄位與貢獻規範，不要把所有範例原封不動帶進正式專案。

## 自動驗證

本 repository 會在相關 Pull Request 與 `main` 更新時執行 `scripts/validate-templates.rb`，檢查：

- YAML 可解析、頂層必要欄位與元件類型正確
- `id` 不重複且格式有效
- dropdown／checkboxes／upload 驗證設定合理
- 表單引用的 Labels 存在於 `config/labels.tsv`
- Agent Skill 的 `SKILL.md` frontmatter、名稱與資料夾一致
- Agent workflow 設定範本包含必要區塊
- `install-manifest.yml` 引用的檔案與 Labels 存在

## 授權與貢獻

本 repository 採用 [MIT License](LICENSE)。你可以複製、修改與再散布模板及教學內容，但請保留授權聲明。

若想回報問題或補充範例，請閱讀[貢獻指南](.github/CONTRIBUTING.md)。
