#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; KnijnStore application written in AHK to easily install Knijn apps.

verNum = 0.1.0
indexFileURL := "https://knijn.github.io/knijnstore/index.ini"
defaultStatus = KnijnStore version %verNum%  Latest version: %latestVer%
defaultStatusSTR := defaultStatus

Download(item) {
    SB_SetText("Started app download")
    IniRead, exeDownload, index.ini,  %item%, exeDownload , about:blank
    IniRead, name, index.ini,  %item%, name , about:blank
    UrlDownloadToFile, %exeDownload%, %name%.exe
    SB_SetText("App download done")
    Sleep, 500
    SB_SetText(defaultStatusSTR)
}

Run(item) {
    IniRead, name, index.ini,  %item%, name , nill
    Run, %name%
}

UrlDownloadToFile, https://knijn.github.io/knijnstore/index.ini, index.ini
IniRead, latestVer, index.ini, KnijnStoreApp, latestVer , 0.0.1
IniRead, appCount, index.ini,  KnijnStoreApp, appCount , 1


Gui, Add, StatusBar,, %defaultStatus%
Gui, Add, GroupBox, x10 y10 w380 h100, Welcome to the KnijnStore
Gui, Add, Text, x20 y40 w300 h40, Here you can download all Knijn Apps and run them, Press the update button to update the store itself, This might add extra applications if there is an update available
Gui, Add, Button, x270 y90 w100 h30, Update

    
IniRead, name, index.ini,  1, name , Unknown App
IniRead, appLatestVer, index.ini,  1, latestVer , 0.0.0
IniRead, description, index.ini,  1, description , Unknown App
IniRead, exeDownload, index.ini,  1, exeDownload , about:blank


Gui, Add, GroupBox, x10 y160 w380 h100, %name%  [1]
Gui, Add, Text, x20 y190 w300 h30, %description%
Gui, Add, Text, x20 y240 w90 h15, v%appLatestVer%
Gui, Add, Button, x270 y240 w100 h30 grun1, Run
Gui, Add, Button, x150 y240 w100 h30 gdownload1, Download


Gui, Show, w410 h531, KnijnStore v%verNum%
return

download1:
    Download(1)
return

run1:
    Run(1)
return 





GuiClose:
ExitApp