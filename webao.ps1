$BaseFolder       = "E:\Attorney Online\Attorney Online supermerge webAO edition\base\"

$CharactersFolder = $BaseFolder + "\characters\"

$LowercaseOnly = False

# Rename the demothings
$filelist = @(Get-ChildItem -Filter "*_char_icon.png" ($BaseFolder + "\misc\demothings\"))
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
$filelist = @(Get-ChildItem -Filter "*_off.png" ($BaseFolder + "\misc\rosterimage\"))
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

# Get all the directories and rename them to lowercase
Get-ChildItem -recurse $BaseFolder | ?{ $_.PSIsContainer -And $_.Name -CMatch "[A-Z]" } | %{
    $NName = $_.FullName.ToLower()
    Write-Host $_.FullName
    # Set temp name to rename to the same name
    $TempItem = Move-Item -LiteralPath $_.FullName -Destination "$NName x" -PassThru
    Move-Item -LiteralPath $TempItem.FullName -Destination $NName

}


# todo:
# delete all these filetypes:
#  *.txt *.rar *.7z *.psd *.jpg *.jpeg *.zip *.apng *.opus *.ase *.db *.sfk

# Go through the character folders and rename the sprites

# Get the files and rename to lowercase
Get-ChildItem -recurse $BaseFolder | % {
    if (!($_.PSIsContainer) ) {
        if( $_.Name -eq "desktop.ini") {
            # Delete all Thumbs.db
            Write-Host $_.FullName " deleted"
            Remove-Item $_.FullName

        }elseif( $_.Name -like "*.rar") {
            # Delete all Thumbs.db
            Write-Host $_.FullName " deleted"
            Remove-Item $_.FullName

        }elseif( $_.Name -like "*.7z") {
            # Delete all Thumbs.db
            Write-Host $_.FullName " deleted"
            Remove-Item $_.FullName

        }elseif( $_.Name -like "*.zip") {
            # Delete all Thumbs.db
            Write-Host $_.FullName " deleted"
            Remove-Item $_.FullName

        }elseif( $_.Name -like "*.psd") {
            # Delete all Thumbs.db
            Write-Host $_.FullName " deleted"
            Remove-Item $_.FullName

        }elseif( $_.Name -like "*.jp*g") {
            # Delete all Thumbs.db
            Write-Host $_.FullName " deleted"
            Remove-Item $_.FullName

        }elseif( $_.Name -like "*.sfk") {
            # Delete all Thumbs.db
            Write-Host $_.FullName " deleted"
            Remove-Item $_.FullName

        }elseif( $_.Name -like "*.apng") {
            # Delete all Thumbs.db
            Write-Host $_.FullName + " deleted"
            Remove-Item $_.FullName

        }elseif( $_.Name -like "*.opus") {
            # Delete all Thumbs.db
            Write-Host $_.FullName + " deleted"
            Remove-Item $_.FullName

        }elseif( $_.Name -like "*.db") {
            # Delete all Thumbs.db
            Write-Host $_.FullName + " deleted"
            Remove-Item $_.FullName

        }elseif ($_.Name -cne $_.Name.ToLower()) {
            # Rename to lowercase
            Move-Item -LiteralPath $_.FullName -Destination $_.FullName.ToLower()
            Write-Host $_.FullName
        }
    }
}