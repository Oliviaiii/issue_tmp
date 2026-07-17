param(
    [switch]$RemoveDefaultEnglishLabels
)

# Keep this file ASCII-only so Windows PowerShell 5 and PowerShell 7 both
# decode the Traditional Chinese label names correctly.
$labelsJson = '[{"name":"\u932f\u8aa4\u56de\u5831","color":"d73a4a","description":"\u56de\u5831\u7cfb\u7d71\u7570\u5e38\u6216\u4e0d\u7b26\u5408\u9810\u671f\u7684\u884c\u70ba"},{"name":"\u529f\u80fd\u65b0\u589e","color":"0e8a16","description":"\u63d0\u51fa\u5168\u65b0\u529f\u80fd\u3001\u6d41\u7a0b\u6216\u9801\u9762\u9700\u6c42"},{"name":"\u529f\u80fd\u4fee\u6539","color":"1d76db","description":"\u8abf\u6574\u65e2\u6709\u529f\u80fd\u7684\u884c\u70ba\u6216\u6d41\u7a0b"},{"name":"\u4efb\u52d9\u8ffd\u8e64","color":"fbca04","description":"\u8ffd\u8e64\u5177\u9ad4\u4e14\u53ef\u9a57\u6536\u7684\u5de5\u4f5c\u9805\u76ee"},{"name":"\u6a23\u5f0f\u8abf\u6574","color":"c5def5","description":"\u7248\u578b\u3001\u4ecb\u9762\u8207\u8996\u89ba\u6a23\u5f0f\u8abf\u6574"},{"name":"\u6280\u8853\u8abf\u7814","color":"5319e7","description":"\u6280\u8853\u7814\u7a76\u3001\u8a66\u4f5c\u8207\u53ef\u884c\u6027\u9a57\u8b49"},{"name":"\u6587\u4ef6\u9700\u6c42/\u4fee\u6b63","color":"0075ca","description":"\u65b0\u589e\u3001\u88dc\u5145\u6216\u4fee\u6b63\u6587\u4ef6"},{"name":"\u63d0\u554f","color":"cc317c","description":"\u4f7f\u7528\u652f\u63f4\u8207\u4e00\u822c\u554f\u984c"},{"name":"\u7dda\u4e0a\u4e8b\u6545","color":"b60205","description":"\u6b63\u5f0f\u74b0\u5883\u91cd\u5927\u7570\u5e38\u6216\u670d\u52d9\u9000\u5316"},{"name":"\u5f85\u78ba\u8a8d","color":"ededed","description":"\u5c1a\u5f85\u78ba\u8a8d\u5167\u5bb9\u3001\u7bc4\u570d\u6216\u512a\u5148\u9806\u5e8f"},{"name":"\u91cd\u8907\u554f\u984c","color":"cfd3d7","description":"\u5df2\u6709\u76f8\u540c\u6216\u9ad8\u5ea6\u76f8\u95dc\u7684 Issue"},{"name":"\u9069\u5408\u65b0\u624b","color":"7057ff","description":"\u9069\u5408\u7b2c\u4e00\u6b21\u53c3\u8207\u672c\u5c08\u6848\u7684\u4eba\u8655\u7406"},{"name":"\u6b61\u8fce\u5354\u52a9","color":"008672","description":"\u6b61\u8fce\u793e\u7fa4\u6210\u54e1\u5354\u52a9\u8655\u7406"},{"name":"\u7121\u6548\u56de\u5831","color":"e4e669","description":"\u8cc7\u8a0a\u4e0d\u8db3\u3001\u7121\u6cd5\u91cd\u73fe\u6216\u4e0d\u5c6c\u65bc\u6709\u6548\u554f\u984c"},{"name":"\u66ab\u4e0d\u8655\u7406","color":"ffffff","description":"\u76ee\u524d\u6c92\u6709\u898f\u5283\u8655\u7406"}]'
$messagesJson = '{"failure":"\u5efa\u7acb\u6216\u66f4\u65b0 Label \u5931\u6557\uff1a","success":"\u7e41\u9ad4\u4e2d\u6587 Labels \u5df2\u5efa\u7acb\u5b8c\u6210\u3002"}'

$labels = $labelsJson | ConvertFrom-Json
$messages = $messagesJson | ConvertFrom-Json

foreach ($label in $labels) {
    gh label create $label.name --color $label.color --description $label.description --force
    if ($LASTEXITCODE -ne 0) {
        throw ($messages.failure + $label.name)
    }
}

if ($RemoveDefaultEnglishLabels) {
    $defaultEnglishLabels = @(
        "bug", "documentation", "duplicate", "enhancement", "good first issue",
        "help wanted", "invalid", "question", "wontfix"
    )

    foreach ($name in $defaultEnglishLabels) {
        gh label delete $name --yes 2>$null
    }
}

Write-Host $messages.success
