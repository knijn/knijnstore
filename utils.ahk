#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%


RebuildConfig() {
    IniWrite, nill, config.ini, Apps, Item Downloader
}

Download(item) { ; Download function to download apps
    SB_SetText("Started app download")
    IniRead, exeDownload, index.ini,  %item%, exeDownload , about:blank
    IniRead, name, index.ini,  %item%, name , about:blank
    IniRead, appLatestVer, index.ini, %item%, latestVer, 0.0.0 
    
    IniWrite, %appLatestVer%, config.ini, Apps, %name%
    
    UrlDownloadToFile, %exeDownload%, %name%.exe
    SB_SetText("Done with app download")
}

Run(item) {
    IniRead, name, index.ini,  %item%, name , nill 
    i = %name%.exe
    o := i
    If (fileExist(o)) {
        IniRead, latestVer, config.ini, Apps , %name% , nill
        IniRead, latestVerRemote, index.ini,  %item%, latestVer , nill
        if(VersionCompare(latestVerRemote,latestVer)) {
            MsgBox,, Version Error, The program seems to be out of date, please re-download to fix this, Timeout]
        }
        
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

VersionCompare(other,local) { ; Taken from https://www.autohotkey.com/boards/viewtopic.php?t=5959
	ver_other:=StrSplit(other,".")
	ver_local:=StrSplit(local,".")
	for _index, _num in ver_local
		if ( (ver_other[_index]+0) > (_num+0) )
			return 1
		else if ( (ver_other[_index]+0) < (_num+0) )
			return 0
	return 0
}