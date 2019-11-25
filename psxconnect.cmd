@Echo Off
setLocal enableDelayedExpansion
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: psxconnect.cmd 
::
:: Opens a CMD session on a specified PC via PsExec, given it's host name. This
:: script assumes you have PSTools installed on your PATH.  
:: 
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

set "TARGET=%~1"

psExec /s \\!TARGET! cmd