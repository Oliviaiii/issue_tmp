# GitHub Issue Agent Skills 使用指南

這組範例把 Issue 開工、需求核對、實際驗收與 PR Review 拆成四個可重複使用的 Skill

它們位於 `.github/skills/`，每個 Skill 都是獨立資料夾與 `SKILL.md`

## 提供的 Skills

| Skill | 用途 | 不會自動執行 |
| --- | --- | --- |
| `issue-start` | 依 Issue 建立 branch、worktree、獨立資料庫與預覽網址 | Merge、Production 部署、清理環境 |
| `issue-check` | 開 PR 前依 Issue 與驗收條件核對修改 | 修改需求、宣告人工驗收通過 |
| `issue-qa` | 操作實際網址或 API 並保存驗收證據 | 繞過登入、替人做產品決策 |
| `pr-review` | 依 Diff、Issue、測試與 CI Review | 自動 Merge、部署、關閉 Issue |

## 安裝

GitHub Copilot 支援在 Repo 的 `.github/skills/`、`.claude/skills/` 或 `.agents/skills/` 尋找 project skills

最簡單的方式是把本 Repo 的 `.github/skills/` 整個複製到目標 Repo 的相同位置

其他 Agent 對 Skill 路徑與自動載入方式的支援可能不同，請先查該工具目前的文件

## 第一次使用前一定要設定

四個 Skill 可以共用 `.github/agent-workflow.yml` 作為專案轉接設定

1. 複製 [`config/agent-workflow.example.yml`](../config/agent-workflow.example.yml)
2. 在目標 Repo 建立 `.github/agent-workflow.yml`
3. 填入目標專案真正使用的 branch、worktree、資料庫、Preview、測試與清理命令
4. 先由人 Review 設定，確認後才把 `environment.enabled` 改成 `true`

資料庫、Preview 與清理方式和技術架構有關，這份公開範例不提供會直接修改環境的通用腳本

Agent 找不到設定時，應先盤點 Repo 現有文件與腳本並提出草稿，不能自行猜測命令

## 建議流程

```text
Issue 已確認
↓
issue-start 建立隔離環境
↓
Agent 實作與測試
↓
issue-check 核對需求
↓
建立 Pull Request
↓
pr-review 檢查 Diff 與 CI
↓
issue-qa 操作實際網址
↓
人決定 Merge、部署與結案
↓
人確認後清除 worktree、資料庫與預覽網址
```

## 為什麼需要四種隔離

- branch：隔離程式版本與 commit
- worktree：隔離實際工作資料夾，讓多個 Agent 可以同時工作
- 獨立資料庫：隔離 migration、設定與測試資料
- 獨立預覽網址：讓 PM、QA 或使用者直接看到該 Issue 的實際畫面

只有 branch 時，多個任務仍可能共用資料庫、網址與登入狀態，驗證結果容易互相影響

## 安全邊界

- 不把正式資料庫密碼、Token 或正式環境祕密寫入設定檔
- 不讓 Skill 自動取得超出本次任務需要的權限
- 不把 Agent 的「完成」當成人工驗收
- Merge、Production 部署、資料刪除、Issue 結案與環境清理保留人工確認
- 驗收證據移除個資、客戶資料、Cookie、內部網址與其他識別資訊
