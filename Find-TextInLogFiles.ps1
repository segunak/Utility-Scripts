<#
.SYNOPSIS
    Searches all .log and .txt files in a directory for the given text. 
.PARAMETER  TextToFind
    The text you want to find. 
.PARAMETER FolderToSearch 
    The folder you want to search in 
.PARAMETER copy 
    Optional flag, if you want to copy the files in which the text is found into the current directory
.EXAMPLE
    ./Find-TextInLogFiles.ps1 Error C:\Counters\LogFiles
#>
[CmdletBinding()]
Param(
    [Parameter(Mandatory=$True)][string]$TextToFind, 
    [Parameter(Mandatory=$True)][string]$FolderToSearch, 
    [Parameter(Mandatory=$False)][switch]$copy = $false
)

$results = Select-String -Path $FolderToSearch\*.log, $FolderToSearch\*.txt -Pattern $TextToFind

if ([string]::IsNullOrEmpty($results)) { 
    Write-Host "No matches found!"
    exit
}

Write-Host "`nThe provided text was found. See line matches below. Files containing the matches will be copied into the current directory.`n"
foreach($item in $results) { 
    Write-Host "File:" ($item).Filename "Text:" ($item).Line
    if($copy) { 
        ($item).Path | Copy-Item
    }
}
Write-Host "`nScript completed."