﻿#include <Vis2>  ; Equivalent to #include .\lib\Vis2.ahk

;Vis2.Graphics.Subtitle.Render("Running Test Code... Please wait", "t7000 xCenter y67% p1.35% c88EAB6 r8", "s2.23% cBlack")
;Vis2.Graphics.Subtitle.Render("Press [Win] + [c] to highlight and copy anything on-screen.", "time: 30000 xCenter y92% p1.35% cFFB1AC r8", "c000000 s2.23%")
Vis2.Graphics.Subtitle.Render("Press [F6 for rus][F7 for eng] to translate the chat when it is displayed", "time: 10000 xCenter y92% p1.35% cFFB1AC r8", "c000000 s2.23%")
;MsgBox % text := OCR("test.jpg")
MsgBox Be aware this script is a prototype and made for 1920*1080 for gta o

;#c:: OCR()              ; OCR to clipboard
;F5:: MsgBox % OCR()    
F5::
	;MsgBox %widthToScan%:%heightToScan%:%topLeftX%:%topLeftY%
	once:=0
	If(widthToScan=700){
		widthToScan:=960
		heightToScan:=500
		topLeftX := 960
		topLeftY := 250
		;MsgBox lol2
	}
	else if(widthToScan=960){
		widthToScan:=700
		heightToScan:=100
		topLeftX := 30
		topLeftY := 830
		;MsgBox lol3
	}
	If(widthToScan=""){
		widthToScan:=960
		heightToScan:=500
		topLeftX := 960
		topLeftY := 250
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
F6:: 
	lang ="rus"
	Vis2.Graphics.Subtitle.Render("Russian ocr-ing", "time: 10000 xCenter y92% p1.35% cFF8888 r8", "c000000 s2.23%")
	Goto, MyLabel
F7::
	;text := OCR([1100,250,820,700])
	lang ="eng"
	Vis2.Graphics.Subtitle.Render("English ocr-ing", "time: 10000 xCenter y92% p1.35% cFFB1AC r8", "c000000 s2.23%")
	MyLabel:
	;MsgBox lang: %lang%
	If(widthToScan=""){
		widthToScan:=960
		heightToScan:=500
		topLeftX := 960
		topLeftY := 250
		;MsgBox lol11
	}
	;text := OCR([960,250,960,500],lang)
	text := OCR([topLeftX,topLeftY,widthToScan,heightToScan],lang)
	
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

GoogleTranslate(str, from := "auto", to := "en")  {
   static JS := CreateScriptObj(), _ := JS.( GetJScript() ) := JS.("delete ActiveXObject; delete GetObject;")
   
   json := SendRequest(JS, str, to, from, proxy := "")
   oJSON := JS.("(" . json . ")")

   if !IsObject(oJSON[1])  {
      Loop % oJSON[0].length
         trans .= oJSON[0][A_Index - 1][0]
   }
   else  {
      MainTransText := oJSON[0][0][0]
      Loop % oJSON[1].length  {
         trans .= "`n+"
         obj := oJSON[1][A_Index-1][1]
         Loop % obj.length  {
            txt := obj[A_Index - 1]
            trans .= (MainTransText = txt ? "" : "`n" txt)
         }
      }
   }
   if !IsObject(oJSON[1])
      MainTransText := trans := Trim(trans, ",+`n ")
   else
      trans := MainTransText . "`n+`n" . Trim(trans, ",+`n ")

   from := oJSON[2]
   trans := Trim(trans, ",+`n ")
   Return trans
}

SendRequest(JS, str, tl, sl, proxy) {
   ComObjError(false)
   http := ComObjCreate("WinHttp.WinHttpRequest.5.1")
   ( proxy && http.SetProxy(2, proxy) )
   http.open( "POST", "https://translate.google.com/translate_a/single?client=webapp&sl="
      . sl . "&tl=" . tl . "&hl=" . tl
      . "&dt=at&dt=bd&dt=ex&dt=ld&dt=md&dt=qca&dt=rw&dt=rm&dt=ss&dt=t&ie=UTF-8&oe=UTF-8&otf=0&ssel=0&tsel=0&pc=1&kc=1"
      . "&tk=" . JS.("tk").(str), 1 )

   http.SetRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=utf-8")
   http.SetRequestHeader("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:47.0) Gecko/20100101 Firefox/47.0")
   http.send("q=" . URIEncode(str))
   http.WaitForResponse(-1)
   Return http.responsetext
}

URIEncode(str, encoding := "UTF-8")  {
   VarSetCapacity(var, StrPut(str, encoding))
   StrPut(str, &var, encoding)

   While code := NumGet(Var, A_Index - 1, "UChar")  {
      bool := (code > 0x7F || code < 0x30 || code = 0x3D)
      UrlStr .= bool ? "%" . Format("{:02X}", code) : Chr(code)
   }
   Return UrlStr
}

GetJScript()
{
   script =
   (
      var TKK = ((function() {
        var a = 561666268;
        var b = 1526272306;
        return 406398 + '.' + (a + b);
      })());

      function b(a, b) {
        for (var d = 0; d < b.length - 2; d += 3) {
            var c = b.charAt(d + 2),
                c = "a" <= c ? c.charCodeAt(0) - 87 : Number(c),
                c = "+" == b.charAt(d + 1) ? a >>> c : a << c;
            a = "+" == b.charAt(d) ? a + c & 4294967295 : a ^ c
        }
        return a
      }

      function tk(a) {
          for (var e = TKK.split("."), h = Number(e[0]) || 0, g = [], d = 0, f = 0; f < a.length; f++) {
              var c = a.charCodeAt(f);
              128 > c ? g[d++] = c : (2048 > c ? g[d++] = c >> 6 | 192 : (55296 == (c & 64512) && f + 1 < a.length && 56320 == (a.charCodeAt(f + 1) & 64512) ?
              (c = 65536 + ((c & 1023) << 10) + (a.charCodeAt(++f) & 1023), g[d++] = c >> 18 | 240,
              g[d++] = c >> 12 & 63 | 128) : g[d++] = c >> 12 | 224, g[d++] = c >> 6 & 63 | 128), g[d++] = c & 63 | 128)
          }
          a = h;
          for (d = 0; d < g.length; d++) a += g[d], a = b(a, "+-a^+6");
          a = b(a, "+-3^+b+-f");
          a ^= Number(e[1]) || 0;
          0 > a && (a = (a & 2147483647) + 2147483648);
          a `%= 1E6;
          return a.toString() + "." + (a ^ h)
      }
   )
   Return script
}

CreateScriptObj() {
   static doc
   doc := ComObjCreate("htmlfile")
   doc.write("<meta http-equiv='X-UA-Compatible' content='IE=9'>")
   Return ObjBindMethod(doc.parentWindow, "eval")
}