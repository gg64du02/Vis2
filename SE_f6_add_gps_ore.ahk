#include <Vis2>  ; Equivalent to #include .\lib\Vis2.ahk

;Vis2.Graphics.Subtitle.Render("Running Test Code... Please wait", "t7000 xCenter y67% p1.35% c88EAB6 r8", "s2.23% cBlack")
;Vis2.Graphics.Subtitle.Render("Press [Win] + [c] to highlight and copy anything on-screen.", "time: 30000 xCenter y92% p1.35% cFFB1AC r8", "c000000 s2.23%")
Vis2.Graphics.Subtitle.Render("Press [F6 for rus][F7 for eng] to translate the chat when it is displayed", "time: 10000 xCenter y92% p1.35% cFFB1AC r8", "c000000 s2.23%")
;MsgBox % text := OCR("test.jpg")
;MsgBox Be aware this script is a prototype and made for 1920*1080 for Space Engineers, it takes a part of the screen and do ocr on it. And then adds it into gps coords

;#c:: OCR()              ; OCR to clipboard
;F5:: MsgBox % OCR()    
o::
	;MsgBox %widthToScan%:%heightToScan%:%topLeftX%:%topLeftY%
	once:=0
	If(widthToScan=""){
		widthToScan:=400
		heightToScan:=100
		topLeftX := 800
		topLeftY := 570
		;MsgBox lol1
	}
	
	;widthToScan=960
	;heightToScan=500
	;widthToScan=700
	;heightToScan=100
	;topLeftX := 960
	;topLeftY := 250
	;topLeftX := 30
	;topLeftY := 830
	gui, -border +AlwaysOnTop
	gui, color, 0xFF44AA
	gui, show, w%widthToScan% h%heightToScan%,OcrPreviewWindow
	;sleep, 200
	WinSet, Transparent, 50, OcrPreviewWindow
	WinMove, OcrPreviewWindow, , % topLeftX+2, % topLeftY-2
	sleep 200
	;Gui, Destroy
	WinSet, Transparent, 0, OcrPreviewWindow
	Vis2.Graphics.Subtitle.Render("switching the area", "time: 10000 xCenter y92% p1.35% cFF8888 r8", "c000000 s2.23%")
	return
;F6:: 
	lang ="rus"
	Vis2.Graphics.Subtitle.Render("Russian ocr-ing", "time: 10000 xCenter y92% p1.35% cFF8888 r8", "c000000 s2.23%")
	Goto, MyLabel
;F7::
	;text := OCR([1100,250,820,700])
F6::
	lang ="eng"
	Vis2.Graphics.Subtitle.Render("English ocr-ing", "time: 10000 xCenter y92% p1.35% cFFB1AC r8", "c000000 s2.23%")
	MyLabel:
	;MsgBox lang: %lang%
	If(widthToScan=""){
		widthToScan:=400
		heightToScan:=100
		topLeftX := 800
		topLeftY := 570
		;MsgBox lol11
	}
	;text := OCR([960,250,960,500],lang)
	text := OCR([topLeftX,topLeftY,widthToScan,heightToScan],lang)
	
	MsgBox text: %text%
	return
	
	gui, -border +AlwaysOnTop
	gui, color, 0xFF44AA
	gui, show, w%widthToScan% h%heightToScan%,OcrPreviewWindow
	;sleep, 200
	WinSet, Transparent, 50, OcrPreviewWindow
	WinMove, OcrPreviewWindow, , % topLeftX+2, % topLeftY-2
	sleep 200
	Gui, Destroy
	
	;MsgBox ocrResults:before:blankRemoval:%text%
	; Remove all blank lines from the text in a variable:
	Loop
	{
		text := StrReplace(text, "`r`n`r`n", "`r`n", Count)
		if Count = 0  ; No more replacements needed.
			break
	}
	;MsgBox ocrResults:after:blankRemoval:%text%
	
	ocrFinishedString ="OCR finished with %lang%'s characters, running translation"
	;MsgBox %ocrFinishedString%
	Vis2.Graphics.Subtitle.Render(ocrFinishedString, "time: 5000 xCenter y92% p1.35% cFFFFFF r8", "c000000 s2.23%")
	
	;process the string:
	;word_array := StrSplit(text,"[Tous]")
	word_array := StrSplit(text,"`n")
	;MsgBox word_array:%word_array%
	
	translatedArray:=[]
	
	strForMsgBox =
	
	Loop % word_array.MaxIndex()
	{
		this_color := word_array[A_Index]
		;MsgBox, Color number %A_Index% is %this_color%.
		translation:=GoogleTranslate(this_color)
		translatedArray.Push(translation)
		strForMsgBox = %strForMsgBox%`r`n%translation%
	}
	
	MsgBox ocrResults:%text%`r`n===============`r`n%strForMsgBox%
	
	return
	
#i:: ImageIdentify()    ; Label images
;Esc:: ExitApp

;based on https://www.autohotkey.com/boards/viewtopic.php?t=63835

;TranslateThis= I am a bird
;MsgBox, % GoogleTranslate("今日の天気はとても良いです")
;MsgBox, % GoogleTranslate("Hello, World!", "en", "ru")
;MsgBox, % GoogleTranslate(TranslateThis, "en", "ru")
