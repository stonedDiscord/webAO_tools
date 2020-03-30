$TI = (Get-Culture).TextInfo

'export default [' | Out-File -encoding UTF8 -FilePath "E:\Git\webAO\webAO\characters.js"
$charfolders = Get-ChildItem -Directory | %{
$inifile  = $_.FullName + '\char.ini'
$charicon = $_.FullName + '\char_icon.png'
if (Test-Path $inifile) {
    Write-Host $TI.ToTitleCase($_.Name)
    '    "' + $TI.ToTitleCase($_.Name) + '",' | Add-Content -Path "E:\Git\webAO\webAO\characters.js"
    }
}

'];' | Add-Content -Path "E:\Git\webAO\webAO\characters.js"