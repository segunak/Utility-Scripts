:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: post_build.cmd
::
:: A collection of Post Build events for Visual Studio projets that I have found
:: useful. 
:: 
:: This script isn't meant to be called. Just a place to store snippets. 
:: Note: You don't really need the cd $(DIRECTORY) with Visual Studio singe it 
:: sets your directory to your set configuration folder (debug or release). But 
:: it's there for safety. You really don't want to run any of this accidentally 
:: in the wrong folder. 
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:: Delete all files in the output folder except those with the .exe extension. 
cd $(OutDir)
for /R %%f in (*) do (if not "%%~xf"==".exe" del "%%~f")

:: Delete all files in the output folder except those matching the list of extensions. 
cd $(OutDir)
for /f %%F in ('dir /b /a-d ^| findstr /vile ".txt .k3z .md .exe"') do del "%%F"

:: Delete the obj folder. Used Post Build mainly because I hate that folder 
RD /S /Q "$(ProjectDir)obj\"