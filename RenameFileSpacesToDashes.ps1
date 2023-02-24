param(
    [Parameter(Mandatory = $true)]
    [string]$directoryPath
)

$files = Get-ChildItem -Path $directoryPath -Recurse -File -Filter *.md

foreach ($file in $files) {
    $newFileName = $file.Name -replace " ", "-"
    $newFilePath = Join-Path -Path $file.DirectoryName -ChildPath $newFileName
    Rename-Item -Path $file.FullName -NewName $newFilePath
}
