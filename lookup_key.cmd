@Echo Off
setLocal enableDelayedExpansion

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: lookup_key.cmd
::
:: Looks up a registry key
:: 
:: Ex: lookup_key HOSTNAME
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

set TARGET=%~1
set KEYPATH=%~2

reg query \\!TARGET!\!KEYPATH!