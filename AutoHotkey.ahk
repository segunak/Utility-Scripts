^j::

DownCount = 2

Loop, 100  
{ 
Send, +{F10}
SendPlay, {Down}
SendPlay, {Down}
Send, {Enter}
WinActivate, TextDump
WinWaitActive, TextDump
Send, ^v
WinActivate, Untitled page - OneNote
WinWaitActive, Untitled page - OneNote
MouseMove, 45, 266
Click, 45, 266

Loop, %DownCount% 
{
SendPlay, {Down}
SendPlay, {Down}
}

DownCount += 2

}

return