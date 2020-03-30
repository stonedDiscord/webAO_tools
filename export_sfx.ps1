'export default [' | Out-File -encoding UTF8 -FilePath "E:\Git\webAO\webAO\sounds.js"
$charfolders = Get-ChildItem -File | %{
if( $_.Name -like "sfx-*.wav") {
    Write-Host $_.Name
    '    "' + $_.Name + '",' | Add-Content -Path "E:\Git\webAO\webAO\sounds.js"
    }
}

'];' | Add-Content -Path "E:\Git\webAO\webAO\sounds.js"