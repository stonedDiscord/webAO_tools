﻿$BaseFolder       = "E:\Attorney Online\Attorney Online supermerge webAO edition\base\"
$TI = (Get-Culture).TextInfo
$CharactersFolder = $BaseFolder + "\characters\"

# Rename the demothings
$filelist = @(Get-ChildItem -Force -Filter "*_char_icon.png" ($BaseFolder + "\misc\demothings\"))
Write-Host $filelist
ForEach ($file in $filelist){
    $Index = $file.Name.IndexOf('_char_icon.png')
    $CharacterName = $file.Name.Substring(0,$Index) 
    Write-Host $CharacterName

    # Test if the folder exists
    Set-Location ($CharactersFolder+'\'+$CharacterName)

    # If there is no char folder, create it
    if(!$?){ mkdir ($CharactersFolder+'\'+$CharacterName) }

    # Move item keeping same name.
    Move-Item $file.FullName ($CharactersFolder+'\'+$CharacterName+"\char_icon.png").ToLower()    
}

# Rename the rosterthings
$filelist = @(Get-ChildItem -Force -Filter "*_off.png" ($BaseFolder + "\misc\rosterimage\"))
Write-Host $filelist
ForEach ($file in $filelist){
    $Index = $file.Name.IndexOf('_off.png')
    $CharacterName = $file.Name.Substring(0,$Index) 
    Write-Host $CharacterName

    # Test if the folder exists
    Set-Location ($CharactersFolder+'\'+$CharacterName)

    # If there is no char folder, create it
    if(!$?){ mkdir ($CharactersFolder+'\'+$CharacterName) }

    # Move item keeping same name.
    Move-Item $file.FullName ($CharactersFolder+'\'+$CharacterName+"\char_icon.png").ToLower()  
}

Set-Location ($BaseFolder + '\sounds\')

# Move VNO blips
$filelist = @(Get-ChildItem ($BaseFolder + "\sounds\bleeps\"))
Write-Host $filelist
ForEach ($file in $filelist){
    # Rename
    Move-Item $file.FullName ($BaseFolder + "\sounds\general\sfx-blip" + $file.Name.ToLower())    
    Write-Host $file.FullName
}

# Move TNC blips
$filelist = @(Get-ChildItem ($BaseFolder + "\sounds\blips\"))
Write-Host $filelist
ForEach ($file in $filelist){
    # Rename
    Move-Item $file.FullName ($BaseFolder + "\sounds\general\sfx-blip" + $file.Name.ToLower())    
    Write-Host $file.FullName
}

# Move spanish sfx
$filelist = @(Get-ChildItem ($BaseFolder + "\sounds\sfx\"))
Write-Host $filelist
ForEach ($file in $filelist){
    # Rename
    Move-Item $file.FullName ($BaseFolder + "\sounds\general\" + $file.Name.ToLower())    
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

        }elseif( $_.Name -like "*.png") {
            # Delete all Thumbs.db
            E:\ect-0.8.3.exe $_.FullName

        }elseif( $_.Name -like "*.wav") {
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

Set-Location ($BaseFolder + '\sounds\general\')

Get-ChildItem -File -Recurse | %{
    if( $_.Name -like "*.wav") {
        $old = $_.FullName
        $new = $old.Substring(0,$old.Length-4) + ".opus"
        if( -not(Test-Path $new)) {
            Write-Host $old
            E:\opus-tools\opusenc.exe --music --downmix-mono --discard-comments --discard-pictures $old $new
            if ( $LASTEXITCODE=0) {
                Remove-Item $old
            }
        } else {
            Remove-Item $old
        }
    }
}

'[' | Out-File -encoding UTF8 -FilePath $BaseFolder"\sfxlist.json"
$sfxfolders = Get-ChildItem -File | %{
if( $_.Name -like "sfx-*.opus") {
    Write-Host $_.Name
    '    "' + $_.Name + '",' | Add-Content -Path $BaseFolder"\sfxlist.json"
    }
}

'];' | Add-Content -Path $BaseFolder + "\sfxlist.js"