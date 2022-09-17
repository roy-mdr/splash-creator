; *** Start added by AutoIt3Wrapper ***
#include <AutoItConstants.au3>
; *** End added by AutoIt3Wrapper ***
#NoTrayIcon
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=build\qsc.ico
#AutoIt3Wrapper_Outfile=qsc4b.exe
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseUpx=y
#AutoIt3Wrapper_Res_Fileversion=4.0.0.0
#AutoIt3Wrapper_Res_LegalCopyright=Copyright © - R 0 Y - | 2017
#AutoIt3Wrapper_Res_Language=2058
#AutoIt3Wrapper_Add_Constants=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <File.au3>


_main()

Func _main()
Global $exeDRIVE,$exeEXT,$exeFILE,$exePATH,$imgDRIVE,$imgEXT,$imgFILE,$imgPATH,$icoDRIVE,$icoEXT,$icoFILE,$icoPATH

Global $iStartIndex = 1, $iCntRow, $iCntCol, $iCurIndex



	$mainGUI=GUICreate("Quick Splash Creator v4", 466, 335, -1, -1, -1, $WS_EX_ACCEPTFILES)
	        ;GUICreate("Quick Splash Creator v3.5", 466, 335, -1, -1, -1, BitOR($WS_EX_ACCEPTFILES,$WS_EX_TOPMOST)) <--- OBSOLETO POR CHECHBOX ON/OFF


	;Crea el grupo "Titulo"
	$Titulo = GUICtrlCreateGroup("Titulo", 8, 8, 161, 41)
	$Input1 = GUICtrlCreateInput("Introduce el Titulo del splash.", 16, 24, 145, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	;Crea el grupo "Tiempo"
	$Tiempo = GUICtrlCreateGroup("Tiempo", 176, 8, 107, 41)
	$Input2 = GUICtrlCreateInput(3, 184, 24, 35, 21, BitOR(0x2001, $ES_CENTER))
	GUICtrlSetLimit(GUICtrlCreateUpdown($Input2), 10, 1)
	$segundos = GUICtrlCreateLabel("segundos", 226, 24, 50, 17)

	;Crea texto
	$Label1 = GUICtrlCreateLabel("Arrastra los archivos a los campos de texto correspondientes o haz click en 'Buscar...'", 30, 66, 413, 17)

	;Crea el grupo "Programa (.exe)"
	Global $Programa = GUICtrlCreateGroup("", 8, 83, 145, 145)
	Global $Input3 = GUICtrlCreateEdit("", 16, 99, 129, 75, BitOR($ES_READONLY, $WS_VSCROLL))
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	Global $RadioEXE = GUICtrlCreateRadio("EXE", 16, 177, 40, 17)
	GUICtrlSetState(-1, $GUI_CHECKED)
	Global $RadioBAT = GUICtrlCreateRadio("BAT", 108, 177, 40, 17)
	;Global $RadioNONE = GUICtrlCreateRadio("N/A", 62, 177, 40, 17)
	Global $Button1 = GUICtrlCreateButton("Buscar...", 16, 195, 129, 25)

	;Crea el grupo "Imagen (.png .gif .jpg .bmp)"
	Global $Imagen = GUICtrlCreateGroup("Imagen (.png .gif .jpg .bmp)", 160, 83, 145, 145)
	Global $Input4 = GUICtrlCreateEdit("", 168, 99, 129, 75, BitOR($ES_READONLY, $WS_VSCROLL))
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	Global $RadioImgCustom = GUICtrlCreateRadio("Custom", 168, 177, 55, 17)
	GUICtrlSetState(-1, $GUI_CHECKED)
	Global $RadioImgDefault = GUICtrlCreateRadio("Default", 245, 177, 55, 17)
	Global $Button2 = GUICtrlCreateButton("Buscar...", 168, 195, 129, 25)

	;Crea el grupo "Icono (.ico)"
	Global $Icono = GUICtrlCreateGroup("Icono (.ico)", 312, 83, 145, 145)
	Global $Input5 = GUICtrlCreateEdit("", 320, 99, 129, 75, BitOR($ES_READONLY, $WS_VSCROLL))
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	Global $Button4 = GUICtrlCreateButton("Ver Requisitos", 375, 81, 75, 17)
	Global $RadioIcoCustom = GUICtrlCreateRadio("Custom", 320, 177, 55, 17)
	GUICtrlSetState(-1, $GUI_CHECKED)
	Global $RadioIcoDefault = GUICtrlCreateRadio("Default", 397, 177, 55, 17)
	Global $Button3 = GUICtrlCreateButton("Buscar...", 320, 195, 129, 25)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

	;Crea las opciones para compilar
	Global $Radio1 = GUICtrlCreateRadio("Usar 'splash.exe' como launcher", 8, 230, 169, 17)
	GUICtrlSetState(-1, $GUI_CHECKED)
	Global $Radio2 = GUICtrlCreateRadio("Usar los accesos directos ya existentes como launcher (se renombraran archivos)", 8, 246, 400, 17)
	Global $Checkbox1 = GUICtrlCreateCheckbox("Splash siempre visible (Top Most)", 8, 270, 200, 17)
	Global $Checkbox2 = GUICtrlCreateCheckbox("Requerir derechos de Administrador", 8, 290, 200, 17)
	;Global $Checkbox3 = GUICtrlCreateCheckbox("Crear 'autorun.inf'", 226, 290, 205,17)

	;Boton: "Inyectar Ahora"
	$Button5 = GUICtrlCreateButton("Inyectar Ahora", 290, 8, 167, 41)
	GUICtrlSetCursor(-1, 3)

	;Informacion del creador...
	$Label2 = GUICtrlCreateLabel("- R 0 Y - © 2018", 8, 317, 102, 17)
	$Label3 = GUICtrlCreateLabel("go_rojo@hotmail.com", 290, 317, 105, 17)
	$TopMost = GUICtrlCreateCheckbox("Lock.TOP", 397, 315, 65, 17)

	_checkRadiosFile()
	_checkRadiosIMG()
	_checkRadiosICO()

	GUISetState(@SW_SHOW)


	$nMsg = 0
	While $nMsg <> $GUI_EVENT_CLOSE
		$nMsg = GUIGetMsg()

		$ContInput1 = GUICtrlRead($Input1)
		$ContInput2 = GUICtrlRead($Input2)
		$ContInput3 = GUICtrlRead($Input3)
		$ContInput4 = GUICtrlRead($Input4)
		$ContInput5 = GUICtrlRead($Input5)
		_PathSplit($ContInput3,$exeDRIVE,$exePATH,$exeFILE,$exeEXT)
		_PathSplit($ContInput4,$imgDRIVE,$imgPATH,$imgFILE,$imgEXT)
		_PathSplit($ContInput5,$icoDRIVE,$icoPATH,$icoFILE,$icoEXT)

		$exeEXT = StringRegExpReplace($exeEXT, "\r\n|\r|\n", " ")
		$imgEXT = StringRegExpReplace($imgEXT, "\r\n|\r|\n", " ")
		$icoEXT = StringRegExpReplace($icoEXT, "\r\n|\r|\n", " ")

		Select

			Case $nMsg = $Button1
				_filePath()

			Case $nMsg = $RadioEXE
				_checkRadiosFile()

			Case $nMsg = $RadioBAT
				_checkRadiosFile()

			Case $nMsg = $Button2
				GUICtrlSetData($Input4, "")
				$imgDIR = FileOpenDialog("Selecciona la imagen:", "::{20D04FE0-3AEA-1069-A2D8-08002B30309D}", "Image files (*.png;*.jpg;*.gif;*.bmp)")
				;If @error Then ContinueLoop
				GUICtrlSetData($Input4, $imgDIR)

			Case $nMsg = $RadioImgCustom
				_checkRadiosIMG()

			Case $nMsg = $RadioImgDefault
				_checkRadiosIMG()


			Case $nMsg = $Button3
				GUICtrlSetData($Input5, "")
				_checkRadiosICO()
				$icoDIR = FileOpenDialog("Selecciona el icono:", "::{20D04FE0-3AEA-1069-A2D8-08002B30309D}", "Icon files (*.ico)")
				;If @error Then ContinueLoop
				GUICtrlSetData($Input5, $icoDIR)

			Case $nMsg = $RadioIcoCustom
				_checkRadiosICO()

			Case $nMsg = $RadioIcoDefault
				_checkRadiosICO()


			Case $nMsg = $Button4
				MsgBox(064 + 262144, "Requisitos del icono!", "!!!Preferiblemente usa el mismo icono del programa al que aplicaras el splash!!!" & @CRLF & @CRLF & "El icono debe tener maximo 13 imagenes (esto lo puedes saber con algun editor de iconos)")


			Case $nMsg = $Button5
				If $ContInput2 = "" Then
					$ContInput2 = "3"
				EndIf

				If GUICtrlRead($RadioEXE) = $GUI_CHECKED Then
					If ($exeEXT <> ".exe") Then
						GUICtrlSetData($Input3, "")
						MsgBox(016 + 262144, "ERROR", "Debes seleccionar un programa con extension:" & @CRLF & ".exe")
						;$fileDIR = FileOpenDialog("Selecciona el programa:", "::{20D04FE0-3AEA-1069-A2D8-08002B30309D}", "Executable files (*.exe)")
						;If @error Then ContinueLoop
						;GUICtrlSetData($Input3, $fileDIR)
						_filePath()
						ContinueLoop
					EndIf
				ElseIf GUICtrlRead($RadioBAT) = $GUI_CHECKED Then
					If ($exeEXT <> ".bat") Then
						GUICtrlSetData($Input3, "")
						MsgBox(016 + 262144, "ERROR", "Debes seleccionar un archivo con extension:" & @CRLF & ".bat")
						$fileDIR = FileOpenDialog("Selecciona el archivo:", "::{20D04FE0-3AEA-1069-A2D8-08002B30309D}", "Batch file (*.bat)")
						;If @error Then ContinueLoop
						GUICtrlSetData($Input3, $fileDIR)
						ContinueLoop
					EndIf
				EndIf

				If ($imgEXT <> ".png") And ($imgEXT <> ".gif") And ($imgEXT <> ".jpg") And ($imgEXT <> ".bmp") Then
					GUICtrlSetData($Input4, "")
					MsgBox(016 + 262144, "ERROR", "Debes seleccionar una imagen con extension:" & @CRLF & ".png .gif .jpg .bmp")
					$imgDIR = FileOpenDialog("Selecciona la imagen:", "::{20D04FE0-3AEA-1069-A2D8-08002B30309D}", "Image files (*.png;*.jpg;*.gif;*.bmp)")
					;If @error Then ContinueLoop
					GUICtrlSetData($Input4, $imgDIR)
					ContinueLoop
				EndIf

				If ($icoEXT <> ".ico") Then
					GUICtrlSetData($Input5, "")
					MsgBox(016 + 262144, "ERROR", "Debes seleccionar una icono con extension:" & @CRLF & ".ico")
					$icoDIR = FileOpenDialog("Selecciona el icono:", "::{20D04FE0-3AEA-1069-A2D8-08002B30309D}", "Icon files (*.ico)")
					;If @error Then ContinueLoop
					GUICtrlSetData($Input5, $icoDIR)
					ContinueLoop
				EndIf



		$ContInput1 = GUICtrlRead($Input1)

		$ContInput2 = GUICtrlRead($Input2)

		$ContInput3 = GUICtrlRead($Input3)
		_PathSplit($ContInput3,$exeDRIVE,$exePATH,$exeFILE,$exeEXT)
		$exeEXT = StringRegExpReplace($exeEXT, "\r\n|\r|\n", " ")

		$ContInput4 = GUICtrlRead($Input4)
		_PathSplit($ContInput4,$imgDRIVE,$imgPATH,$imgFILE,$imgEXT)
		$imgEXT = StringRegExpReplace($imgEXT, "\r\n|\r|\n", " ")

		$ContInput5 = GUICtrlRead($Input5)
		_PathSplit($ContInput5,$icoDRIVE,$icoPATH,$icoFILE,$icoEXT)
		$icoEXT = StringRegExpReplace($icoEXT, "\r\n|\r|\n", " ")



				;SELECCIONA ARCHIVO PARA COMPILAR REQUIRIENDO DERECHOS DE ADMINISTRADOR O NO
				If GUICtrlRead($Checkbox2) = $GUI_CHECKED Then
					FileCopy("build\1admin.au3", "build\splash.au3")
				Else
					FileCopy("build\0admin.au3", "build\splash.au3")
				EndIf

				;CREATE INI
				If FileExists("splash.ini") Then
					FileDelete("splash.ini")
				EndIf
				FileWriteLine("splash.ini", "[splash]")
				FileWriteLine("splash.ini", "Title=" & $ContInput1)
				FileWriteLine("splash.ini", "ImageFile=" & $imgFILE & $imgEXT)
				FileWriteLine("splash.ini", "ShowTime=" & $ContInput2)
				if GUICtrlRead($Checkbox1) = $GUI_CHECKED Then
					FileWriteLine("splash.ini", "TopMost=" & 1)
				Else
					FileWriteLine("splash.ini", "TopMost=" & 0)
				EndIf


				;CREATE BAT
				FileWriteLine("build.bat", "@ECHO OFF")
				FileWriteLine("build.bat", "title ... Espere ...")
				FileWriteLine("build.bat", "echo compilando launcher, espere...")
				FileWriteLine("build.bat", "echo.")
				FileWriteLine("build.bat", 'build\Aut2exe.exe /in "build\splash.au3" /icon "'&$icoDRIVE&$icoPATH&$icoFILE&$icoEXT&'" /pack')
				FileWriteLine("build.bat", "del %0")

				;RUN BAT
				RunWait("build.bat")

				;COPY IMAGE
				FileCopy($imgDRIVE&$imgPATH&$imgFILE&$imgEXT, $exeDRIVE&$exePATH, 1)

				;
				FileMove("build\splash.exe", $exeDRIVE&$exePATH, 1)

				;check RADIOS
				If GUICtrlRead($RadioEXE) = $GUI_CHECKED Then
					If GUICtrlRead($radio1) = 1 Then;<----------Usar 'splash.exe' como launcher

						FileWriteLine("splash.ini", "RunAfterApp=" & $exeFILE & $exeEXT)
						FileMove("splash.ini", $exeDRIVE&$exePATH, 1)
						FileMove("build\splash.exe", $exeDRIVE&$exePATH, 1)

					ElseIf GUICtrlRead($radio2) = 1 Then;<----------Usar los accesos directos ya existentes como launcher (se renombraran archivos)

						FileWriteLine("splash.ini", "RunAfterApp=[original]" & $exeFILE & $exeEXT)
						FileMove("splash.ini", $exeDRIVE&$exePATH, 1)

						FileWriteLine("ren.bat", "title Renombrando archivos...")
						FileWriteLine("ren.bat", 'rename "' & $exeDRIVE&$exePATH&$exeFILE&$exeEXT & '" "[original]' & $exeFILE & $exeEXT & '"')
						FileWriteLine("ren.bat", 'rename "' & $exeDRIVE & $exePATH & 'splash.exe" "' & $exeFILE & $exeEXT & '"')
						FileWriteLine("ren.bat", "del %0")

						RunWait("ren.bat")
					EndIf
				ElseIf GUICtrlRead($RadioBAT) = $GUI_CHECKED Then
					FileWriteLine("splash.ini", "RunAfterApp=" & $exeFILE & $exeEXT)
					FileMove("splash.ini", $exeDRIVE&$exePATH, 1)
				EndIf

				FileDelete("build\splash.au3")

				;DONE! MSG
				MsgBox(0x40000,"Listo!","Listo!" & @CRLF & @CRLF & "Se han creado 3 archivos en:" & @CRLF & $exeDRIVE&$exePATH)


			Case $nMsg = $TopMost
				If GUICtrlRead($TopMost) = $GUI_CHECKED Then
					WinSetOnTop($mainGUI, "", $WINDOWS_ONTOP) ; = WinSetOnTop($mainGUI, "", 1)
				Else
					WinSetOnTop($mainGUI, "", $WINDOWS_NOONTOP) ; = WinSetOnTop($mainGUI, "", 0)
				EndIf

			Case $nMsg = $GUI_EVENT_CLOSE
				Exit
		EndSelect
	WEnd
EndFunc   ;==>_main

Func _filePath()
	If GUICtrlRead($RadioEXE) = $GUI_CHECKED Then
		GUICtrlSetData($Input3, "")
		$fileDIR = FileOpenDialog("Selecciona el programa:", "::{20D04FE0-3AEA-1069-A2D8-08002B30309D}", "Executable files (*.exe)")
		;If @error Then ContinueLoop
		GUICtrlSetData($Input3, $fileDIR)
	EndIf
	If GUICtrlRead($RadioBAT) = $GUI_CHECKED Then
		GUICtrlSetData($Input3, "")
		$fileDIR = FileOpenDialog("Selecciona el archivo:", "::{20D04FE0-3AEA-1069-A2D8-08002B30309D}", "Batch file (*.bat)")
		;If @error Then ContinueLoop
		GUICtrlSetData($Input3, $fileDIR)
	EndIf
EndFunc

Func _imgPath()

EndFunc

Func _icoPath()

EndFunc


Func _checkRadiosFile()
	If GUICtrlRead($RadioEXE) = $GUI_CHECKED Then
		GUICtrlSetData($Programa,"Programa (*.exe)")
		GUICtrlSetData($Input3,"")
		GUICtrlSetState($Input3, BitOR($GUI_ENABLE, $GUI_DROPACCEPTED))
		GUICtrlSetState($Button1, $GUI_ENABLE)
		GUICtrlSetState($Radio1, $GUI_ENABLE)
		GUICtrlSetState($Radio2, $GUI_ENABLE)
	EndIf

	If GUICtrlRead($RadioBAT) = $GUI_CHECKED Then
		GUICtrlSetData($Programa,"Archivo por lotes (*.bat)")
		GUICtrlSetData($Input3,"")
		GUICtrlSetState($Input3, BitOR($GUI_ENABLE, $GUI_DROPACCEPTED))
		GUICtrlSetState($Button1, $GUI_ENABLE)
		GUICtrlSetState($radio1, $GUI_DISABLE)
		GUICtrlSetState($radio2, $GUI_DISABLE)
	EndIf
EndFunc

Func _checkRadiosIMG()
	If GUICtrlRead($RadioImgCustom) = $GUI_CHECKED Then
		GUICtrlSetData($Input4,"")
		GUICtrlSetState($Input4, BitOR($GUI_ENABLE, $GUI_DROPACCEPTED))
		GUICtrlSetState($Button2, $GUI_ENABLE)
	EndIf

	If GUICtrlRead($RadioImgDefault) = $GUI_CHECKED Then
		GUICtrlSetData($Input4,"build\splash.png")
		GUICtrlSetState($Input4, BitOR($GUI_DISABLE,$GUI_NODROPACCEPTED))
		GUICtrlSetState($Button2, $GUI_DISABLE)
	EndIf
EndFunc

Func _checkRadiosICO()
	If GUICtrlRead($RadioIcoCustom) = $GUI_CHECKED Then
		GUICtrlSetData($Input5,"")
		GUICtrlSetState($Input5, BitOR($GUI_ENABLE, $GUI_DROPACCEPTED))
		GUICtrlSetState($Button3, $GUI_ENABLE)
	EndIf

	If GUICtrlRead($RadioIcoDefault) = $GUI_CHECKED Then
		GUICtrlSetData($Input5,"build\qsc.ico")
		GUICtrlSetState($Input5, BitOR($GUI_DISABLE,$GUI_NODROPACCEPTED))
		GUICtrlSetState($Button3, $GUI_DISABLE)
	EndIf
EndFunc