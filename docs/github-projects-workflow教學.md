# GitHub Projects 自動化(Workflow)設定教學

> 這是 GitHub Projects 系列的延伸篇,專門講**自動化**。
> 前一篇《GitHub Projects 完整教學》帶你認識視圖與欄位;這篇聚焦在「怎麼讓 Project 自己動」——項目加進來自動設狀態、issue 關閉自動標 Done、符合條件的 issue 自動匯入等等,讓你少做重複的手動操作。

---

## 一、先搞懂:自動化有三層

GitHub Projects 的自動化由淺到深分三層,絕大多數人只要用到第一層就夠了:

| 層級 | 工具 | 適合誰 | 要不要寫程式 |
| :--- | :--- | :--- | :---: |
| **第一層** | 內建工作流(Built-in workflows) | 所有人,最常用 | ❌ 不用 |
| **第二層** | GitHub Actions | 需要跨 repo、複雜邏輯 | ✅ 寫 YAML |
| **第三層** | GraphQL API(ProjectsV2 API) | 要程式化整合的開發者 | ✅ 寫程式 |

這篇會把**第一層講到透**,第二、三層給範例與方向。

---

## 二、內建工作流在哪裡?

打開你的 Project,右上角有一個 **Workflows** 按鈕(旁邊會顯示目前啟用的數量,例如 `Workflows 7`)。點進去就是工作流的管理頁。

進去後你會看到:

- **左側**:所有可用的工作流清單。名稱前面有一個小圓點——**實心綠點代表已啟用**,**空心圓點代表未啟用**。
- **右側**:選中某個工作流後,會顯示它的內容,結構固定是「**觸發條件 → 執行動作**」兩段式。
- **右上角**:`On / Off` 開關,以及 `Edit` 按鈕(進入編輯模式才能改設定;沒按 Edit 時是唯讀的 Viewing mode)。

> 💡 記住這個心智模型:**每個工作流 = 一個「當…就…」的規則**。
> 例如「**當**一個項目被關閉,**就**把它的 Status 設成 Done」。

---

## 三、每個內建工作流在做什麼

下面把常見的內建工作流整理成表,再挑重點的詳細說明。

| 工作流 | 觸發條件(When) | 預設動作(Set / Do) | 預設是否啟用 |
| :--- | :--- | :--- | :---: |
| **Item added to project** | 項目被加進 Project 時 | 設定欄位(常設 Status → Todo) | 可啟用 |
| **Item closed** | issue / PR 被關閉時 | Status → **Done** | ✅ 預設開 |
| **Item reopened** | 項目重新開啟時 | 設定 Status(例如 → Todo / In Progress) | 可啟用 |
| **Pull request merged** | PR 被合併時 | Status → **Done** | ✅ 預設開 |
| **Code changes requested** | PR 被要求修改時 | 設定 Status(例如 → In Progress) | 可啟用 |
| **Code review approved** | PR 通過審查時 | 設定 Status(例如 → In Review / Ready) | 可啟用 |
| **Auto-add to project** | repo 中符合篩選條件的 issue/PR 出現時 | 自動把它加入 Project | 需設定 |
| **Auto-archive items** | 項目符合篩選條件時 | 自動封存(archive) | 需設定 |
| **Auto-add sub-issues to project** | 某項目有子議題(sub-issues)時 | 把子議題一起加入 Project | 可啟用 |
| **Auto-close issue** | 項目的 Status 被設為指定值時 | 自動關閉該 issue | 可啟用 |

> ⚙️ **Project 剛建立時,預設就啟用兩個工作流:**
> 1. issue / PR 關閉 → Status 設為 **Done**
> 2. PR 合併 → Status 設為 **Done**
>
> 其他工作流預設是關的,要用得自己開、自己設。

### 重點工作流逐一講

#### 1. Item added to project(項目加入時設狀態)

最實用的入門自動化。打開它、設定動作為 `Set Status: Todo`,之後**任何新加進 Project 的項目都會自動帶上 Todo**,不用每次手動點。

搭配看板用特別順:新項目一進來就落在 Todo 欄,流程一目了然。

#### 2. Item closed / Pull request merged(完成時自動 Done)

這兩個預設就開好了,動作都是 `Set Status: Done`。意思是:

