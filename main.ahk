; KnijnStore application written in AHK to easily install Knijn apps.
#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%
#Include, utils.ahk

verNum = 0.1.2
defaultStatus = KnijnStore version: %verNum% Latest version: %latestVer%
configStatus := FileExist(config.ini)

UrlDownloadToFile, https://knijn.github.io/knijnstore/index.ini, index.ini


if(VersionCompare(latestVer,verNum)) { ; Check for if user has latest version
    MsgBox, Your KnijnStore might be out of date, please update using the update button
}

IniRead, latestVer, index.ini, KnijnStoreApp, latestVer , 0.0.1
IniRead, appCount, index.ini,  KnijnStoreApp, appCount , 1

if(configStatus != N) { ; Setup config.ini keys to configure the program  
   RebuildConfig() 
}


Gui, Add, StatusBar,, %defaultStatus%
Gui, Add, GroupBox, x10 y10 w380 h100, Welcome to the KnijnStore
Gui, Add, Text, x20 y40 w300 h40, Here you can download all Knijn Apps and run them, Press the update button to update the store itself, This might add extra applications if there is an update available
Gui, Add, Button, x270 y90 w100 h30 gselfUpdate, Update
if (A_Args[1] != "installed") { ; Check if being run from a shortcut made with SelfInstall()
Gui, Add, Button, x150 y90 w100 h30 gselfInstall, Install
}
    
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

selfInstall:
  SelfInstall()
return
selfUpdate:
    SelfUpdate()
return

download1:
    Download(1)
return

run1:
    Run(1)
return 



GuiClose:
ExitApp