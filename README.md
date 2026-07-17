# issue_tmp — GitHub Issue / PR 模板套件

這個 repo 收錄了一組可直接套用的 **GitHub Issue 表單** 與 **Pull Request 模板**（繁體中文），讓團隊在開 issue 或送 PR 時有一致的格式，減少資訊缺漏、加快分流與處理速度。

---

## 📁 內容結構

```
.github/
├── ISSUE_TEMPLATE/
│   ├── config.yml              # Issue 選單設定（關閉空白 issue、外部連結）
│   ├── 1-bug.yml               # 🐛 錯誤回報
│   ├── 2-feature_add.yml       # ✨ 功能新增
│   ├── 3-feature_change.yml    # ✨ 功能修改
│   ├── 4-task.yml              # 🛠️ 任務追蹤
│   ├── 5-feature_ui.yml        # 🎨 版型 / 樣式調整
│   ├── 6-spike_research.yml    # 🔍 研究 / 試作（Spike）
│   ├── 7-documentation.yml     # 📚 文件需求 / 修正
│   ├── 8-support_question.yml  # ❓ 支援 / 提問
│   └── 9-incident_prod.yml     # 🚨 線上事故（Incident）
├── PULL_REQUEST_TEMPLATE.md    # PR 模板
├── CONTRIBUTING.md             # 貢獻指南
└── CODE_OF_CONDUCT.md          # 行為準則
```

---

## 🧩 Issue 模板一覽

| 模板 | 用途 | 標題前綴 | 自動標籤 |
|------|------|----------|----------|
| 🐛 Bug Report | 回報系統異常、錯誤或不符合預期的行為 | `[Bug]` | `錯誤回報` |
| ✨ Feature Add | 提出全新功能需求與規格 | `[功能新增]` | `功能新增` |
| ✨ Feature Change | 提出既有功能的調整需求 | `[功能修改]` | `功能修改` |
| 🛠️ Task | 追蹤明確可執行的任務或待辦 | `[Task]` | `任務追蹤` |
| 🎨 Feature (UI) | 版型、UI、樣式或視覺調整需求 | `[樣式調整]` | `樣式調整` |
| 🔍 Spike | 技術/需求不確定時的探索、PoC、估工前研究 | `[Spike]` | `技術調研` |
| 📚 Documentation | 新增、補齊或修正文件（README / Spec / API Doc / SOP） | `[Docs]` | `文件需求/修正` |
| ❓ Support / Question | 非 bug/需求的提問、卡關求救、使用支援 | `[Question]` | `提問` |
| 🚨 Incident | 追蹤線上事故、重大異常或服務退化 | `[Incident][P1][XXX-1234]` | `線上事故` |

> 已透過 `config.yml` 設定 `blank_issues_enabled: false`，**禁止建立空白 issue**，使用者必須從上述模板中選擇。

---

## 🚀 如何使用

### 方式一：直接在這個 repo 用

當有人在本 repo 點選 **Issues → New issue** 時，GitHub 會自動列出上面 9 種表單供選擇；送出後標題前綴與標籤都會自動帶入。送 PR 時也會自動套用 `PULL_REQUEST_TEMPLATE.md`。

### 方式二：套用到你自己的專案（最常見）

GitHub 的模板放在 repo 根目錄的 `.github/` 資料夾即可生效。把本 repo 的 `.github/` 複製到你的專案：

```bash
# 在你自己的專案根目錄執行
git clone https://github.com/Oliviaiii/issue_tmp.git /tmp/issue_tmp
cp -r /tmp/issue_tmp/.github ./        # 複製整個 .github 資料夾

git add .github
git commit -m "chore: 套用 issue/PR 模板"
git push
```

Windows PowerShell：

```powershell
git clone https://github.com/Oliviaiii/issue_tmp.git $env:TEMP\issue_tmp
Copy-Item -Recurse $env:TEMP\issue_tmp\.github .\
git add .github
git commit -m "chore: 套用 issue/PR 模板"
git push
```