- 你在 GitHub 上把 issue 關掉 → Project 裡它自動變 Done
- PR 被 merge → 對應項目自動變 Done

**反過來的情境**用 **Item reopened**:重新開啟的項目自動拉回 Todo 或 In Progress,避免「明明又要做了卻還掛在 Done」。

#### 3. Code changes requested / Code review approved(依審查結果流轉)

如果你的團隊有走 PR review,可以讓狀態跟著審查結果自動跑:

- 被 reviewer 要求修改 → 自動回到 `In Progress`
- 通過審查 → 自動進 `In Review` 或 `Ready to merge`

這樣看板上的 PR 卡片會自己跟著 review 狀態移動。

#### 4. Auto-add to project(自動匯入,最強的省力工具)

這是讓「特定 repo 裡符合條件的 issue/PR 自動進 Project」的工作流,**設定一次就不用再手動加項目**。

設定步驟:

1. 進 **Workflows → Auto-add to project**,按 `Edit`
2. 選擇要監看的 **repository**(可加多個 repo,每個 repo 各一條)
3. 填入**篩選條件**(filter),語法跟搜尋一樣,例如:
   - `is:issue`(只收 issue)
   - `is:issue,pr`(issue 和 PR 都收)
   - `is:issue label:bug`(只收貼了 `bug` 標籤的 issue)
   - `is:open label:"needs triage"`(只收待分類的)
4. 按 `Save and turn on workflow`

之後該 repo 只要出現符合條件的 issue/PR,就會**自動出現在 Project**。

> ⚠️ Auto-add 是**一條工作流綁一個 repo**。一個 Project 雖然可以跨多 repo,但你要為每個 repo 各設一條 Auto-add。

#### 5. Auto-archive items(自動封存,讓視圖保持乾淨)

時間久了 Project 會塞滿已完成項目。Auto-archive 可以把符合條件的項目自動移出作用中視圖(封存而非刪除,資料還在、可還原)。

設定步驟:

1. 進 **Workflows → Auto-archive items**,按 `Edit`
2. 填封存條件,常見的例如:
   - `is:closed`(關閉的就封存)
   - `is:closed updated:<@today-2w`(關閉且兩週沒更新的才封存)
3. `Save and turn on workflow`

> ⚠️ Insights 圖表**不會**統計已封存或已刪除的項目,設 Auto-archive 前先想清楚要不要保留在統計裡。

#### 6. Auto-add sub-issues to project(子議題一起帶進來)

當一個父 issue 底下有 sub-issues 時,自動把子議題也加進同一個 Project,適合用「父議題拆子任務」管理的團隊。

#### 7. Auto-close issue(狀態到位就自動關)

反向操作:當你把某項目的 Status 設成指定值(例如 Done),自動把對應的 issue 關閉。讓「Project 標完成」和「GitHub issue 關閉」兩邊同步,不用兩頭手動。

---

## 四、設定一個工作流的通用步驟

不管哪一個內建工作流,操作邏輯都一樣:

1. Project 右上角點 **Workflows**
2. 左側清單選你要的工作流
3. 右上角按 **Edit** 進入編輯模式
4. 設定**觸發條件**(有些固定、有些可選)與**執行動作**(通常是 Set 某個欄位的值)
5. 右上 `On / Off` 切到 **On**,或按 `Save and turn on workflow`
6. 回清單確認該工作流前面的圓點變成**實心綠點**

> 💡 改完不確定有沒有生效?隨便關一個測試用 issue,看看 Project 裡狀態有沒有自動跳到 Done,就知道了。

---

## 五、第二層:GitHub Actions(跨 repo、複雜邏輯)

