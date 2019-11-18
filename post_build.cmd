:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: post_build.cmd
::
:: A collection of Post Build events for Visual Studio projets that I have found
:: useful. 
:: 
:: This script isn't meant to be called. Just a place to store snippets. 
:: Note: You don't really need the cd $(DIRECTORY) with Visual Studio since it 
:: sets your directory to your set configuration folder (debug or release). But 
:: it's there for safety.
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:: Delete all files in the output folder except those with the .exe extension. 
cd $(OutDir)
for /R %%f in (*) do (if not "%%~xf"==".exe" del "%%~f")

:: Delete all files in the output folder except those matching the list of extensions. 
cd $(OutDir)
for /f %%F in ('dir /b /a-d ^| findstr /vile ".txt .k3z .md .exe"') do del "%%F"

:: Delete the obj folder. Used Post Build mainly because I hate that folder 
RD /S /Q "$(ProjectDir)obj\"

:: Delete all files except those matching the extensions and delete the OBJ folder, but only
:: for the assigned Release type. You can't debug an exectuable in a folder with this running.
if $(ConfigurationName) == Release (
for /f %%F in ('dir /b /a-d ^| findstr /vile ".txt  .k3z .md .exe"') do del "%%F"
RD /S /Q "$(ProjectDir)obj\"
) 

:: Copy a file from one folder to another based on what configuration the build is running.
:: /q for xcopy is quiet, /y means it won't prompt if it's overwriting an existing file in the 
:: target folder. 
if $(ConfigurationName) == Release (
xcopy "$(ProjectDir)bin\release\MyCoolFileThatIWantCopied.exe" "$(SolutionDir)FolderThatIWantFileCopiedTo" /q /y
)

:: Copy a file from one one location to another based on relative path. The ../ is taking
:: you up from the directory of the solution. 
if $(ConfigurationName) == Release (
xcopy "$(SolutionDir)..\..\..\bin\release\MyCoolFile.exe" "$(SolutionDir)MyDesiredFolderLocation" /q /y
)