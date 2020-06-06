$BaseFolder = "E:\Git\vanilla-assets\base"

Get-ChildItem -recurse $BaseFolder -Force | % {
    if (!($_.PSIsContainer) ) {
        if( $_.Name -like "*.wav") {
            Write-Host $_.FullName
            # Delete the swoosh sound without any objection
            $wavhash = Get-FileHash $_.FullName
            if ($wavhash.Hash -eq 'E4D5B469F2952137C73A85580175552DEBEE829C6EF41267AF0F1A119883B69B') {
                Write-Host "deleted with hash"
                Remove-Item $_.FullName
            }
        }
    }
}