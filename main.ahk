; KnijnStore application written in AHK to easily install Knijn apps.
verNum = 0.1.0

Gui, Add, GroupBox, x10 y10 w380 h100, Example app
Gui, Add, Text, x20 y90 w90 h15, v2.7.1
Gui, Add, Text, x20 y40 w300 h30, This is an example description for an example app
Gui, Add, Button, x270 y90 w100 h30, Start
Gui, Add, Button, x150 y90 w100 h30, Download

Gui, Show, w410 h531, KnijnStore v%verNum%
return

GuiClose:
ExitApp