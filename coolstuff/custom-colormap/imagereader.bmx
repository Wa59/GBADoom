'---------------------------------------------------------------------------------------------------
' This program was written with BLIde (www.blide.org)
' Application: Image Viewer
' Author: Kippykip
' License: do whatever you fucken want
'---------------------------------------------------------------------------------------------------

Framework brl.D3D7Max2D
Import BRL.Timer
Import BRL.Retro
Import MaxGUI.Win32MaxGUIEx

' modules which may be required:
 Import brl.PNGLoader
' Import BRL.BMPLoader
' Import BRL.TGALoader
' Import BRL.JPGLoader


SetGraphicsDriver D3D7Max2DDriver()
Print "Doom II GBA - Modding Tools - http://kippykip.com"


Include "GBAGFX.bmx"
'Dummy function here so I can fucking compile from importing KGFX.
Global Timer = CreateTimer(30) 
Global TMP_BANK:TBank
Global Palette:String = "decompile\PALETTE\PLAYPAL.1.D2P"
AppTitle:String = "Image Viewer: ERROR"

If(AppArgs.length > 1) 
	TMP_BANK:TBank = LoadBank(AppArgs[1] ) 
	If(AppArgs.length > 2) 
		Palette:String = AppArgs[2] 
	EndIf
	If Not(TMP_BANK) 
		Notify("Image doesn't exist!", True) 
		End
	End If
Else
	Notify("Missing command line! Nothing to open!", True) 
	Notify("Arguments: ImageReader.exe D2ImageFileName D2Palette(optional)", True) 
	End
EndIf
If (FileType(Palette:String) = 0) 
	Notify("Palette not found!: " + Palette:String, True) 
	End