內建工作流不夠用時(例如要更細的條件、要跨很多 repo、要串接外部流程),改用 GitHub Actions。官方維護的 [`actions/add-to-project`](https://github.com/actions/add-to-project) 可以把當前 issue/PR 自動加進 Project:

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

設定重點:

- **`project-url`**:你的 Project 網址(個人或組織皆可)。
- **`github-token`**:需要一組有 `project` 權限的 Personal Access Token(PAT),存進 repo 的 **Settings → Secrets and variables → Actions**,命名後在 YAML 用 `secrets.<NAME>` 引用。
- **`on`**:觸發事件,可換成 `pull_request`、加 `labeled` 類型等,搭配 `if:` 條件做更細的過濾。

> ⚠️ 一個 Project 可跨多個 repo,但一份 Actions workflow 檔**綁定單一 repo**,所以要每個 repo 各放一份。
> 如果只是「特定 repo + 特定 label 自動匯入」,其實用第一層的 **Auto-add** 更簡單,不必動 Actions。

---

## 六、第三層:GraphQL API(ProjectsV2 API)

自由度最高,可程式化讀寫 Project 的項目與欄位值,搭配 webhook 事件做完整整合。

注意:**Projects v2 只有 GraphQL API,沒有 REST 端點。** 想批次改欄位值時,也可以用 GitHub CLI 直接打:

```bash
# 先補上 project scope
gh auth refresh -s project,read:project

# 用 gh api graphql 直接呼叫 ProjectsV2 API
gh api graphql -f query='...'
```

這層適合已經在做 CI/CD 或內部工具整合的團隊,一般日常管理用不到。

---

## 七、實戰組合:幾個常見的自動化配方

把多個工作流組起來,就能拼出順手的流程。以下是幾個實用配方:

**配方 A|最小可用三件套(新手建議)**

1. `Item added to project` → Status: **Todo**
2. `Item closed` → Status: **Done**(預設已開)
3. `Pull request merged` → Status: **Done**(預設已開)

效果:新項目自動進 Todo、做完自動 Done,幾乎不用手動改狀態。

**配方 B|Bug 追蹤線**

1. `Auto-add to project`,篩選 `is:issue label:bug`
2. `Item added to project` → Status: **Todo**
3. `Item closed` → Status: **Done**

效果:任何貼上 `bug` 的 issue 自動進專案並排進 Todo。

**配方 C|完整 PR review 流**

1. `Code changes requested` → Status: **In Progress**
2. `Code review approved` → Status: **In Review**
3. `Pull request merged` → Status: **Done**

效果:PR 卡片跟著 review 狀態在看板上自己移動。

**配方 D|長期維護的乾淨看板**

1. 上述任一配方
2. `Auto-archive items`,條件 `is:closed updated:<@today-2w`

效果:關閉滿兩週的項目自動封存,作用中視圖只留進行中的工作。

---

## 八、常見問題與注意事項

- **預設只開兩個**:新 Project 只預設啟用「關閉 → Done」「PR 合併 → Done」,其餘要自己開。
- **Auto-add 一 repo 一條**:跨多 repo 要分別設定多條 Auto-add。
- **封存不進統計**:Auto-archive 封存的項目不會出現在 Insights 圖表。
- **改了沒生效?** 確認該工作流圓點是**實心綠點**、而且你按了 `Save / On`,不是停在 Viewing mode。
- **狀態選項要先存在**:工作流動作若要設成 `In Review` 之類的值,得先在 Status 欄位裡建好這個選項(到 Settings → Custom fields → Status 新增)。
- **權限**:要編輯工作流,需要該 Project 的 **Write 或 Admin** 權限。

---

## 九、快速檢查清單

設定完自動化後,照這份清單掃一遍:

- [ ] 新項目加入會自動帶 Status 嗎?(Item added to project)
- [ ] issue / PR 關閉、合併後會自動 Done 嗎?(預設兩個)
- [ ] 需要自動匯入的 repo 都各設好 Auto-add 了嗎?
- [ ] 動作用到的 Status 選項(Todo / In Progress / In Review / Done)都已建立?
- [ ] 要啟用的工作流前面都是實心綠點?
- [ ] (進階)跨 repo 需求是否該改用 Actions 的 `add-to-project`?

---

## 參考資源

- [GitHub Docs — Automating your project](https://docs.github.com/issues/planning-and-tracking-with-projects/automating-your-project)
- [GitHub Docs — Using the built-in automations](https://docs.github.com/issues/planning-and-tracking-with-projects/automating-your-project/using-the-built-in-automations)
- [actions/add-to-project](https://github.com/actions/add-to-project)
- [GitHub Docs — Projects v2 GraphQL API](https://docs.github.com/issues/planning-and-tracking-with-projects/automating-your-project/using-the-api-to-manage-projects)
