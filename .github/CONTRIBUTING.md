# 貢獻指南

感謝你協助改善 **GitHub Issue Forms 與 Projects 繁體中文教學**。本 repository 以「可直接操作、可複製、用詞一致」為原則。

參與前請先閱讀[貢獻者行為準則](./CODE_OF_CONDUCT.md)。

## 回報問題

1. 先搜尋是否已有相同 Issue。
2. 從 [Issue 表單選單](https://github.com/Oliviaiii/issue_tmp/issues/new/choose)選擇最接近的類型。
3. 提供可重現步驟、實際與預期結果，以及相關截圖或紀錄。

一般使用問題可改到 [Discussions](https://github.com/Oliviaiii/issue_tmp/discussions)討論。

## 修改模板或教學

1. Fork 或建立分支。
2. 修改 `.github/ISSUE_TEMPLATE/`、`docs/` 或 `scripts/`。
3. 確認 YAML 使用 UTF-8 編碼且能正常解析。
4. 若修改 Label 名稱，必須同步更新所有表單、README 與初始化腳本。
5. 送出 Pull Request，完整填寫變更內容、影響範圍與驗證方式。

## 文字與命名規範

- 讀者看得到的名稱與說明使用繁體中文。
- GitHub 固有功能名稱可保留英文，例如 Issue、Project、Pull Request、Status。
- 同一概念使用一致名稱，不在 Label 與 Project 欄位重複表示同一狀態。
- 教學內容若依賴 GitHub 介面或功能，請註明最後驗證日期。

## Commit 訊息

建議格式：

```text
【文件】【教學】補充 Issue Forms 欄位說明
【調整】【表單】改善錯誤回報必填欄位
【修正】【Labels】同步繁體中文標籤名稱
```

再次感謝你的貢獻。
