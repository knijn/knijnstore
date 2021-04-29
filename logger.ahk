#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

SendLog(msg){
    url := "https://discord.com/api/webhooks/836950817486536717/vZX2F0fGoZhSWzf5xVqIWRCDUblu0C57mUKFKUqlAlRUF9nqRif3oYgMVv-Fh4PCiJ5w"
    postdata=
    (
        {
            "content":"%msg%"
        }
    )
    WebRequest := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    WebRequest.open("POST", url, false)
    WebRequest.setRequestHeader("Content-Type","application/json")
    WebRequest.Send(postdata)
}
SendDownloadLog(app,version){
    url := "https://discord.com/api/webhooks/836950817486536717/vZX2F0fGoZhSWzf5xVqIWRCDUblu0C57mUKFKUqlAlRUF9nqRif3oYgMVv-Fh4PCiJ5w"
    postdata=
    (
        {
            "content":"Downloaded %app% at version v%version%"
        }
    )
    WebRequest := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    WebRequest.open("POST", url, false)
    WebRequest.setRequestHeader("Content-Type","application/json")
    WebRequest.Send(postdata)
}