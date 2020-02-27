#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


MButton::
	temps := 100

	;open the k menu
	sleep %temps%
	send {k down}
	sleep %temps%
	send {k up}
	sleep %temps%
	
	;click on the gps button
	MouseClick, X1, 1515 , 165 , 1, 0
	sleep %temps%
	Click, down
	sleep %temps%
	Click, up
	
	;click on new from current position
	MouseClick, X1, 584 , 880 , 1, 0
	sleep %temps%
	Click, down
	sleep %temps%
	Click, up
	
	;click on the gps' name to edit it
	MouseClick, X1, 940 , 280 , 1, 0
	sleep %temps%
	Click, down
	sleep %temps%
	Click, up
	
	;select everything
	send {Ctrl down}
	send {a down}
	sleep %temps%
	send {a up}
	send {Ctrl up}
	sleep %temps%
	
	;remove the text
	send {Backspace down}
	sleep %temps%
	send {Backspace up}
	sleep %temps%
	
	send insert the new one
	
	return