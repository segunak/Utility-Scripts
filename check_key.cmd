@Echo Off
setLocal enableDelayedExpansion
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: check_key.cmd
::
:: Checks to see if a registry key value matches a desired
:: value indicating the ability to read checks with dashes in their numbers. 
:: 
:: Ex: check_key HOSTNAME
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

set "SCRIPT_NAME=%~n0"
set "ERRLEV=0"
set "TARGET=%~1"
set "VALUE_NAME=RemoveNonDigits"
set "ROOT="
set "Target_BitTestingPath="

:: Determine if the caller specifed registry look up of a remote host, or of the local machine. 
if not defined TARGET (
    set "HOSTNAME=!COMPUTERNAME!"
    set "ROOT="
    set "Target_BitTestingPath=C:\"
    set "LOCAL=TRUE"
) else (
    set "HOSTNAME=!TARGET!"
    set "ROOT=\\!TARGET!\"
    set "Target_BitTestingPath=!ROOT!c$\"
    set "LOCAL=FALSE"
)

:: Check for the existence of the folder specifying bit type. 
:: Determine the correct Key_Name based on bit type of the TARGET machine, not the host!
 if exist "!Target_BitTestingPath!Program Files (x86)" (
    :: Target is a 64 bit machine. 
    set "KEY_NAME=!ROOT!hklm\SOFTWARE\Wow6432Node\OLEforRetail\ServiceOPOS\MICR\NCRMICR.USB"
) else (
    :: Target is a 32 bit machine. 
    set "KEY_NAME=!ROOT!hklm\SOFTWARE\OLEforRetail\ServiceOPOS\MICR\NCRMICR.USB"
)

:: Initial reg query call, if this fails it will below be recorded in ERRLEV and the script will throw an error. 
reg query !KEY_NAME! >nul

::Capture error level output from calling reg query. 
set "ERRLEV=!errorlevel!" 
 
:: If the first reg query call failed, the registry key doesn't exist or is syntactically incorrect. 
if "!ERRLEV!" == "0" ( 
   goto :REGFUNCTIONS
) else ( 
    set "!ERRLEV!=1"
    GOTO :ERR 
    exit /b
)

:: Registry key has been verified as existing and correct, so now call functions to break down the result of the query. 
:: invocation depends on host's TARGET_ARCHICTECTURE, not target's TARGET_ARCHICTECTURE. We are choosing a function based on the host. 
:: The KEY_NAME at this point already correctly reflects the target's archictecture. 
:REGFUNCTIONS
if defined ProgramFiles(x86) (
    :: The host machine is a 64 bit. 
    call :GET_REG_VALUE_64
) else (
    :: The host machine is a 32 bit. 
    call :GET_REG_VALUE_32
)

:: Ensure that registry functions (either GET_REG_VALUE_64 or 32) returned a value, if not throw error. 
if "!V_VALUE!"=="" ( 
    set "!ERRLEV = 1"
    echo:ERROR: The registry key returned an empty value. 
    GOTO :ERR
    exit /b
)

:: "AT" signifying success, correct code in place. If not update? 
if "!V_VALUE!"=="AT -> <A> for Account; <T> for Transit; <AT> for both; <> for neither" ( 
   echo TRUE
   echo Reg Key Current Value is: "!V_VALUE!"
) else ( 
   echo FALSE 
   echo Reg Key Current Value is: "!V_VALUE!"
)
exit /b !ERRLEV!

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: :GET_REG_VALUE_64
:: Gets the reg key information for a 64 bit system. 
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:GET_REG_VALUE_64
for /F "usebackq skip=2 tokens=1-2*" %%A in (`REG QUERY "!KEY_NAME!" /v "!VALUE_NAME!" 2^>nul`) do (
    set V_NAME=%%~A
    set V_TYPE=%%~B
    set V_VALUE=%%~C
) 
exit /b

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: :GET_REG_VALUE_32
:: Gets the reg key information for a 32 bit system. 
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:GET_REG_VALUE_32
for /F "usebackq skip=4 tokens=1-2*" %%A in (`REG QUERY "!KEY_NAME!" /v "!VALUE_NAME!" 2^>nul`) do (
    set V_NAME=%%~A
    set V_TYPE=%%~B
    set V_VALUE=%%~C
)
exit /b 

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: :ERR
::  Error handling. 
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:ERR
if "!ERRLEV!" == "0"  ( 
     SET "!ERRLEV!=1"
     pause
     exit /b !ERRLEV!
) else ( 
   echo:ERROR: !SCRIPT_NAME! failed
   pause 
   exit /b !ERRLEV!
)
exit /b
