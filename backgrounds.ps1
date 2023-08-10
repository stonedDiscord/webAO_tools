$BaseFolder       = "F:\Attorney Online\2.10 content\"

Set-Location ($BaseFolder + '\background\')

'[' | Out-File -encoding UTF8 -FilePath $BaseFolder\backgrounds.json
$bgfolders = Get-ChildItem -File | %{
    Write-Host $_.Name
    '    "' + $_.Name + '",' | Add-Content -Path $BaseFolder\backgrounds.json
}

'];' | Add-Content -Path $BaseFolder + "\backgrounds.js"