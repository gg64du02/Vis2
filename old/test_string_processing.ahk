#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

TestString := "This is a test."
word_array := StrSplit(TestString, A_Space, ".")  ; Omits periods.
MsgBox % "The 4th word is " word_array[4]

Colors := "red,green,blue"
ColorArray := StrSplit(Colors, ",")
Loop % ColorArray.MaxIndex()
{
    this_color := ColorArray[A_Index]
    MsgBox, Color number %A_Index% is %this_color%.
}