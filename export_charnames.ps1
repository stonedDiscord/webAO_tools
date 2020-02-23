'export default [' | Out-File -encoding ASCII -FilePath "E:\Git\webAO\webAO\characters.js"
$charfolders = Get-ChildItem -Directory | %{
$inifile = $_.FullName + '\char.ini'
if (Test-Path $inifile) {
    Write-Host $_.Name
    '    "' + $_.Name + '",' | Add-Content -Path "E:\Git\webAO\webAO\characters.js"
    }
}

'];' | Add-Content -Path "E:\Git\webAO\webAO\characters.js"