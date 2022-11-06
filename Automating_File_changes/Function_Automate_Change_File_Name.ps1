# Set default location for working with files and folder @root folder
Set-Location $PSScriptRoot

# list

$Names = Get-ChildItem -Path ".\images\*.jpg" | Select-Object -ExpandProperty Name


foreach($name in $names[0]){
    $newName = $name | select-string -Pattern "\d{6}" | Select-Object -expandProperty Matches | Select-Object -Property Value
    $newName
    
    Rename-Item -Path ".\images\$name" -NewName "$($newName.Value).jpg" -Verbose
    
    #Use in Function
    #Write-Verbose "$((Get-Date).DateTime):New name for $name is $newname"
}
