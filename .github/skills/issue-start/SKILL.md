---
name: issue-start
description: 依照已確認的 GitHub Issue 建立隔離開發環境。適用於需要獨立 branch、worktree、資料庫與預覽網址的新功能開工，不適用於正式環境緊急修正或已合併後的驗收修正。
---

# Issue Start

把一張已經可以執行的 Issue 轉成可獨立開發與驗收的環境

## 開始前

1. 讀取 Issue 本文、最新留言、驗收條件與相關 Issue／PR
2. 讀取 Repo 的 `AGENTS.md`、貢獻規範與測試說明
3. 檢查是否已有對應 branch、worktree 或未關閉 PR，找到既有工作時優先接續，不要建立第二套
4. 讀取 `.github/agent-workflow.yml`

若 `.github/agent-workflow.yml` 不存在，參考 `config/agent-workflow.example.yml` 盤點專案現有腳本並提出設定草稿，等人確認後再建立檔案或執行環境命令

不得自行猜測資料庫建立、網址配置、容器、部署或清理命令

## 開工條件

以下條件都成立才開始建立環境

- Issue 已說明問題、範圍與本次不做的內容
- 驗收條件可以逐條判定通過或失敗
- 需要的人類決策與權限已經確認
- 工作類型屬於新開發，不是正式環境緊急修正
- 基準 branch 可以從專案設定或 Issue 明確判定
- 工作區沒有會被覆蓋的既有修改

缺少必要資訊時列出問題並停止，不自行補完需求

## 建立環境

依 `.github/agent-workflow.yml` 執行

1. 從指定基準建立一條只服務本 Issue 的 branch
2. 建立獨立 worktree，避免切換任務時覆蓋其他工作的檔案
3. 執行相依套件準備命令
4. 建立獨立資料庫或 schema
5. 建立獨立預覽網址或 Preview Deployment
6. 執行環境健康檢查
7. 重新讀取 branch、worktree、資料庫與網址，確認實際結果

任一步失敗都停止後續步驟並保留完整錯誤，不要先把 Project 更新成進行中

## Project 更新

只有開發環境全部建立成功後，才在工具與權限允許時更新

- 負責人或認領狀態
- Work Status：進行中
- Environment：實際建立的環境
- Validation：尚未驗收

沒有 Project 寫入能力時只回報建議值，不宣稱已更新

## 回報

至少列出

- Issue 連結
- branch 與基準 branch
- worktree 路徑
- 資料庫識別名稱，不包含密碼或連線密鑰
- 預覽網址
- 健康檢查與測試結果
- Project 是否已回讀確認
- 尚未完成與需要人處理的項目

本 Skill 不負責 Merge、正式環境部署、關閉 Issue 或清除環境