推送後，到該 repo 的 **Issues → New issue** 就會看到這些表單。

### 方式三：設為整個 GitHub 帳號 / 組織的預設模板

GitHub 支援「組織層級預設」：建立一個名為 `.github` 的特殊 repo，把這些模板放進去後，**該帳號/組織底下所有沒有自帶模板的 repo** 都會自動套用。

---

## ⚙️ 客製化建議

套用後請依自己團隊調整以下項目：

- **`config.yml` 的外部連結**：目前 Discord / 後台 / 前台網址皆為佔位字串（`XXXXXX`），請換成實際網址，或刪除不需要的項目。
- **標籤（labels）**：模板中指定的標籤需先在 repo 建立，否則套用時 GitHub 會略過。詳見下方 [🏷️ 建立標籤（Labels）](#️-建立標籤labels)。
- **PR 模板區塊**：`PULL_REQUEST_TEMPLATE.md` 含「變更內容 / 注意事項 / 影響範圍」等勾選清單，可依專案流程增刪。

---

## 🏷️ 建立標籤（Labels）

各 Issue 模板會在送出時自動帶上對應標籤（見上方一覽表的「自動標籤」欄）。**但 GitHub 只會套用 repo 中「已存在」的標籤**——若標籤尚未建立，開 issue 時該標籤會被直接略過、不會自動建立。因此套用模板後，請先在 repo 建好以下標籤：

| 標籤名稱 | 用於模板 |
| --- | --- |
| `錯誤回報` | 🐛 Bug Report |
| `功能新增` | ✨ Feature Add |
| `功能修改` | ✨ Feature Change |
| `任務追蹤` | 🛠️ Task |
| `樣式調整` | 🎨 Feature (UI) |
| `技術調研` | 🔍 Spike |
| `文件需求/修正` | 📚 Documentation |
| `提問` | ❓ Support / Question |
| `線上事故` | 🚨 Incident |

### 方式一：手動建立

到 repo 的 **Settings → Labels → New label**，依上表逐一新增。

### 方式二：用 `gh` CLI 一次建好（推薦）

安裝並登入 [GitHub CLI](https://cli.github.com/) 後，在 repo 目錄執行（`--force` 可讓重複執行時更新既有標籤而不報錯）：

```bash
gh label create "錯誤回報"      --color d73a4a --description "Bug / 錯誤回報" --force
gh label create "功能新增"      --color 0e8a16 --description "Feature Add / 功能新增" --force
gh label create "功能修改"      --color 1d76db --description "Feature Change / 功能修改" --force
gh label create "任務追蹤"      --color fbca04 --description "Task / 任務追蹤" --force
gh label create "樣式調整"      --color c5def5 --description "UI / 版型樣式調整" --force
gh label create "技術調研"      --color 5319e7 --description "Spike / 研究試作" --force
gh label create "文件需求/修正" --color 0075ca --description "Documentation / 文件" --force
gh label create "提問"          --color cc317c --description "Support / Question" --force
gh label create "線上事故"      --color b60205 --description "Incident / 線上事故" --force
```

> 顏色（`--color`）為十六進位碼，可自由替換。在 PowerShell 中同樣可直接執行上述指令（一行一條）。

---

## 📝 PR 模板重點

`PULL_REQUEST_TEMPLATE.md` 引導送出者填寫：

- **變更內容**：分為「新增 / 調整 / 修正 / 移除」四類逐項列出（漏寫 = 漏測）
- **注意事項**：DB migration、設定檔變更、清快取、API 結構異動、第三方整合等檢查項
- **影響範圍**：前台 / 後台 / API / 排程 Queue / 其他

---

歡迎依需求 fork 並調整。貢獻方式請見 [`.github/CONTRIBUTING.md`](.github/CONTRIBUTING.md)。
