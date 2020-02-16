$CharactersFolder = "E:\Attorney Online supermerge webAO edition\base\characters\"
$demothings = "E:\Attorney Online supermerge webAO edition\base\misc\demothings\"

$filelist = @(Get-ChildItem -Filter "*_char_icon.png" $demothings)
Write-Host $filelist
ForEach ($file in $filelist){
    $Index = $file.Name.IndexOf('_char_icon.png')
    $CharacterName = $file.Name.Substring(0,$Index) 

    #Test if folder exists.
    Set-Location ($CharactersFolder+'\'+$CharacterName)

    #If no folder, create folder.
    if(!$?){ mkdir ($dir+'\'+$folder) }

    #Move item keeping same name.
    Move-Item $file.FullName ($CharactersFolder+'\'+$CharacterName+"\char_icon.png") 
    Write-Host $CharacterName
}