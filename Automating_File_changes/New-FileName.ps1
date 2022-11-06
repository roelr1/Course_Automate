Function New-FileName{
    [cmdletbinding()]
    param(
        [string]$FilePath = ".\Images"
    )

    BEGIN{
        Write-Verbose "[BEGIN]: Starting Function $($MyInvocation.MyCommand)"
        Set-Location $PSScriptRoot
        Write-Verbose "[BEGIN]: Execute Set-Location for default : $PSScriptRoot"
        Write-verbose "[BEGIN]: Explain: copy folder with name Images and content to above location!"
    }
    
    PROCESS{
        Write-Verbose "[PROCESS]: Retrieve the filenames"
        $names = Get-ChildItem -Path "$FilePath\*.jpg" | Select-Object -ExpandProperty Name -InformationAction Continue
        Write-Verbose "[PROCESS]: $($names.count) files will be renamed"

        #loop for making the change 
        foreach($name in $names[0]){
            $newName = $name | select-string -Pattern "\d{6}" | Select-Object -ExpandProperty Matches | Select-Object -Property Value
            Rename-Item -Path ".\images\$name" -NewName "$($newName.Value).jpg" -InformationAction Continue -InformationVariable i
            
            Write-Information -MessageData "$((Get-Date).DateTime):New name for $name is $newname" -InformationAction Continue
          
            

        }
        
    }
    END{}


}
New-FileName -Verbose -InformationAction Continue 6> info.txt

# Set default location for working with files and folder @root folder
#Set-Location $PSScriptRoot
# list
#$Names = Get-ChildItem -Path ".\images\*.jpg" | Select-Object -ExpandProperty Name
#foreach($name in $names[0]){
#    $newName = $name | select-string -Pattern "\d{6}" | Select-Object -expandProperty Matches | Select-Object -Property Value
#    $newName
    
#    Rename-Item -Path ".\images\$name" -NewName "$($newName.Value).jpg" -Verbose
    
    #Use in Function
    #Write-Verbose "$((Get-Date).DateTime):New name for $name is $newname"
#}
