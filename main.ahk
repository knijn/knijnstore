; KnijnStore application written in AHK to easily install Knijn apps.
#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%
#Include, logger.ahk
#Include, versioncompare.ahk


verNum = 0.1.2

UrlDownloadToFile, https://knijn.github.io/knijnstore/index.ini, index.ini
IniRead, latestVer, index.ini, KnijnStoreApp, latestVer , 0.0.1
IniRead, appCount, index.ini,  KnijnStoreApp, appCount , 1

if(VersionCompare(latestVer,verNum)) {
    MsgBox, Your KnijnStore might be out of date, please update using the update button
}

IfNotExist,config.ini  ; Setup config.ini keys to configure the program
    MsgBox, The target file does not exist
    IniWrite, false, config.ini, Privacy, noTrack
    IniWrite, nill, config.ini, Apps, Item Downloader


defaultStatus = KnijnStore version: %verNum% Latest version: %latestVer%


Download(item) { ; Download function to download apps
    SB_SetText("Started app download")
    IniRead, exeDownload, index.ini,  %item%, exeDownload , about:blank
    IniRead, name, index.ini,  %item%, name , about:blank
    IniRead, appLatestVer, index.ini, %item%, latestVer, 0.0.0 
    
    IniWrite, %appLatestVer%, config.ini, Apps, %name%
    SendDownloadLog(name,appLatestVer)
    
    UrlDownloadToFile, %exeDownload%, %name%.exe
    SB_SetText("Done with app download")
}

Run(item) {
    IniRead, name, index.ini,  %item%, name , nill
    i = %name%.exe
    o := i
    If (fileExist(o)) {
        Run, %name%
    }
    Else {
        MsgBox,, Error, The program has not been downloaded yet, please download it first
    } 
}

SelfUpdate() {
    IniRead, exeDownload, index.ini, KnijnStoreApp, exeDownload, nill
    UrlDownloadToFile, %exeDownload%, knijnstore.exe
    Run, knijnstore.exe
    ExitApp
}

SelfInstall() {
    FileCreateShortcut, %A_ScriptFullPath%, %A_Desktop%\Knijn Store.lnk , %A_ScriptDir%, installed, Start the KnijnStore
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