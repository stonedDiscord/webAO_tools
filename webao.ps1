$BaseFolder       = "E:\Attorney Online\mosreq\base\"
$TI = (Get-Culture).TextInfo
$CharactersFolder = $BaseFolder + "\characters\"

Set-Location ($BaseFolder + '\sounds\')

# Move blips
$filelist = @(Get-ChildItem ($BaseFolder + "\sounds\general\sfx-blip*"))
Write-Host $filelist
ForEach ($file in $filelist){
    # Rename
    $NewName = $file.Name.ToLower() -replace 'sfx-blip', ''
    Move-Item $file.FullName ($BaseFolder + '\sounds\blips\' + $NewName)    
    Write-Host $file.FullName
}

Set-Location ($BaseFolder)


# todo:
# delete all these filetypes:
#  *.txt *.rar *.7z *.psd *.jpg *.jpeg *.zip *.ase *.db *.sfk

# Go through the character folders and rename the sprites

# Get the files and rename to lowercase
Get-ChildItem -recurse $BaseFolder -Force | % {
    if (!($_.PSIsContainer) ) {
        if ($_.Name -cne $_.Name.ToLower()) {
            # Rename to lowercase
            Move-Item -LiteralPath $_.FullName -Destination $_.FullName.ToLower()
            Write-Host $_.FullName

        }

        if( $_.Name -eq "desktop.ini") {
            # Delete all windows ini files
            Write-Host $_.FullName " deleted"
            Remove-Item $_.FullName -Force

        }elseif( $_.Name -like "*.rar") {
            # Delete all archives
            Write-Host $_.FullName " deleted"
            Remove-Item $_.FullName

        }elseif( $_.Name -like "*.7z") {
            # Delete all archives
            Write-Host $_.FullName " deleted"
            Remove-Item $_.FullName

        }elseif( $_.Name -like "*.zip") {
            # Delete all archives
            Write-Host $_.FullName " deleted"
            Remove-Item $_.FullName

        }elseif( $_.Name -like "*.psd") {
            # Delete all photoshop files
            Write-Host $_.FullName " deleted"
            Remove-Item $_.FullName

        }elseif( $_.Name -like "*.xcf") {
            # Delete all photoshop files
            Write-Host $_.FullName " deleted"
            Remove-Item $_.FullName

        }elseif( $_.Name -like "*.jp*g") {
            # Delete all jpeg
            Write-Host $_.FullName " deleted"
            Remove-Item $_.FullName

        }elseif( $_.Name -like "*.sfk") {
            # Delete all sony vegas files
            Write-Host $_.FullName " deleted"
            Remove-Item $_.FullName

        }elseif( $_.Name -like "*.toml") {
            # Delete all sony vegas files
            Write-Host $_.FullName " deleted"
            Remove-Item $_.FullName

        }elseif( $_.Name -like "*.db") {
            # Delete all Thumbs.db
            Write-Host $_.FullName + " deleted"
            Remove-Item $_.FullName -Force

        }elseif( $_.Name -like "button*_on.png") {
            # Delete all unused on buttons
            Write-Host $_.FullName + " deleted"
            Remove-Item $_.FullName -Force

        }elseif( $_.Name -like "*.webp") {
            Write-Host $_.FullName
            # Optimize WebP
            #Start-Process -NoNewWindow -FilePath "D:\PNG\pingo.exe" -ArgumentList "-s9",$_.FullName
            E:\PNG\pingo.exe -s9 $_.FullName

        }elseif( $_.Name -like "*.png") {
            Write-Host $_.FullName
            # Optimize PNGs
            E:\PNG\ect-0.8.3.exe """$($_.FullName)"""
            #Start-Process -NoNewWindow -FilePath "D:\PNG\pingo.exe" -ArgumentList "-s9",$_.FullName
            #E:\PNG\pingo.exe -s9 $_.FullName

        }elseif( $_.Name -like "*.apng") {
            Write-Host $_.FullName
            # Rename first
            $OriginalName = $_.FullName
            $TempName = $_.FullName+".png"
            Write-Host $TempName
            Move-Item -LiteralPath $OriginalName -Destination $TempName
            # Optimize PNGs
            #Start-Process -NoNewWindow -Wait -FilePath "D:\PNG\pingo.exe" -ArgumentList "-s9","""$($TempName)"""
            E:\PNG\pingo.exe -s9 $TempName
            #E:\PNG\ect-0.8.3.exe """$($TempName)"""
            # Rename back
            Move-Item -LiteralPath $TempName -Destination $OriginalName

        }elseif( $_.Name -like "*.wav") {
            Write-Host $_.FullName
            # Delete the swoosh sound without any objection
            $wavhash = Get-FileHash $_.FullName
            if ($wavhash.Hash -eq 'E4D5B469F2952137C73A85580175552DEBEE829C6EF41267AF0F1A119883B69B') {
                Write-Host $_.FullName + " deleted with hash"
                Remove-Item $_.FullName
            }
        
        }elseif ($_.Length -eq 0) {
            # Delete all empty files
            Write-Host $_.FullName + " deleted because empty "
            Remove-Item $_.FullName

        }
    } else {
    # Get all the directories and rename them to lowercase
        $NName = $_.FullName.ToLower()
        Write-Host $_.FullName
        # Set temp name to rename to the same name
        $TempItem = Move-Item -LiteralPath $_.FullName -Destination "$NName x" -PassThru
        Move-Item -LiteralPath $TempItem.FullName -Destination $NName
    }
}

Set-Location($CharactersFolder)

'[' | Out-File -encoding UTF8 -FilePath $BaseFolder"\characters.json"
$charfolders = Get-ChildItem -Directory | %{
$inifile  = $_.FullName + '\char.ini'
$charicon = $_.FullName + '\char_icon.png'
if (Test-Path $inifile) {
    Write-Host $TI.ToTitleCase($_.Name)
    '    "' + $TI.ToTitleCase($_.Name) + '",' | Add-Content -Path $BaseFolder"characters.json"
    }
}

'];' | Add-Content -Path $BaseFolder + "characterlist.js"

Set-Location ($BaseFolder)

Get-ChildItem -File -Recurse | %{
    if( $_.Name -like "*.wav") {
        $old = $_.FullName
        $new = $old.Substring(0,$old.Length-4) + ".opus"
        if( -not(Test-Path $new)) {
            Write-Host $old
            ffmpeg.exe -i $old $new
            if ( $LASTEXITCODE=0 ) {
                Remove-Item $old
            }
        } else {
            Remove-Item $old
        }
    }elseif( $_.Name -like "*.ogg") {
        $old = $_.FullName
        $new = $old.Substring(0,$old.Length-4) + ".opus"
        if( -not(Test-Path $new)) {
            Write-Host $old
            ffmpeg.exe -i $old $new
            if ( $LASTEXITCODE=0 ) {
                Remove-Item $old
            }
        } else {
            Remove-Item $old
        }
    }elseif( $_.Name -like "*.mp3") {
        $old = $_.FullName
        $new = $old.Substring(0,$old.Length-4) + ".opus"
        if( -not(Test-Path $new)) {
            Write-Host $old
            ffmpeg.exe -i $old $new
            if ( $LASTEXITCODE=0 ) {
                Remove-Item $old
            }
        } else {
            Remove-Item $old
        }
    }
}
