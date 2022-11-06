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
        $names = Get-ChildItem -Path "$FilePath\*.jpg" | Select-Object -ExpandProperty Name
        Write-Verbose "[PROCESS]: $($names.count) files will be renamed"

        #loop for making the change 
        foreach($name in $names){
            $newName = $name | select-string -Pattern "\d{6}" | Select-Object -ExpandProperty Matches | Select-Object -Property Value
            Rename-Item -Path ".\images\$name" -NewName "$($newName.Value).jpg" -InformationAction Continue -InformationVariable i
            
            Write-Information -MessageData "$((Get-Date).DateTime):New name for $name is $($newname.Value).jpg" -InformationAction Continue
          
            

        }
        
    }
    END{
        Write-Verbose "[END]: Filenames are renamed. See folder log for results"
    }


}
New-FileName -Verbose -InformationAction Continue 6> ".\log\newNameLog.txt"
