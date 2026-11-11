# 交給 AI 安裝這套 GitHub 範本

這份文件是給 AI Agent 閱讀的安裝規格。使用者只要提供**目標 repository**與想安裝的 profile，AI 就能盤點既有設定、建立缺少的 Labels，並把範本放進正確位置。

> Issue Forms 要生效，目標位置固定是 default branch 的 `.github/ISSUE_TEMPLATE/`。使用者可以指定本機專案資料夾或 GitHub repository，但不能把有效模板任意放到其他路徑。

## 給使用者的最短用法

把下面這段貼給能讀取 GitHub、GitHub MCP、GitHub CLI 或本機專案資料夾的 AI：

```text
請閱讀 https://github.com/Oliviaiii/issue_tmp/blob/main/AI_INSTALL.md
以及 https://github.com/Oliviaiii/issue_tmp/blob/main/install-manifest.yml

把範本安裝到這個目標 repository：<OWNER/REPO 或本機完整路徑>
安裝 profile：starter

請先只盤點並回報：
1. 目標 repository 的 default branch
2. 現有 .github/ISSUE_TEMPLATE、PR Template、SECURITY.md 與 Labels
3. 預計新增、保留、衝突的檔案與 Labels
4. 你目前使用 GitHub MCP、GitHub CLI，還是本機 Git

我確認後再執行
不要覆蓋同名檔案
不要刪除既有 Labels 或模板
GitHub 檔案變更請建立新 branch 與 Pull Request
只建立缺少的 Labels；同名 Label 已存在時先保留原本顏色與說明
遇到登入、2FA、OAuth、Token 或權限畫面時停下來交給我
完成後請重新讀取 GitHub，列出可驗證的檔案、Labels、branch 與 PR 連結
```

`starter` 可改成：

| Profile | 適用情境 | 內容 |
| --- | --- | --- |
| `starter` | 第一次使用 Issue Forms | Bug、功能新增、一般任務、PR Template、安全政策 |
| `product` | 產品／專案團隊 | starter ＋功能修改、UI、技術調研、文件 |
| `agent` | 準備把 Issue 指派給 AI Agent | product ＋ AI Agent 任務表單 |
| `full` | 開源專案或完整團隊流程 | 全部表單、貢獻指南與行為準則 |

## AI 執行規格

### 1. 先確認能力與範圍

AI 必須先確認：

- 來源 repository 是 `Oliviaiii/issue_tmp`
- 目標 repository／本機資料夾由使用者明確指定
- 能否讀取目標 Repo 的 default branch、檔案與 Labels
- 能否建立 branch、commit、Pull Request 與 Labels
- 使用者選擇的 profile 存在於 [`install-manifest.yml`](install-manifest.yml)

不要請使用者把密碼、2FA 驗證碼或 Personal Access Token 貼進對話。需要 GitHub 授權時，交由使用者在 OAuth／瀏覽器流程完成。

### 2. 盤點後才安裝

讀取 manifest 中所選 profile 的 `files` 與 `labels`，再和目標 Repo 比對，將結果分成：

- `create`：目標不存在，可以新增
- `keep`：內容或 Label 已存在，不需處理
- `conflict`：同一路徑已有不同內容，預設不可覆蓋
- `unsupported`：AI 沒有完成該步驟的工具或權限

盤點階段只回報計畫，不修改任何外部狀態。

### 2.1 轉換 repository 專屬網址

複製 `.github/ISSUE_TEMPLATE/config.yml` 時，不可保留來源 Repo `Oliviaiii/issue_tmp` 的連結：

- Security Policy 改成 `https://github.com/<TARGET_OWNER>/<TARGET_REPO>/security/policy`
- 只有目標 Repo 已啟用 Discussions 時，才保留 Discussions contact link，並改成目標 Repo 的 `/discussions`
- 若目標沒有 Discussions，從**準備新增的新 config** 移除該 contact link，並在安裝報告標示；不要因此修改其他既有檔案

這是安裝時的必要參數轉換，不是把來源檔案原封不動複製。若目標已經有 `config.yml`，仍依衝突規則處理，不可直接覆蓋。

### 3. Labels 與檔案分開處理

Labels 是 Repo 設定，不會跟著 Git commit 或 Template Repository 複製。AI 應：

1. 只建立 profile 需要、且目標 Repo 尚不存在的 Labels
2. 同名 Label 已存在時保留原設定
3. 只有使用者明確要求同步顏色／說明時，才更新既有 Label
4. 不刪除目標 Repo 的其他 Labels

若 AI 能執行 GitHub CLI，可在來源 Repo 內使用：

```powershell
.\scripts\setup-labels.ps1 -Repository OWNER/REPO
```

```bash
bash scripts/setup-labels.sh --repo OWNER/REPO
```

這兩個腳本預設會建立缺少的 Labels、保留同名 Labels。只有加上 `-UpdateExisting`／`--update-existing` 才會同步顏色與說明。

檔案應放在新 branch，例如 `chore/install-issue-templates`，再建立 Pull Request。不要直接寫入 default branch。

### 4. 衝突處理

如果目標已有 `.github/ISSUE_TEMPLATE/config.yml`、同名表單或 PR Template：

1. 不覆蓋
2. 產生來源與目標差異摘要
3. 建議「保留目標」「改用新檔名」「人工合併」三種方案
4. 等使用者決定後再繼續

不要用刪除再重建的方式繞過衝突。

### 5. 完成驗證

完成後至少驗證：

- 新 branch 上的檔案路徑與內容存在
- Pull Request 的 base 是目標 Repo 的 default branch
- profile 需要的 Labels 已存在
- `config.yml` 不含仍指向 `Oliviaiii/issue_tmp` 的 repository 專屬網址
- 安裝後的 YAML 可由 parser 正常解析；若目標 Repo 也導入自己的驗證 workflow，該檢查必須通過
- PR 合併後，模板位於 default branch 的 `.github/ISSUE_TEMPLATE/`

New Issue 選單是否正常顯示屬於最後的 UI 驗證。如果 AI 無法開啟該頁面，必須標示為「尚未做 UI 驗證」，不能只因檔案存在就宣稱完整通過。

## 本機安裝與 GitHub MCP 的差別

- **本機 Git／CLI**：AI 可以複製檔案、執行驗證、commit、push、開 PR
- **GitHub MCP／連接器**：AI 可以直接讀寫 GitHub 檔案與 Labels，但能用哪些工具取決於 host 與授權
- **只有聊天能力**：AI 只能產生操作步驟，不能宣稱已完成安裝

