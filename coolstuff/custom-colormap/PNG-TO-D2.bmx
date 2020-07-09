'---------------------------------------------------------------------------------------------------
' This program was written with BLIde (www.blide.org)
' Application: PNG to D2T converter
' Author: Kippykip
' License: do whatever you fucken want
'---------------------------------------------------------------------------------------------------

Framework brl.D3D7Max2D
Import brl.Timer
Import brl.Retro
Import maxgui.Win32MaxGUIEx
Import brl.StandardIO

' modules which may be required:
Import brl.PNGLoader
' Import BRL.BMPLoader
' Import BRL.TGALoader
' Import BRL.JPGLoader
Include "GBAGFX.bmx"
SetGraphicsDriver D3D7Max2DDriver() 
Print "Doom II GBA - Modding Tools - http://kippykip.com"
Function Crash(TMP_ErrString:String = "Unknown Error") 
	Print("Error: " + TMP_ErrString) 
	'While Not(AppTerminate()) 
	'Wend
	End
End Function

'Open directory
Global Directory_Bin:Int = ReadDir("bin\") 
If Not(Directory_Bin) 
	Crash("Missing 'bin' directory.") 
EndIf
Global Palette:String = "decompile\PALETTE\PLAYPAL.1.D2P"
If(FileType("recompile\PALETTE\PLAYPAL.1.D2P") = 1) 
	Palette:String = "recompile\PALETTE\PLAYPAL.1.D2P"
EndIf
If(AppArgs.length > 1) 
	Palette:String = AppArgs[1] 
	Print "Loading Palette: " + Palette:String
	If (FileType(Palette:String) = 0) 
		Crash("Palette not found!: " + Palette:String) 
		'End
	EndIf
EndIf
GFX.KLoadPalette(Palette:String) 

Function ConvertFile(TMP_FileName:String) 
	TMP_CurrentTXT:TStream = ReadStream("bin\" + TMP_FileName:String + ".txt") 
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
		If(TMP_CurrentLine:String.Contains("COUNT:")) 
			TMP_CurrentLine:String = TMP_CurrentLine:String.Replace("COUNT:", "") 
			TMP_CurrentLine:String = TMP_CurrentLine:String.Replace(" ", "") 
			TMP_Count:Int = TMP_CurrentLine:String.ToInt() 
		EndIf
		If(TMP_CurrentLine:String.Contains("OFFSET:")) 
			TMP_CurrentLine:String = TMP_CurrentLine:String.Replace("OFFSET:", "") 
			TMP_CurrentLine:String = TMP_CurrentLine:String.Replace(" ", "") 
			TMP_Offset:Int = TMP_CurrentLine:String.ToInt() 
		EndIf	
	Wend
	If(TMP_Type:String = "IMAGE" or TMP_Type:String = "TIMAGE") 
		TMP_SourceFile:String = "decompile\png\" + TMP_Type:String + "\" + TMP_FileName:String + ".PNG"
		TMP_DestFile:String = "recompile\" + TMP_Type:String + "\" + TMP_FileName:String + ".D2I"
		If(FileType(TMP_SourceFile:String) = 1) 
			Print("Converting Image: " + TMP_SourceFile:String) 
			GFX.PNG2Image(TMP_SourceFile:String, TMP_DestFile:String) 
			Print("Successfully converted to: " + TMP_DestFile:String) 
		Else
			Print("Missing: '" + TMP_SourceFile:String + "'. Ignoring.") 
		EndIf
	EndIf
	If(TMP_Type:String = "TEXTURE" Or TMP_Type:String = "SPRITE" Or TMP_Type:String = "FLAT") 
		If(TMP_Type:String <> "FLAT") 
			'X1
			TMP_SourceFile:String = "decompile\png\" + TMP_Type:String + "\" + TMP_FileName:String + ".X1.PNG"
			TMP_DestFile:String = "recompile\" + TMP_Type:String + "\" + TMP_FileName:String + ".X1.D2T"
			If(FileType(TMP_SourceFile:String) = 1) 
				Print("Converting " + TMP_Type:String + ": " + TMP_SourceFile:String) 
				GFX.PNG2Texture(TMP_SourceFile:String, TMP_DestFile:String) 
			Else
				Print("Missing: '" + TMP_SourceFile:String + "'. Ignoring.") 
			EndIf
		EndIf
		'X2
		TMP_SourceFile:String = "decompile\png\" + TMP_Type:String + "\" + TMP_FileName:String + ".X2.PNG"
		TMP_DestFile:String = "recompile\" + TMP_Type:String + "\" + TMP_FileName:String + ".X2.D2T"
		If(FileType(TMP_SourceFile:String) = 1) 
			Print("Converting " + TMP_Type:String + ": " + TMP_SourceFile:String) 
			GFX.PNG2Texture(TMP_SourceFile:String, TMP_DestFile:String) 
		Else
			Print("Missing: '" + TMP_SourceFile:String + "'. Ignoring.") 
		EndIf
		'X3
		TMP_SourceFile:String = "decompile\png\" + TMP_Type:String + "\" + TMP_FileName:String + ".X3.PNG"
		TMP_DestFile:String = "recompile\" + TMP_Type:String + "\" + TMP_FileName:String + ".X3.D2T"
		If(FileType(TMP_SourceFile:String) = 1) 
			Print("Converting " + TMP_Type:String + ": " + TMP_SourceFile:String) 
			GFX.PNG2Texture(TMP_SourceFile:String, TMP_DestFile:String) 
		Else
			Print("Missing: '" + TMP_SourceFile:String + "'. Ignoring.") 
		EndIf
		'X4
		TMP_SourceFile:String = "decompile\png\" + TMP_Type:String + "\" + TMP_FileName:String + ".X4.PNG"
		TMP_DestFile:String = "recompile\" + TMP_Type:String + "\" + TMP_FileName:String + ".X4.D2T"
		If(FileType(TMP_SourceFile:String) = 1) 
			Print("Converting " + TMP_Type:String + ": " + TMP_SourceFile:String) 
			GFX.PNG2Texture(TMP_SourceFile:String, TMP_DestFile:String) 
		Else
			Print("Missing: '" + TMP_SourceFile:String + "'. Ignoring.") 
		EndIf
		'X5
		TMP_SourceFile:String = "decompile\png\" + TMP_Type:String + "\" + TMP_FileName:String + ".X5.PNG"
		TMP_DestFile:String = "recompile\" + TMP_Type:String + "\" + TMP_FileName:String + ".X5.D2T"
		If(FileType(TMP_SourceFile:String) = 1) 
			Print("Converting " + TMP_Type:String + ": " + TMP_SourceFile:String) 
			GFX.PNG2Texture(TMP_SourceFile:String, TMP_DestFile:String) 
		Else
			Print("Missing: '" + TMP_SourceFile:String + "'. Ignoring.") 
		EndIf
		'X6
		TMP_SourceFile:String = "decompile\png\" + TMP_Type:String + "\" + TMP_FileName:String + ".X6.PNG"
		TMP_DestFile:String = "recompile\" + TMP_Type:String + "\" + TMP_FileName:String + ".X6.D2T"
		If(FileType(TMP_SourceFile:String) = 1) 
			Print("Converting " + TMP_Type:String + ": " + TMP_SourceFile:String) 
			GFX.PNG2Texture(TMP_SourceFile:String, TMP_DestFile:String) 
		Else
			Print("Missing: '" + TMP_SourceFile:String + "'. Ignoring.") 
		EndIf
		'X7
		TMP_SourceFile:String = "decompile\png\" + TMP_Type:String + "\" + TMP_FileName:String + ".X7.PNG"
		TMP_DestFile:String = "recompile\" + TMP_Type:String + "\" + TMP_FileName:String + ".X7.D2T"
		If(FileType(TMP_SourceFile:String) = 1) 
			Print("Converting " + TMP_Type:String + ": " + TMP_SourceFile:String) 
			GFX.PNG2Texture(TMP_SourceFile:String, TMP_DestFile:String) 
		Else
			Print("Missing: '" + TMP_SourceFile:String + "'. Ignoring.") 
		EndIf
		'X8
		TMP_SourceFile:String = "decompile\png\" + TMP_Type:String + "\" + TMP_FileName:String + ".X8.PNG"
		TMP_DestFile:String = "recompile\" + TMP_Type:String + "\" + TMP_FileName:String + ".X8.D2T"
		If(FileType(TMP_SourceFile:String) = 1) 
			Print("Converting " + TMP_Type:String + ": " + TMP_SourceFile:String) 
			GFX.PNG2Texture(TMP_SourceFile:String, TMP_DestFile:String) 
		Else
			Print("Missing: '" + TMP_SourceFile:String + "'. Ignoring.") 
		EndIf
	EndIf
	If(TMP_Type:String = "PALETTE" Or TMP_Type:String = "555PALETTE") 
		For TMP_CurrentByte = 1 To TMP_Count:Int
			TMP_SourceFile:String = "decompile\png\PALETTE\" + TMP_FileName:String + "." + TMP_CurrentByte + ".PNG"
			TMP_DestFile:String = "recompile\PALETTE\" + TMP_FileName:String + "." + TMP_CurrentByte + ".D2P"
			If(TMP_Count:Int = 1) 
				TMP_SourceFile:String = "decompile\png\PALETTE\" + TMP_FileName:String + ".PNG"
				TMP_DestFile:String = "recompile\PALETTE\" + TMP_FileName:String + ".D2P"
			EndIf
			If(FileType(TMP_SourceFile:String) = 1) 
				Print("Converting Palette: " + TMP_SourceFile:String) 
				GFX.PNG2Palette(TMP_SourceFile:String, TMP_DestFile:String) 
				Print("Successfully converted to: " + TMP_DestFile:String) 
				Else
				Print("Missing: '" + TMP_SourceFile:String + "'. Ignoring.") 
			EndIf
		Next
	EndIf
EndFunction

If(AppArgs.length > 2) 
	Local SplitFN:String[] = AppArgs[2].Split("\") 
	LoadedFN:String = Upper:String(SplitFN[SplitFN.Length - 1] ) 
	Local SplitFN2:String[] = LoadedFN:String.Split(".") 
	If (FileType("bin\" + SplitFN2[0] + ".txt") = 0) 
		Crash("Header not found!: " + "bin\" + SplitFN2[0] + ".txt") 
		End
	EndIf
	Print "Loading: " + "bin\" + SplitFN2[0] + ".txt"
	ConvertFile(SplitFN2[0] ) 
Else
	Repeat
		TMP_CurrentFile:String = Upper(NextFile(Directory_Bin)) 
		If(TMP_CurrentFile:String = "") 
			Exit
		ElseIf Not(TMP_CurrentFile:String = "." Or TMP_CurrentFile:String = "..") 
			If(TMP_CurrentFile:String.EndsWith(".TXT")) 
				Print "Loading: " + TMP_CurrentFile:String
				ConvertFile(Left(TMP_CurrentFile:String, TMP_CurrentFile:String.Length - 4)) 
			EndIf
		EndIf
	Forever
EndIf
Print "Successfully converted all files."