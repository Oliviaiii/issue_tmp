# GitHub Issue Form 語法教學

這份文件教你怎麼撰寫 **GitHub Issue 表單**（YAML 格式，副檔名 `.yml`，放在 `.github/ISSUE_TEMPLATE/` 底下）。
內容包含：頂層欄位、`body` 的 6 種元件、速查表，以及一份**包含全部元件的完整範例**可直接複製。

> 最後驗證日期：2026-07-17。Issue Forms 目前仍屬公開預覽功能，GitHub 可能調整欄位與驗證規則。

> 💡 本 repo 的 9 份模板都是用這套語法寫的，可搭配 [`.github/ISSUE_TEMPLATE/`](../.github/ISSUE_TEMPLATE/) 對照閱讀。

---

## 目錄

- [一、整體結構](#一整體結構)
- [二、頂層欄位](#二頂層欄位)
- [三、body 的 6 種元件](#三body-的-6-種元件)
  - [1. markdown — 純說明文字](#1-markdown--純說明文字)
  - [2. input — 單行輸入](#2-input--單行輸入)
  - [3. textarea — 多行輸入](#3-textarea--多行輸入)
  - [4. dropdown — 下拉選單](#4-dropdown--下拉選單)
  - [5. checkboxes — 核取方塊](#5-checkboxes--核取方塊)
  - [6. upload — 檔案上傳](#6-upload--檔案上傳)
- [四、速查表](#四速查表)
- [五、完整範例（含全部 6 種元件）](#五完整範例含全部-6-種元件)
- [六、常見地雷](#六常見地雷)

---

## 一、整體結構

一份 Issue 表單長這樣：

```yaml
name: "模板標題"          # ← 頂層欄位（選單上看到的）
description: "模板描述"
title: "[錯誤] "
labels: ["錯誤回報"]
body:                     # ← 表單內容，由一連串「元件」組成
  - type: markdown
    attributes:
      value: "提示文字"
  - type: textarea
    id: summary
    attributes:
      label: "問題描述"
    validations:
      required: true
```

分成兩層：

1. **頂層欄位** — 控制這份模板在「New issue」選單怎麼顯示、預設帶哪些標題/標籤。
2. **`body`** — 使用者實際要填的表單，由多個「元件」組成。

---

## 二、頂層欄位

| 欄位 | 必填 | 說明 | 範例 |
| --- | --- | --- | --- |
| `name` | ✅ | 「Create new issue」選單上看到的**模板標題** | `"🐛 錯誤回報"` |
| `description` | ✅ | 選單上的**模板描述** | `"回報系統異常..."` |
| `body` | ✅ | 表單內容（見第三節） | 一連串元件 |
| `title` | ❌ | 建立 issue 時**預設帶入的標題** | `"[錯誤] "` |
| `labels` | ❌ | 預設帶入的 label（陣列） | `["錯誤回報"]` |
| `assignees` | ❌ | 預設指派的人（陣列，須為協作者） | `["Oliviaiii"]` |
| `projects` | ❌ | 自動加入的 Project（`組織/數字`） | `["dgfactor/3"]` |
| `type` | ❌ | 預設的 **Issue Type**（**僅組織 repo 支援**，個人 repo 無效；**非** label） | `"Bug"` |

> ⚠️ `labels` / `assignees` / `type` 填的內容必須**事先在 repo / org 建立好**，否則送出時會被直接略過、不會自動建立。

> ⚠️ `projects` 只有在開票者對指定 Project 具有寫入權限時才會自動加入。公開 repository 通常應改用 Project 的 **Auto-add Workflow**，避免外部回報者沒有權限而加入失敗。

> 🏢 **`type`（Issue Type）只有「組織」帳號的 repo 才有。** 它在組織 Settings → Planning → **Issue types** 統一定義（預設 `Bug` / `Feature` / `Task`），該組織底下所有 repo 共用。**個人帳號（personal account）的 repo 不支援 Issue Types**，模板裡寫了 `type:` 會被直接忽略（不報錯、也沒效果）。給個人 repo 用的模板，分類請改用 `labels`。

`type` 和 `labels` 的差異：

| 比較項目 | `type`（Issue Type） | `labels`（標籤） |
| --- | --- | --- |
| 層級 | 組織層級 | repo 層級 |
| 個人 repo | ❌ 不支援 | ✅ 可用 |
| 一個 issue 數量 | 只能 1 個 | 可多個 |
| 用途 | issue 的「種類」分類 | 彈性標記 / 分流 |

---

## 三、body 的 6 種元件

每個元件的共同骨架：

```yaml
- type: <類型>          # 必填：markdown / input / textarea / dropdown / checkboxes / upload
  id: <唯一識別碼>       # 選填：給欄位一個 id（自動化 / API 可引用）
  attributes:            # 必填（markdown 以外）：這個元件的設定
    ...
  validations:           # 選填：驗證規則
    required: true
```

> ⚠️ Issue Forms 仍是公開預覽功能。請以 GitHub 官方文件與實際表單預覽結果為準，不要依賴過時的 repository 可見性限制說明。

---

### 1. markdown — 純說明文字

只顯示文字給使用者看，**不會出現在送出的 issue 內文**。常用來放開頭提示。

```yaml
- type: markdown
  attributes:
    value: |
      ## 🐛 Bug Report / 錯誤回報
      請盡量提供「可重現」的資訊，方便快速定位問題。
```

| attribute | 必填 | 說明 |
| --- | --- | --- |
| `value` | ✅ | 要顯示的 Markdown 文字 |

> `markdown` 沒有 `id`，也沒有 `validations`。

---

### 2. input — 單行輸入

適合短答案：時間、版本號、連結等。

```yaml
- type: input
  id: start_time
  attributes:
    label: "⏰ 發生時間（開始）"
    description: "請填可確定的時間點"
    placeholder: "例如：2025-12-03 10:20 (UTC+8)"
    value: ""                # 預設值（選填）
  validations:
    required: true
```

| attribute | 必填 | 說明 |
| --- | --- | --- |
| `label` | ✅ | 欄位標題 |
| `description` | ❌ | 欄位下方補充說明 |
| `placeholder` | ❌ | 灰色提示文字（**不會**被送出） |
| `value` | ❌ | 預設帶入的內容（**會**被送出） |

`validations`：`required: true/false`

---

### 3. textarea — 多行輸入

最常用，適合長描述、log、清單。

```yaml
- type: textarea
  id: logs
  attributes:
    label: "🧾 錯誤訊息 / Console / Log"
    description: "貼上錯誤訊息或 API 回應"
    placeholder: "可貼文字或截圖"
    value: ""
    render: shell           # ⭐ textarea 獨有
  validations:
    required: false
```

| attribute | 必填 | 說明 |
| --- | --- | --- |
| `label` | ✅ | 欄位標題 |
| `description` | ❌ | 補充說明 |
| `placeholder` | ❌ | 灰色提示文字（不送出） |
| `value` | ❌ | 預設內容（送出，常用來放 checklist 模板） |
| `render` | ❌ | 設了之後，內容會被包成**程式碼區塊**並語法上色（如 `shell`、`python`、`json`）；同時會關閉檔案拖放 / Markdown 編輯 |

**用 `value` 放預設模板**的技巧（讓使用者照著填）：

```yaml
value: |
  **預期結果：**
  （應該看到什麼）

  **實際結果：**
  （實際看到什麼）
```

> `placeholder` vs `value`：`placeholder` 是灰字提示、不送出；`value` 是真的填進去、會送出。

---

### 4. dropdown — 下拉選單

讓使用者從固定選項挑一個（或多個）。

```yaml
- type: dropdown
  id: severity
  attributes:
    label: "🔥 嚴重度"
    description: "大概是哪一級？"
    multiple: false          # 是否可複選
    options:
      - "P0 - 全站不可用"
      - "P1 - 主要功能受影響"
      - "P2 - 部分功能退化"
    default: 0                # 預設選第幾個（從 0 算，選填）
  validations:
    required: true
```

| attribute | 必填 | 說明 |
| --- | --- | --- |
| `label` | ✅ | 欄位標題 |
| `description` | ❌ | 補充說明 |
| `options` | ✅ | 選項陣列（至少一個；不可用保留字 `None`） |
| `multiple` | ❌ | `true` 可複選，預設 `false` |
| `default` | ❌ | 預設選中的**索引**（`0` = 第一個） |

`validations`：`required: true/false`

---

### 5. checkboxes — 核取方塊

一組勾選清單，每一項可各自設定是否必勾。

```yaml
- type: checkboxes
  id: pre_checks
  attributes:
    label: "✅ 送出前確認"
    description: "請確認以下事項"
    options:
      - label: "我已搜尋過沒有重複的 issue"
        required: true
      - label: "我願意協助測試修復結果"
        required: false
```

| attribute | 必填 | 說明 |
| --- | --- | --- |
| `label` | ✅ | 整組標題 |
| `description` | ❌ | 補充說明 |
| `options` | ✅ | 選項陣列，每項含 `label`（✅，支援 Markdown 連結）與 `required`（❌，預設 `false`） |

> ⚠️ `checkboxes` 的「必填」寫在**每個 option 裡的 `required`**，不是外層的 `validations`。

---

### 6. upload — 檔案上傳

提供獨立的檔案上傳區，適合收集截圖、錄影、紀錄檔或設計稿。說明文字應提醒使用者先移除 Token、Cookie、帳號與個人資料。

```yaml
- type: upload
  id: attachments
  attributes:
    label: "截圖或其他附件"
    description: "上傳前請先移除敏感資訊"
  validations:
    required: false
```

| attribute | 必填 | 說明 |
| --- | --- | --- |
| `label` | ✅ | 上傳區標題 |
| `description` | ❌ | 檔案用途與隱私提醒 |

`validations`：`required: true/false`

---

## 四、速查表

```
頂層：name* / description* / body* / title / labels / assignees / projects / type

body 元件：
┌─────────────┬───────────────────────────────────────────┬─────────────────────┐
│ type        │ 主要 attributes                           │ validations         │
├─────────────┼───────────────────────────────────────────┼─────────────────────┤
│ markdown    │ value*                                    │ ✗（無）             │
│ input       │ label* / description / placeholder / value│ required            │
│ textarea    │ label* / description / placeholder /      │ required            │
│             │ value / render                            │                     │
│ dropdown    │ label* / description / options* /         │ required            │
│             │ multiple / default                        │                     │
│ checkboxes  │ label* / description / options*           │ 寫在 option 內的     │
│             │ （每項：label* / required）               │ required            │
│ upload      │ label* / description                      │ required            │
└─────────────┴───────────────────────────────────────────┴─────────────────────┘
  * = 必填        id = markdown 以外皆可加（選填）
```

---

## 五、完整範例（含全部 6 種元件）

把下面整段存成 `.github/ISSUE_TEMPLATE/00-demo.yml` 就能在 repo 看到實際效果。
它示範了**全部 6 種元件**與常用屬性：

```yaml
name: "🧪 元件教學範本"
description: "示範 Issue Form 全部 6 種元件的寫法"
title: "[教學] "
labels: ["待確認"]
# assignees: ["your-github-id"]   # 選填：預設指派的人（須為協作者）
# type: "Task"                    # 選填：Issue Type（須先在 org 建立）
body:
  # 1️⃣ markdown：純說明，不會出現在送出的 issue 內文
  - type: markdown
    attributes:
      value: |
        ## 🧪 Demo 範本
        這份表單示範 Issue Form 的 6 種元件，僅供教學參考。

  # 2️⃣ input：單行輸入（適合短答案）
  - type: input
    id: version
    attributes:
      label: "📦 版本號"
      description: "發生問題的系統 / App 版本"
      placeholder: "例如：v1.2.3"
    validations:
      required: true

  # 3️⃣ textarea：多行輸入（最常用）
  - type: textarea
    id: description
    attributes:
      label: "📌 問題描述"
      description: "請詳細說明，可用 value 預先帶入模板"
      value: |
        **預期結果：**
        （應該看到什麼）

        **實際結果：**
        （實際看到什麼）
    validations:
      required: true

  # 3️⃣-b textarea + render：內容會被包成程式碼區塊並語法上色
  - type: textarea
    id: logs
    attributes:
      label: "🧾 錯誤 Log（選填）"
      description: "貼上 console / log，會自動套用語法上色"
      render: shell
    validations:
      required: false

  # 4️⃣ dropdown：下拉選單
  - type: dropdown
    id: severity
    attributes:
      label: "🔥 嚴重度"
      description: "選一個最接近的等級"
      multiple: false
      options:
        - "P0 - 全站 / 核心服務不可用"
        - "P1 - 主要功能受影響"
        - "P2 - 部分功能退化"
        - "P3 - 輕微異常"
      default: 1
    validations:
      required: true

  # 4️⃣-b dropdown + multiple：可複選
  - type: dropdown
    id: platform
    attributes:
      label: "💻 受影響平台（可複選）"
      multiple: true
      options:
        - "Web 前台"
        - "Web 後台"
        - "iOS"
        - "Android"
    validations:
      required: false

  # 5️⃣ checkboxes：核取方塊（每項可各自設 required）
  - type: checkboxes
    id: pre_checks
    attributes:
      label: "✅ 送出前確認"
      description: "請勾選以下事項"
      options:
        - label: "我已搜尋過沒有重複的 issue"
          required: true
        - label: "我已附上重現步驟或截圖"
          required: false
        - label: "我願意協助測試修復結果"
          required: false

  # 6️⃣ upload：檔案上傳
  - type: upload
    id: attachments
    attributes:
      label: "📎 截圖或其他附件"
      description: "上傳前請先移除 Token、Cookie、帳號與個人資料"
    validations:
      required: false
```

---

## 六、常見地雷

| 狀況 | 原因 / 解法 |
| --- | --- |
| 套用標籤沒生效 | 標籤必須**先在 repo 建立**，否則送出時被略過。見 [README 的繁體中文 Labels 章節](../README.md#繁體中文-labels) |
| 必填驗證與預期不同 | Issue Forms 仍屬公開預覽，請依目前官方文件與表單預覽實測，不要沿用舊版可見性限制說明 |
| `projects` 沒有自動加入 | 開票者需要指定 Project 的寫入權限；公開回報流程建議改用 Auto-add Workflow |
| `type` 設了沒效果 | Issue Types **只有組織 repo 支援**，個人 repo 會直接忽略 |
| dropdown 選項放 `None` | `None` 是保留字，不能當選項文字，改成「無 / 不適用」等 |
| checkboxes 必填沒作用 | 必填要寫在 **option 的 `required`**，不是外層 `validations` |
| 表單沒出現在選單 | 檔案要放在 `.github/ISSUE_TEMPLATE/` 且副檔名為 `.yml`；YAML 縮排錯誤會整份失效 |
| 中文 / emoji 顯示亂碼 | 檔案請存成 **UTF-8（不含 BOM）** 編碼 |

---

📚 官方文件：[Syntax for issue forms](https://docs.github.com/en/communities/using-templates-to-encourage-useful-issues-and-pull-requests/syntax-for-issue-forms)