EndIf
Global SplitFN:String[] = AppArgs[1].Split("\") 
Global CurrentFolder:String
For x = 0 To SplitFN.Length - 2
	CurrentFolder:String = CurrentFolder:String + SplitFN[x] + "\"
Next
Global LoadedFN:String = Upper:String(SplitFN[SplitFN.Length - 1] ) 
Global SplitFN2:String[] = LoadedFN:String.Split(".") 
Global TransparentImage = False
Function GetHeaderInfo() 
	TMP_FileName:String = "bin\" + SplitFN2[0] + ".txt"
	If (FileType(TMP_FileName:String) = 0) 
		Notify("Header not found!: " + HeaderFN:String, True) 
		End
	EndIf
	TMP_CurrentTXT:TStream = ReadStream(TMP_FileName:String) 
	TMP_Type:String = ""
	TMP_Width:Int = 0
	TMP_Height:Int = 0
	TMP_Count:Int = 0
	TMP_Offset:Int = 0
	While Not Eof(TMP_CurrentTXT) 
		TMP_CurrentLine:String = Upper(ReadLine(TMP_CurrentTXT)) 
		If(TMP_CurrentLine:String.Contains("TYPE:")) 
			TMP_CurrentLine:String = TMP_CurrentLine:String.Replace("TYPE:", "") 
			TMP_CurrentLine:String = TMP_CurrentLine:String.Replace(" ", "") 
			TMP_Type:String = TMP_CurrentLine:String
		EndIf
		If(TMP_CurrentLine:String.Contains("WIDTH:")) 
			TMP_CurrentLine:String = TMP_CurrentLine:String.Replace("WIDTH:", "") 
			TMP_CurrentLine:String = TMP_CurrentLine:String.Replace(" ", "") 
			TMP_Width:Int = TMP_CurrentLine:String.ToInt() 
		EndIf
		If(TMP_CurrentLine:String.Contains("HEIGHT:")) 
			TMP_CurrentLine:String = TMP_CurrentLine:String.Replace("HEIGHT:", "") 
			TMP_CurrentLine:String = TMP_CurrentLine:String.Replace(" ", "") 
			TMP_Height:Int = TMP_CurrentLine:String.ToInt() 
		EndIf
		If(TMP_CurrentLine:String.Contains("OFFSET:")) 
			TMP_CurrentLine:String = TMP_CurrentLine:String.Replace("OFFSET:", "") 
			TMP_CurrentLine:String = TMP_CurrentLine:String.Replace(" ", "") 
			TMP_Offset:Int = TMP_CurrentLine:String.ToInt() 
		EndIf	
	Wend
	If(TMP_Type:String = "IMAGE") 
		Width = TMP_Width
		Height = TMP_Height
	ElseIf(TMP_Type:String = "TIMAGE") 
		Width = TMP_Width
		Height = TMP_Height
		TransparentImage = True
	Else
		Notify("This is not an image according to the header!", True) 
		End
	EndIf
EndFunction
GFX.KLoadPalette(Palette:String) 
Global Width = 0
Global Height = 0
Global ResizeValue = 1
GetHeaderInfo() 
AppTitle:String = "Image Viewer: " + Width + "x" + Height + ", " + AppArgs[1] + ", Header: " + HeaderFN:String + ", Palette: " + Palette:String
Graphics 800, 600, 0, 60
SetBlend(ALPHABLEND) 
Cls
If(Width * 128 < GraphicsWidth() And Height * 128 < GraphicsHeight()) 
	ResizeValue = 128
ElseIf(Width * 64 < GraphicsWidth() And Height * 64 < GraphicsHeight()) 
	ResizeValue = 64
ElseIf(Width * 32 < GraphicsWidth() And Height * 32 < GraphicsHeight()) 
	ResizeValue = 32
ElseIf(Width * 16 < GraphicsWidth() And Height * 16 < GraphicsHeight()) 
	ResizeValue = 16
ElseIf(Width * 8 < GraphicsWidth() And Height * 8 < GraphicsHeight()) 
	ResizeValue = 8
ElseIf(Width * 4 < GraphicsWidth() And Height * 4 < GraphicsHeight()) 
	ResizeValue = 4
ElseIf(Width * 2 < GraphicsWidth() And Height * 2 < GraphicsHeight()) 
	ResizeValue = 2
Else
	ResizeValue = 1
EndIf



SetColor (238, 243, 250) 
DrawRect(0, 0, GraphicsWidth(), GraphicsHeight()) 
'SetColor (255, 255, 255) 
'Print AppArgs[1] 
'GFX.KConvertTexture(AppArgs[1] , Width, Height, True) 
If(TransparentImage) 
	pixnig = GFX.KConvertImage(AppArgs[1] , Width, Height, False) 
Else
	pixnig = GFX.KConvertImage(AppArgs[1] , Width, Height, True) 
EndIf
Global exportedPNG = False
While Not(AppTerminate()) 
	WaitTimer(Timer) 
	Cls
	SetColor (238, 243, 250) 
	DrawRect(0, 0, GraphicsWidth(), GraphicsHeight()) 
	SetColor 0, 0, 0
	If(exportedPNG) 
		DrawText("Exported to: " + "DECOMPILE\PNG\" + SplitFN[SplitFN.Length - 2] + "\" + SplitFN2[0] + ".PNG", 2, GraphicsHeight() - 14) 
	Else
		DrawText("Press Spacebar to export to PNG", 2, GraphicsHeight() - 14) 
	EndIf
	If(KeyDown(KEY_SPACE) And exportedPNG = False) 
		If(TransparentImage) 
			GFX.KConvertImage(AppArgs[1] , Width, Height, False, True, "DECOMPILE\PNG\" + SplitFN[SplitFN.Length - 2] + "\" + SplitFN2[0] + ".PNG") 
		Else
			GFX.KConvertImage(AppArgs[1] , Width, Height, True, True, "DECOMPILE\PNG\" + SplitFN[SplitFN.Length - 2] + "\" + SplitFN2[0] + ".PNG") 
		EndIf
		exportedPNG = True
	EndIf
	SetColor 255, 255, 255
	DrawImageRect(pixnig, GraphicsWidth() / 2 - (Width * ResizeValue / 2), GraphicsHeight() / 2 - (Height * ResizeValue / 2), Width * ResizeValue, Height * ResizeValue) 
	If(ResizeValue > 1 And GraphicsWidth() / 2 - (Width * ResizeValue / 2) > Width Or ResizeValue > 1 And GraphicsHeight() / 2 - (Height * ResizeValue / 2) > Height) 
		DrawImage(pixnig, 0, 0) 
	EndIf
	Flip
WEnd