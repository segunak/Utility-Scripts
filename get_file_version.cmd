@Echo Off
: Get file version for .exe and .dll files. Ex - get_file_version C:\CoolFile.exe
setlocal
set "FILE=%~1"
set "FILE=%FILE:\=\\%"

for /f "usebackq delims=" %%a in (`"WMIC DATAFILE WHERE name='!FILE!' get Version /format:Textvaluelist"`) do (
    for /f "delims=" %%# in ("%%a") do set "%%#"
)
: The version of the file is stored in %version%. You don't have to do the fancy stuff below to use it
if "%~2" neq "" (
    endlocal & (
        echo %version%
        set %~2=%version%
    )
) else (
    echo %version%
)