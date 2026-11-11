# GitHub Projects 完整教學

> 本文介紹的是新版 **Projects(ProjectsV2)**,而非舊版 Projects Classic。
> Projects 是一個「可跨 repo 的規劃工具」,把 **Issue / Pull Request** 整合在一起,用來做 backlog 管理、衝刺規劃(sprint)、產品藍圖等。可在「使用者層級(個人)」或「組織層級(團隊)」建立。

> 📷 本文所有截圖皆來自實際操作:以 `issue_tmp` repo 的 issues 建立的公開範例 Project **[「Penance Manager｜GitHub 專案管理繁中完整範例」](https://github.com/users/Oliviaiii/projects/1)**,你可以跟著每一步操作一次。
>
> 最後驗證日期：2026-11-11。GitHub Projects 介面更新頻繁，若畫面位置不同，請以功能名稱與官方文件為準。

這份教學把官方文件與實務細節整理在一起,適合第一次接觸 Projects 的人從頭讀:

- Project 核心觀念與「一個 Project,三種視圖」
- 所有欄位:內建欄位 + 五種自訂欄位(Text / Number / Date / Single select / Iteration)
- 三種版面:Table / Board / Roadmap 的完整用法與設定
- 建立 Project、把項目加進來的各種方式
- 自動化(內建 workflow / GitHub Actions / API)、Insights 圖表、Project 層級設定
- 權限協作、`gh` CLI 操作、給 PM 的實務建議

---

## 一、核心觀念:一個 Project = 三種視圖共用一份資料

新版 Projects 的核心設計精神是:

> **同一個 Project = 一份資料表,可以用三種版面(Layout)來呈現。**

你建立一個 Project 之後,可以在裡面切換三種視圖:

- **Table(表格)** — 像試算表,一列一個 item
- **Board(看板)** — 可拖拉卡片
- **Roadmap(時間軸)** — 視覺化排程

同一個 item(例如某個 issue)會在三種視圖裡同時存在,只是呈現角度不同。你可以針對各視圖個別設定篩選、分組、排序、要顯示哪些欄位,但這些設定**只影響當前視圖,不會動到其他視圖**。

換句話說:**資料只有一份,view 只是不同的看法。** 改一個 item 的欄位值,所有 view 同步更新;但「怎麼排、怎麼篩、看哪些欄」則是每個 view 各自決定。

---

## 二、Project 裡的「元素」

Project 由三種東西組成:**Items(項目)**、**Fields(欄位)**、**Views(視圖)**。

### 1. Items(項目)

Item 就是 Project 裡的每一筆資料,只能在 Project 裡建立,類型有三種:

- **Issue** — 從 repo 拉進來的 issue
- **Pull Request** — 從 repo 拉進來的 PR
- **Draft issue(草稿)** — 直接在 Project 內建立的草稿項目,有標題、內文與 metadata,之後可一鍵轉成正式 issue

> 💡 Draft issue 很適合「先把點子丟進 backlog」—— 還沒想清楚要進哪個 repo 也沒關係,先記下來,稍後再轉成正式 issue。

在任一視圖點擊 item 標題,右側會滑出**詳情面板**,可直接檢視 issue 內容、修改 Status、Assignees、Labels 等所有欄位。面板中的 **Projects** 區塊會展開這個 item 在本 Project 的所有欄位值(Status、Priority、Start date、Target date…),可在此一次改完:

![item 詳情面板](img/10-item-panel.png)
*點開 item 後的右側詳情面板,Projects 區塊展開了 Status、Priority、Start/Target date,可直接修改*

### 2. Fields(欄位)

每一個 item 都可以掛各種欄位(metadata),分兩類:

- **內建欄位** — 系統內建、欄位類型不可刪除,如 Title、Assignees、Status、Labels、Milestone、Repository、Issue Type 等。
- **自訂欄位** — 你自己建立的欄位,共五種:**Text(文字)**、**Number(數字)**、**Date(日期)**、**Single select(單選)**、**Iteration(疊代)**。

每個自訂欄位都會在三種視圖中出現,且每個 Project 都可以定義自己的一套自訂欄位。(完整列表見[第三節](#三欄位fields完整列表)。)

### 3. Views(視圖)

Views 就是 Table、Board、Roadmap 這三種版面。

- 每個視圖都可獨立套用 **篩選(filter)、排序(sort)、分組(group)、切片(slice)、欄位顯示/隱藏** 等設定。
- 你可以建立**多個**視圖,例如「Bug Board」「Feature Table」「Frontend Roadmap」並排放。
- 新建立的 Project 會自動帶有預設視圖(通常是一個 Table view)。
- 所有視圖**共用同一份資料(Items)**;對某個視圖做的設定,只影響該視圖。

---

## 三、欄位(Fields)完整列表

### A. 內建欄位(系統提供,無法刪除類型)

| 欄位 | 說明 |
| :--- | :--- |
| `Title` | 標題 |
| `Assignees` | 指派人(可多人) |
| `Status` | 狀態(內建 single select,且是 Board 的預設分欄欄位) |
| `Labels` | 標籤(可多個) |
| `Milestone` | 里程碑 |
| `Repository` | 所屬 repo |
| `Issue Type` | issue 類型 |
| `Parent issue` | 父 issue |
| `Sub-issue progress` | 子 issue 進度 |
| `Linked pull requests` | 關聯的 PR |
| `Reviewers` | PR 的審查者 |

**怎麼修改某個 item 的 Status?** 最快的方式是在 Table 視圖直接點該列的 Status 儲存格,從下拉選單挑選;Board 視圖則是直接把卡片拖到別欄。

![修改 Status](img/07-status-dropdown.png)
*在 Table 中點 Status 儲存格即可切換狀態；公開範例使用「待整理、開發就緒、進行中、人工驗收、待發布、已完成、不處理」*

**怎麼新增/修改 Status 的選項?** Status 本身是一個 single select 欄位,選項可自由增改:

1. 進入 Project 右上 **⋯ → Settings**
2. 左側 **Custom fields** 區點 **Status**
3. 在 **Options** 區塊可拖拉排序、點 **⋯** 重新命名/改顏色/刪除,或在底部 **Add option...** 輸入新選項(例如 `👀 人工驗收`)後按 **Add**

![Status 欄位設定](img/08-status-field-settings.png)
*Status field settings:新增「👀 人工驗收」後,新選項會立即出現在所有視圖*

> **關於 Issue Type**
>
> - 在**組織層級**可自訂 issue types:內建有 Bug、Feature、Task,可再新增自訂類型。
> - 這是一個「單選」概念,每個 issue 只能有一個 type。
>
> **關於 Issue fields（跨 Project 共用欄位）**
>
> - 個人或組織擁有者可定義統一的結構化欄位（例如 priority、effort、dates），讓同一擁有者的 Issues 與 Projects 共用欄位值。
> - Issue fields 只適用於同一個人或組織擁有的 Issues。Pull Request、draft issue 或其他擁有者的 Issue 會顯示空值。
> - 每個 Project 最多支援 50 個欄位，Issue fields 與系統欄位也會計入上限。

### B. 自訂欄位類型(共五種)

**怎麼新增自訂欄位?** 在 Table 視圖最右側點 **+** → **New field**,輸入名稱、選擇類型即可。這個 **+** 選單同時也是控制欄位顯示/隱藏的地方:

![欄位選單](img/11-field-menu.png)
*Table 右上 + 選單:New field 與 Visible/Hidden fields 切換*

![新增欄位](img/12-new-field-popup.png)
*輸入欄位名稱後選擇 Field type*

![五種欄位類型](img/13-field-types.png)
*五種自訂欄位類型:Text / Number / Date / Single select / Iteration*

> 💡 選 **Single select** 時會多出 Options 區塊,可逐一加入選項(例如 `P0 緊急`、`P1 高`、`P2 一般` 的 Priority 欄位)。

| 類型 | 說明 | 篩選語法範例 |
| :--- | :--- | :--- |
| **Text** | 自由文字、備註 | `field:"exact text"` |
| **Number** | 數字,如工時、複雜度 | `field:>=10`、`field:10..20`(範圍) |
| **Date** | 用打字或日曆挑日期 | 可用於篩選與排序 |
| **Single select** | 單選下拉,每個選項可設顏色與描述 | `field:option`、`field:option1,option2`(多值) |
| **Iteration** | 疊代,規劃 sprint / 週期,自動帶日期範圍 | `field:@current`、`@next`、`@previous` |

**Single select 的幾點注意**

- 最多可有 **50 個選項**,每個選項可設顏色與描述,顏色會顯示在看板卡片的標籤上。
- 可設**預設值**,新項目自動帶入。
- 單選就是單選 —— 若你需要一個項目同時掛多個標籤,改用內建的 `Labels`,或另開一個用途不同的欄位。

**Iteration 欄位的用法與語法**

Iteration 是「週期 / 區間」欄位,專門用來規劃 sprint 或其他開發週期。每個疊代可設定:

- **Start(開始日)** 與 **長度**(天 / 週)—— 系統會自動算出結束日
- **Break(中斷)** —— 代表休假或非開發週,會被自動排除在疊代之外

它有內建的自動化語法,**會隨時間自動更新指向**,不用每週手動改:

- `@current` —— 自動指向「今天落在的疊代」
- `@next` —— 下一個疊代
- `@previous` —— 上一個疊代

> ⚠️ Iteration 只能在 **Project 層級**建立,無法當成獨立的 repo / 組織層級 Issue 自訂欄位來用。

---

## 四、三種視圖(Layout)完整用法

要新增視圖,點視圖分頁列的 **+ New view**,選擇 Layout(Table / Board / Roadmap),也可以 **Duplicate view** 複製現有視圖再調整:

![新增視圖](img/14-new-view-menu.png)
*+ New view 選單:選擇要新增的 Layout*

### 1. Table(表格)

![Table 視圖](img/04-table-view.png)
*「📊 全部工作」依優先順序分組，同時顯示 Status、旗標、模組與負責人等欄位*

- **長什麼樣子**
  - 一列一個項目,欄位名稱是欄標頭,類似試算表,可一次看到所有欄位。
- **適合用在**
  - 瀏覽大量項目、當作 backlog 或清單、批次編輯。
- **核心功能與設定**
  - **顯示/隱藏欄位(Show/hide fields)**:自訂這個 view 要顯示哪些欄位。
  - **排序(Sort)**:可指定欄位升冪 / 降冪,table 還能加**次要排序**。
  - **分組(Group)**:依某欄位把項目分成一段一段(例如依 Status 分組)。
  - **篩選(Filter)**:用查詢語法只顯示符合的項目(語法見[第六節](#六篩選語法filter))。
  - **欄位 / 列重新排序**:直接拖拉欄頭或某一列調整順序。
  - **Field sum(欄位加總)**:對數字欄位顯示總和或項目數;啟用分組後會顯示在每組標頭。

### 2. Board(看板 / Kanban)

![Board 視圖](img/15-board-view.png)
*Board 視圖:依 Status 分成「待整理 → 開發就緒 → 進行中 → 人工驗收 → 待發布 → 已完成」*

![拖拉卡片](img/16-board-drag.png)
*把卡片從「待整理」拖到「開發就緒」後,該 item 的 Status 自動變更,欄頂計數同步更新*

- **長什麼樣子**
  - 把項目排成一張張可拖拉的卡片,分在不同直欄裡。
- **適合用在**
  - 追蹤工作流動狀態(待整理 → 開發就緒 → 進行中 → 人工驗收 → 待發布 → 已完成)。
- **核心功能與設定**
  - **Column field(直欄欄位)**:預設用 `Status` 當直欄,但可改用**任何 single select 或 iteration 欄位**。
  - **拖拉即改值**:把卡片拖到別欄,該項目對應的欄位值會**自動跟著改**(例如拖到「已完成」,Status 就變成「🎉 已完成」)。
  - **Column limit(卡片數上限)**:可為單一直欄設上限,**僅作提示、不強制**,用來提醒某欄塞太多。
  - **水平分組(Group)**:除了直欄,還能再依另一個欄位做橫向分組。
  - **Field sum**:顯示在每個直欄頂端,方便看每欄負載。

> ⚠️ Board 一旦套用排序,欄內就**不能再手動拖拉重排**,但仍可跨欄移動卡片。

### 3. Roadmap(藍圖 / 時間軸)

![Roadmap 視圖](img/18-roadmap.png)
*Roadmap 視圖:剛建立時會提示「需要至少一個 date 或 iteration 欄位」才能在時間軸上排項目*

- **長什麼樣子**
  - 把項目擺在一條時間軸上,做高階的時程視覺化。
- **適合用在**
  - 產品藍圖、跨期規劃、對 stakeholder 報告整體進度。
- **核心功能與設定**
  - **用日期 / iteration 欄位定位**:項目在時間軸上的落點,由你選的**日期欄位**或 **iteration 欄位**決定。
  - **拖拉即改期**:直接拖項目就能改它的起訖日或所屬疊代。
  - **時間軸標線(Markers)**:可顯示垂直標線標出關鍵日期(疊代、里程碑、項目日期)。
  - **時間跨度**:可切換以週 / 月 / 季 等不同尺度檢視。

#### Roadmap 設定步驟(完整示範)

Roadmap 剛建立時是空的,因為它不知道要用哪個欄位來定位項目。照以下步驟設定:

**1. 點右上 `Date fields`(日期欄位)** —— 這裡決定時間軸用哪兩個欄位當「開始」與「結束」。一個全新的 Project 還沒有日期欄位,所以兩邊都是 No start date / No target date:

![Date fields 選單](img/18b-roadmap-datefields.png)
*右上 Date fields 選單,可分別指定 Start date 與 Target date 欄位*

**2. 點選單裡的 `+ New field` 建立日期欄位** —— Field type 選 **Date**,先建一個 `Start date`,再重複一次建 `Target date`:

![新增日期欄位](img/18c-roadmap-newfield.png)
*建立 Date 類型的欄位(這裡建 Target date);建好後 GitHub 會自動把它指派為對應的日期欄位*

> 💡 建好兩個日期欄位後,回到 Date fields 選單會看到 Start date 區與 Target date 區各自打勾,Roadmap 就啟用了。

**3. 在時間軸上排程** —— 有了日期欄位後,把游標移到某列的時間軸區域會出現 **+**,點一下就在那天建立排程點;也可以直接**拖拉**長條兩端調整起訖、或整條左右拖移改期。另一個更精確的方式是**點開 item 詳情面板**,直接在 Start date / Target date 欄位用日曆挑日期(見下圖)。

![排好程的 Roadmap](img/18d-roadmap-scheduled.png)
*「🗓️ 產品路線圖」使用開始日期與目標日期排出每個項目的時間範圍，並包含真正跨月的教學資料*

> ⚠️ 若只填 Start date 沒填 Target date,項目在時間軸上會是單一個點;兩個日期都填才會畫成有長度的長條。Iteration 欄位也可當定位依據,適合用 sprint 週期來排。

---

## 五、各視圖的設定選項對照

不同設定在不同 layout 的支援程度不一樣,整理成一張對照表:

| 設定 | 作用 | Table | Board | Roadmap |
|:---|:---|:---:|:---:|:---:|
| **Filter(篩選)** | 用查詢語法只顯示符合的項目 | ✅ | ✅ | ✅ |
| **Sort(排序)** | 依欄位值排序,table 可加次要排序 | ✅ | ✅* | ✅ |
| **Group(分組)** | 依欄位把項目分成區塊;board 可水平分組 | ✅ | ✅ | ✅ |
| **Slice(切片)** | 側邊面板列出某欄位的值,點一下就過濾該值 | ✅ | ✅ | ✅ |
| **Field sum(欄位加總)** | 顯示數字欄位的總和或項目數量 | ✅ | ✅ | ✅ |
| **Show/hide fields** | 控制哪些欄位出現 | ✅ | — | — |
| **Column field(直欄欄位)** | 設定看板用哪個欄位當直欄 | — | ✅ | — |
| **Column limit(卡片數上限)** | 單一直欄的卡片數上限(僅提示) | — | ✅ | — |
| **欄位 / 列重新排序** | 拖拉調整欄位或列順序 | ✅ | — | — |
| **時間軸標線 / 區間** | roadmap 上的關鍵日期標線、時間跨度 | — | — | ✅ |

> *Board 排序後,欄內就不能手動拖拉重排,但仍可跨欄移動。
> Slice 不能用 `title`、`reviewers`、`linked PR` 來切。
> Field sum 在 board 顯示在每欄頂端;table / roadmap 啟用分組後顯示在每組標頭。

---

## 六、篩選語法(Filter)

在任一 view 上方的篩選列輸入查詢語法,即可只顯示符合的項目。

![篩選](img/17-filter.png)
*「🤖 AI Ready」使用 `status:"📌 開發就緒" 執行方式:"🤖 AI" 🤖-AI-認領:"⚪ 未認領"`，只顯示內容已收斂且尚未取票的 AI 任務*

記住兩個規則就能組合出大部分查詢:

- **多個條件用空白分隔 = AND**(同時成立)
- **同一欄位用逗號分隔 = OR**(其中之一)
- **前面加 `-` = 排除**

常用範例:

| 語法 | 作用 |
| :--- | :--- |
| `status:"📌 開發就緒"` | 篩選含空白或 emoji 的單選值 |
| `label:bug,urgent` | 多值(逗號 = OR) |
| `assignee:@me` | 指派給自己 |
| `迭代週期:@current` | 目前疊代(欄位名稱需與 Project 完全一致) |
| `no:assignee` | 沒有指派人 |
| `is:open` / `is:closed` | 依開關狀態 |
| `is:issue` / `is:pr` | 依項目類型 |
| `effort:>=5` | 數字欄位比較 |
| `effort:5..15` | 數字欄位範圍 |
| `-label:wontfix` | 排除某標籤 |

---

## 七、建立 Project 與加入項目

### 1. 建立 Project

- **個人 Project**:到你的 GitHub 個人頁 → **Projects** 分頁 → **New project**。
- **組織 Project**:到組織頁 → **Projects** 分頁 → **New project**。

![Projects 分頁](img/01-projects-tab.png)
*個人頁的 Projects 分頁,右側綠色按鈕即是 New project*

- 可從**空白範本**或**內建範本**(Team planning、Feature release、Kanban、Roadmap 等)開始,範本會預先帶好一組欄位與 view。

![選擇範本](img/02-create-template.png)
*Create project 視窗:左側可從空白的 Table / Board / Roadmap 開始,右側是內建範本*

- 選「Start from scratch」的版面後,輸入 **Project name**;勾選 **Import items from repository** 可在建立的同時把某個 repo 的 open issues 全部匯入(下方會預告將加入幾個項目),按 **Create project** 完成。

![匯入 repo issues](img/03-create-import.png)
*建立時勾選 Import items from repository,從 issue_tmp 匯入全部 open issues*

### 2. 把項目加進來

加入項目有好幾種方式,挑順手的用:

- **從 Project 內新增** —— 在 table / board 底部的 **+ Add item**,可直接輸入文字建立 draft。
- **貼上網址** —— 在 + Add item 輸入框貼 issue / PR 的完整 URL,即可拉進來。
- **搜尋既有 issue/PR** —— 在 + Add item 輸入 `#` 觸發搜尋,先選 repo 再挑選(或關鍵字搜尋)要加入的 issue / PR。

![以 # 搜尋 repo](img/05-add-item-repo.png)
*在 + Add item 輸入 `#` 後會列出可選的 repo,選定後即可搜尋該 repo 的 issue/PR*

![Add item 選單](img/06-add-item-menu.png)
*直接輸入文字則出現三個選項:Create new issue、Create a draft(Ctrl+⏎)、Add item from repository*
- **從 issue/PR 側欄** —— 打開某個 issue/PR,右側欄 **Projects** → 選擇要加入的 Project。
- **自動化加入** —— 用內建的 **Auto-add** 工作流,或 GitHub Actions(見下一節)。

---

## 八、自動化(Automation)

Projects 的自動化由淺到深有三層:內建工作流 → GitHub Actions → GraphQL API。

### 1. Built-in workflows(內建工作流)

不用寫程式,在 Project 右上 **Workflows**(或 ⋯ 選單 → Workflows)開關設定即可:

![Workflows 列表](img/19-workflows.png)
*Workflows 頁面:左側是所有內建工作流,綠點代表已啟用,右上可切換 On/Off 或 Edit*

![Item closed 工作流](img/20-workflow-item-closed.png)
*「Item closed」工作流:當 issue/PR 關閉時,自動把 Status 設為「🎉 已完成」*

公開範例目前啟用 6 個 Workflow：Auto-add sub-issues、Auto-add、Auto-close、Item closed、Pull request merged，以及 `Item added to project → 📥 待整理`。後者確保自動加入或手動加入的 Issue／PR 不會落在沒有 Status 的空白區。

常用的有:

| 工作流 | 作用 |
| :--- | :--- |
| **Item added to project** | 項目加入時自動設定欄位(本範例為 Status → 📥 待整理) |
| **Item closed** | issue/PR 關閉時設定欄位(本範例為 → 🎉 已完成) |
| **Pull request merged** | PR 合併時設定(本範例為 → 🎉 已完成) |
| **Item reopened** | 重新開啟時設定狀態 |
| **Code changes requested / approved** | 依審查結果設定狀態 |
| **Auto-add to project** | 符合篩選條件的 repo 項目自動加進 Project |
| **Auto-archive items** | 符合條件的項目自動封存 |

> ⚙️ Project 剛建立時,預設就啟用兩個工作流:
> 1. issue/PR 關閉 → Status 設為 **🎉 已完成**
> 2. PR 合併 → Status 設為 **🎉 已完成**

### 2. GitHub Actions

需要更進階的邏輯時,用 workflow 檔。GitHub 官方維護的 [`actions/add-to-project`](https://github.com/actions/add-to-project) 可把當前 issue/PR 自動加進 Project:

```yaml
# .github/workflows/add-to-project.yml
name: Add issues to project
on:
  issues:
    types: [opened]
jobs:
  add-to-project:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/add-to-project@v1
        with:
          project-url: https://github.com/orgs/<org>/projects/<number>
          github-token: ${{ secrets.ADD_TO_PROJECT_PAT }}
```

> ⚠️ 一個 Project 可跨多個 repo,但一份 Actions workflow **綁定單一 repo**,所以需要每個 repo 各放一份。

### 3. GraphQL API(ProjectsV2 API)

自由度最高,可程式化讀寫 Project 的項目與欄位值,搭配 webhook 事件做整合。注意 Projects v2 **只有 GraphQL API**,沒有 REST 端點。

---

## 九、Insights(圖表洞察)

在 Project 右上角進入 **Insights**,用 Project 的項目當資料來源畫圖表。

![Insights](img/21-insights.png)
*「📦 各模組預估工時」以模組為 X 軸、加總預估工時，快速辨識量能集中在哪個領域*

![各 Sprint 狀態分布](img/23-insights-sprint.png)
*「🏃 各 Sprint 狀態分布」以迭代週期為 X 軸、依 Status 分組，可看每期工作目前停在哪個階段*

### 兩類圖表

- **Current charts(當前)** —— 呈現目前狀態,例如各人負責幾項、各疊代有幾個 issue。
- **Historical charts(歷史)** —— X 軸設為「Time」,呈現隨時間變化;預設的 **Burn up** 圖可看完成與剩餘工作的趨勢。

公開範例可直接查看：

- [Status chart](https://github.com/users/Oliviaiii/projects/1/insights/1)：各流程狀態的項目數。
- [📦 各模組預估工時](https://github.com/users/Oliviaiii/projects/1/insights/2)：各模組工時加總。
- [🏃 各 Sprint 狀態分布](https://github.com/users/Oliviaiii/projects/1/insights/3)：每個 Iteration 的狀態分布。

### 圖表設定

- **圖表類型**:長條(bar)、直條(column)、折線(line)、堆疊面積(stacked area)。
- **彙總函數**:sum、count、average、min、max。
- 可設定 **filter、X 軸、Y 軸、分組**。
- 圖表可**持久保存**並用 **URL 分享**,凡能看 Project 的人都看得到。

> ⚠️ Insights **不追蹤**已封存或已刪除的項目。

---

## 十、Project 層級設定

從 Project 右上 **⋯ → Settings** 進入,可改名稱、預設 repo、簡介與 README;改名、Close、Delete、調整可見性都在這裡:

![Project settings](img/09-project-settings.png)
*Project settings:公開範例命名為「Penance Manager｜GitHub 專案管理繁中完整範例」;Custom fields 也列在左側*

| 設定 | 說明 |
| :--- | :--- |
| **Visibility(可見性)** | Project 可設為 **public** 或 **private** |
| **Templates(範本)** | 可把 Project 設為範本供組織內共用。範本包含 views、自訂欄位、草稿項目與欄位、已設定的 workflows(**不含** auto-add 工作流)、insights |
| **連結到 team / repo** | 可把 Project 加到某 team(整個團隊取得協作權限),或加到同擁有者的 repo |
| **Status updates(狀態更新)** | 可在 Project 層級貼進度更新(如 On track / At risk / Off track) |
| **Archive(封存)** | 項目可封存而非刪除,保留資料但移出作用中視圖,之後可再還原 |

---

## 十一、權限與協作

![Manage access](img/22-access.png)
*Settings → Manage access:邀請協作者並指派 Read / Write / Admin 角色*

- **個人 Project**:擁有者可邀請協作者,並指派 **Read / Write / Admin** 角色。
- **組織 Project**:可設定 **base role**(組織成員的預設權限,如 no access / read / write / admin),再針對個別成員或 team 加權限。
- 把 Project **連結到 team**,整個團隊就會取得對應的協作權限,免去逐一邀請。

| 角色 | 可做的事 |
| :--- | :--- |
| **Read** | 檢視 Project 與 view |
| **Write** | 編輯項目、欄位值、建立 view |
| **Admin** | 上述全部 + 管理設定、權限、刪除 Project |

---

## 十二、從 Issue 到發布的完整範例

公開範例把不同層級的資料分開管理：

| 工具 | 管理範圍 | 公開範例 |
| :--- | :--- | :--- |
| Issue | 一個可驗收的需求或問題 | [AI 任務 #8](https://github.com/Oliviaiii/issue_tmp/issues/8) |
| Parent / Sub-issues | 大功能與可分工的子任務 | [父議題 #11](https://github.com/Oliviaiii/issue_tmp/issues/11)、[#12](https://github.com/Oliviaiii/issue_tmp/issues/12)、[#13](https://github.com/Oliviaiii/issue_tmp/issues/13) |
| Iteration | 這一個 Sprint 要做什麼 | `Sprint 2026-11｜Project 教學` |
| Milestone | 哪些 Issue 屬於同一版本或發布目標 | [`v1.0 教學範例`](https://github.com/Oliviaiii/issue_tmp/milestone/1) |
| Pull Request | 實際改了哪些檔案、測試是否通過 | [文件範例 PR](https://github.com/Oliviaiii/issue_tmp/pulls?q=is%3Apr+is%3Aclosed) |
| Project | 跨 Issue／PR 的狀態、排序、排程與決策 | [工作流程看板](https://github.com/users/Oliviaiii/projects/1/views/1) |

### 建議操作順序

1. 使用 Issue Form 建立需求；表單自動加上類型與「待確認」Label。
2. 產品負責人完成分類後移除「待確認」，填入 Priority、Size、Iteration、日期與負責人。
3. 大型工作建立 Parent issue，再拆成可獨立驗收的 Sub-issues。
4. 開發者或 Agent 建立 branch，完成修改與測試後開 Pull Request。
5. PR 內使用 `Closes #6` 等關鍵字建立正式關聯。
6. CI 通過、人工確認 Diff 與行為後再 Merge；不要把「AI 已檢查」當成人工驗收。
7. Merge／關閉後由 Workflow 把 Project Status 更新為「🎉 已完成」。
8. Milestone 內所有工作完成後，再由負責人決定是否發布與關閉 Milestone。

### Repository Rules：公司專案不要只靠口頭約定

到 Repository **Settings → Rules → Rulesets**（舊介面可能顯示 Branch protection rules），建議至少針對 default branch 設定：

- 必須透過 Pull Request 合併，避免直接 push 到正式分支。
- 必要的 GitHub Actions／測試必須通過。
- 視團隊規模要求一位以上 Reviewer；個人教學 repo 可先設為 0，避免自己無法示範。
- 禁止 force push 與刪除 default branch。
- 合併後自動刪除 branch，保持分支清單乾淨。

> Template Repository 主要複製檔案，不等於複製 Repository 權限、Secrets、Rulesets 與 Project Auto-add。新 repo 建好後必須另外檢查這些設定。

---

## 十三、用 gh CLI 操作 Project

要批次或自動化操作時,GitHub CLI 的 `gh project` 指令很好用。需先安裝 [GitHub CLI](https://cli.github.com/) 並補上 `project` scope:

```bash
# 授權加上 project scope
gh auth refresh -s project,read:project

# 列出某個擁有者(個人或組織)的 Project
gh project list --owner <user-or-org>

# 檢視某個 Project(用 number)
gh project view <number> --owner <owner>

# 建立 Project
gh project create --owner <owner> --title "2026 Q3 Roadmap"

# 把 issue / PR 加進 Project
gh project item-add <number> --owner <owner> --url https://github.com/<owner>/<repo>/issues/123

# 在 Project 內新增 draft item
gh project item-create <number> --owner <owner> --title "調查登入逾時" --body "細節..."

# 列出欄位 / 列出項目
gh project field-list <number> --owner <owner>
gh project item-list  <number> --owner <owner>

# 以 Issue URL、欄位名稱與選項名稱修改欄位
gh project item-edit <number> --owner <owner> \
  --url https://github.com/<owner>/<repo>/issues/123 \
  --field "Status" --value "🔨 進行中"

# 自動化腳本也可用 GraphQL node IDs 精準修改
gh project item-edit --id <item-id> --field-id <field-id> --project-id <project-id> --single-select-option-id <option-id>
```

> 💡 需要更細的程式化操作(如批次改欄位值)時,`gh api graphql` 可直接打 ProjectsV2 GraphQL API。

---

## 十四、實務建議:雙產品線 PM 怎麼用

如果你同時管兩條產品線(例如 CMS / OTT),推薦這套做法:

1. **一個 Project,多個 view**
   與其開兩個 Project,不如用**一個 Project** + 一個 single select 欄位(如 `Product Line: CMS / OTT`)區分,再為每條產品線各建一個套好篩選的 **board view**。資料集中,還能跨線比較。

2. **各自的 sprint 節奏**
   若兩條線疊代週期不同,可開**兩個 iteration 欄位**分別跑,view 各自用 `@current` 過濾,互不干擾。

3. **用 Field sum 看負載**
   加一個 Number 欄位(如 `Effort`),在 board 每欄頂端看加總,快速判斷某狀態 / 某人是否過載。

4. **auto-add 自動化**
   用 **Auto-add** 工作流把「特定 repo + 特定 label」的 issue 自動匯入 Project,省去手動加項目。

5. **Insights 做週報**
   用 **historical burn up** 圖追蹤每條產品線的完成趨勢,把 URL 直接分享給 stakeholder,免截圖。

---

## 十五、給 AI Agent 協作的推薦欄位

如果 Project 會同時給 PM、工程師與 AI Agent 使用，不要把「工作進度」「部署位置」「驗收結果」全部塞進同一個 Status。建議拆成：

| 欄位 | 回答的問題 | 範例值 |
| :--- | :--- | :--- |
| `Status` | 現在工作做到哪裡 | 📥 待整理 / 📌 開發就緒 / 🔨 進行中 / 👀 人工驗收 / 🚀 待發布 / 🎉 已完成 |
| `執行方式` | 預計由誰執行 | 👤 人工 / 🤖 AI / 🤝 人機協作 |
| `執行環境` | 程式目前在哪個環境 | 💻 本機 / 👁️ Preview / 🧪 Staging / 🚀 Production |
| `驗證狀態` | 誰已經驗證 | ⚪ 未測試 / 🔵 AI 已檢查 / 🟡 待人工驗收 / 🟢 已驗收 / 🔴 未通過 |
| `優先順序` | 先做哪一張 | P0 / P1 / P2 / P3 |
| `目標日期` | 預計何時完成 | 日期 |
| `🤖 AI 認領` | Agent 是否已取票 | ⚪ 未認領 / 🟡 已認領 / 🟢 已交付 / 🔴 需協助 |
| `Agent／認領者` | 哪個 Agent 正在處理 | 文字；教學範例可填 Demo Agent |
| `認領時間` | 何時開始處理 | 日期 |
| `執行紀錄` | 到哪裡查看過程或成果 | Issue／PR／執行紀錄 URL |

一張 Issue 進入 `📌 開發就緒 + 🤖 AI + ⚪ 未認領` 只代表內容已經可以交給 Agent，不代表 GitHub 會自動讓 Agent 認領。本範例的 AI 認領欄位只用來示意。最簡單的做法仍是由人把 Issue 指派給支援的 coding agent；要自動巡看板、避免重複認領與逾時釋放，必須另外建立排程 Agent 或 API 自動化。

建議另外建立以下 Views：

1. **AI Ready**：`status:"📌 開發就緒" 執行方式:"🤖 AI" 🤖-AI-認領:"⚪ 未認領"`
2. **待人工驗收**：`status:"👀 人工驗收"`
3. **Staging 尚未驗收**：`執行環境:"🧪 Staging" -驗證狀態:"🟢 已驗收"`
4. **本期工作**：搭配 Iteration 的 `@current`

若使用父 Issue 與 Sub-issues，可顯示 `Parent issue` 與 `Sub-issue progress` 欄位，讓大型功能與子任務的完成比例直接出現在 Project。

---

## 十六、常用快捷鍵

記不住沒關係 —— 先記住 `Cmd/Ctrl + K` 開 **command palette**,幾乎所有動作都能用搜尋的方式找到。

| 快捷鍵 | 作用 |
| :--- | :--- |
| `Cmd/Ctrl + K` | 開啟 command palette(打字觸發幾乎所有操作) |
| `c` | 在 view 內建立新項目 |
| `e` | 編輯選取項目 |
| `Space` | 開啟選取項目的詳情 |
| `↑ / ↓ / ← / →` | 在表格 / 看板中移動選取 |
| `Cmd/Ctrl + 點選` | 多選項目以批次編輯 |

---

## 參考資源

- [GitHub Docs — Planning and tracking with Projects](https://docs.github.com/issues/planning-and-tracking-with-projects)
- [GitHub Docs — Projects v2 GraphQL API](https://docs.github.com/issues/planning-and-tracking-with-projects/automating-your-project/using-the-api-to-manage-projects)
- [GitHub Docs — Understanding fields](https://docs.github.com/en/issues/planning-and-tracking-with-projects/understanding-fields)
- [GitHub CLI — gh project](https://cli.github.com/manual/gh_project)
- [actions/add-to-project](https://github.com/actions/add-to-project)
