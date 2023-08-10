$BaseFolder       = "D:\Attorney Online\Attorney Online supermerge webAO edition\base\"

Set-Location ($BaseFolder + '\characters\')

'[' | Out-File -encoding UTF8 -FilePath $BaseFolder\characters.json
$bgfolders = Get-ChildItem -Directory | %{
    if (Test-Path -Path (Join-Path $_.Name char.ini)) {
        Write-Host $_.Name
        '    "' + $_.Name + '",' | Add-Content -Path $BaseFolder\characters.json
    }
}

'];' | Add-Content -Path $BaseFolder\characters.json