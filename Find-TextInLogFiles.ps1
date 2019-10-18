<#
.SYNOPSIS
    Searches all .log and .txt files in a directory for the given text. 
.PARAMETER  TextToFind
    The text you want to find. 
.PARAMETER FolderToSearch 
    The folder you want to search in. If you don't provide one it will search whatever folder the console
	is executing from. 
.PARAMETER copy 
    Optional flag, if you want to copy the files in which the text is found into the current directory
.EXAMPLES
    Find-TextInLogFiles.ps1 Error
	Find-TextInLogFiles.ps1 Error C:\Counters\LogFiles
#>

[CmdletBinding()]
Param(
    [Parameter(Mandatory=$True)][string]$TextToFind, 
    [Parameter(Mandatory=$false)][string]$FolderToSearch, 
    [Parameter(Mandatory=$False)][switch]$copy = $false
)

if ([string]::IsNullOrEmpty($FolderToSearch)) { 
    $FolderToSearch = Get-Location
}

$results = Select-String -Path $FolderToSearch\*.log, $FolderToSearch\*.txt -Pattern $TextToFind

if ([string]::IsNullOrEmpty($results)) { 
    Write-Host "No matches found!"
    exit
}

Write-Host "`nThe provided text was found. See line matches below. Files containing the matches will be copied into the current directory.`n"
foreach($item in $results) { 
	Write-Host "File:" ($item).Filename "`nText:" ($item).Line "`n"
	if($copy) { 
        ($item).Path | Copy-Item
    }
}
Write-Host "`nScript completed."