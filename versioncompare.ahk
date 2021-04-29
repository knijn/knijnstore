#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%
; Taken from https://www.autohotkey.com/boards/viewtopic.php?t=5959
VersionCompare(other,local) {
	ver_other:=StrSplit(other,".")
	ver_local:=StrSplit(local,".")
	for _index, _num in ver_local
		if ( (ver_other[_index]+0) > (_num+0) )
			return 1
		else if ( (ver_other[_index]+0) < (_num+0) )
			return 0
	return 0
}