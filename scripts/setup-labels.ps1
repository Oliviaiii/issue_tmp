[CmdletBinding()]
param(
    [string]$Repository = "",
    [switch]$UpdateExisting,
    [switch]$RemoveDefaultEnglishLabels
)

$ErrorActionPreference = "Stop"

if (-not (Get-Command gh -ErrorAction SilentlyContinue)) {
    throw "找不到 GitHub CLI（gh）。請先安裝並完成 gh auth login。"
}

$repoRoot = Split-Path -Parent $PSScriptRoot
$labelsPath = Join-Path $repoRoot "config\labels.tsv"
if (-not (Test-Path -LiteralPath $labelsPath)) {
    throw "找不到 Labels 設定檔：$labelsPath"
}

$repoArgs = @()
if ($Repository) {
    $repoArgs = @("--repo", $Repository)
}

$existingJson = & gh label list @repoArgs --limit 1000 --json name
if ($LASTEXITCODE -ne 0) {
    throw "無法讀取目標 repository 的 Labels。請確認 gh 登入狀態、repository 與權限。"
}

$existing = @{}
foreach ($item in ($existingJson | ConvertFrom-Json)) {
    $existing[$item.name] = $true
}

$labels = Import-Csv -LiteralPath $labelsPath -Delimiter "`t" -Encoding utf8
foreach ($label in $labels) {
    if ($existing.ContainsKey($label.name) -and -not $UpdateExisting) {
        Write-Host "保留既有 Label：$($label.name)"
        continue
    }

    $arguments = @(
        "label", "create", $label.name,
        "--color", $label.color,
        "--description", $label.description
    )
    if ($existing.ContainsKey($label.name)) {
        $arguments += "--force"
    }
    $arguments += $repoArgs

    & gh @arguments
    if ($LASTEXITCODE -ne 0) {
        throw "建立或更新 Label 失敗：$($label.name)"
    }
}

if ($RemoveDefaultEnglishLabels) {
    $defaultEnglishLabels = @(
        "bug", "documentation", "duplicate", "enhancement", "good first issue",
        "help wanted", "invalid", "question", "wontfix"
    )

    foreach ($name in $defaultEnglishLabels) {
        & gh label delete $name --yes @repoArgs 2>$null
    }
}

Write-Host "Labels 處理完成。預設保留同名 Label；使用 -UpdateExisting 才會同步顏色與說明。"
