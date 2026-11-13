---
name: pr-review
description: 依 Pull Request diff、關聯 Issue、測試與 CI 證據執行範圍內 Review。適用於找出會影響正確性、安全性、相容性與驗收的問題，不負責自動 Merge 或部署。
---

# PR Review

以本次 Pull Request 的實際 Diff 與關聯 Issue 為 Review 範圍

## Review 前

1. 讀取 PR 描述、關聯 Issue、驗收條件與 Repo 規範
2. 確認 base branch、head branch、最新 commit 與 CI 狀態
3. 檢查 PR 是否混入其他 Issue 的修改
4. 若 PR 在取證期間新增 commit，重新讀取 Diff 後再下結論

## 檢查內容

- 實作是否符合 Issue 與不做事項
- 錯誤、空資料、權限不足與相容性情境
- 資料寫入、migration、回滾與部署風險
- 是否修改到非預期模組或共用元件
- 自動測試是否涵蓋本次行為
- UI 或資料變更是否提供可驗收證據
- 是否包含密碼、Token、個資、除錯檔或不該提交的產物

不要把未修改檔案的既有問題擴張成本 PR finding，除非本次修改會觸發或加重該問題

## Finding 格式

每一項 finding 包含

- 嚴重度
- 觸發條件
- 實際影響
- 檔案與行號證據
- 建議修正方向

同一根因的多處表現合併成一項

無法由證據確認的內容標示為問題或未驗證，不寫成已確認缺陷

## 結論

回報

- 必須修正
- 建議改善
- 已驗證通過
- 尚未驗證
- CI 與測試狀態

本 Skill 不自動 Merge、部署、關閉 Issue 或清除 worktree、資料庫與預覽網址
