@Echo Off
setLocal enableDelayedExpansion

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: getkey.cmd
::
:: Gets and prints a registry key
:: 
:: Ex: getkey HOSTNAME HKLM\Software\WOw6432Node
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

set TARGET=%~1
set KEYPATH=%~2

reg query \\!TARGET!\!KEYPATH!