#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=icon.ico
#AutoIt3Wrapper_Outfile=splash.exe
#AutoIt3Wrapper_Res_Comment=This is the first prototype of a dynamic splash creator. You can use it for run when you plug your USB or include it to any program. Enjoy.
#AutoIt3Wrapper_Res_Description=Dynamic Splash Creator
#AutoIt3Wrapper_Res_Fileversion=1.0.0.0
#AutoIt3Wrapper_Res_Language=2058
#AutoIt3Wrapper_Add_Constants=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
; *** Start added by AutoIt3Wrapper ***
#include <StructureConstants.au3>
; *** End added by AutoIt3Wrapper ***
#include <GDIPlus.au3>
#include <WindowsConstants.au3>
#include <GuiConstantsEx.au3>

Dim $ConfigFile ;Configuration File

Dim $ImageFile ;Image to be shown.  Must be PNG
Dim $Title ;Title to be displayed
Dim $ShowTime ;Length of time to display image in seconds
Dim $ImageFile ;Image name and extension

Global $hGUI, $iLabel1, $iLabel2, $iSlider, $hImage

;-----Splash
$ConfigFile = _GetConfigFile("splash.ini", True)

If $ConfigFile = "Error" Then Exit

$ImageFile = IniRead($ConfigFile, "Splash", "ImageFile", "img.png")

If StringMid($ImageFile, 2, 1) <> ":" And StringMid($ImageFile, 2, 1) <> "\" Then
	$ImageFile = @ScriptDir & "\" & $ImageFile
EndIf

If Not FileExists($ImageFile) Then Exit

$Title = IniRead($ConfigFile, "Splash", "Title", "powered by: ImTheROY")
$ShowTime = IniRead($ConfigFile, "Splash", "ShowTime", 3)
$RunAfterApp = IniRead($ConfigFile, "Splash", "RunAfterApp", "")

$aiSize = _ImageSize($ImageFile)

;----------Detect Image Sizes
Func _ImageSize($ImgFullPath)
    Local $hWnd, $hGuiSwitch, $aCtrlSize, $aRetSize[2] = [0, 0]

    $hWnd = GUICreate($ImgFullPath, 0, 0, 0, 0, BitOR(0x80000000, 0x20000000), BitOR(0x00000080, 0x00000020))
    $hGuiSwitch = GUISwitch($hWnd)
    $aCtrlSize = ControlGetPos($hWnd, "", GUICtrlCreatePic($ImgFullPath, 0, 0, 0, 0))
    GUIDelete($hWnd)
    GUISwitch($hGuiSwitch)

    If IsArray($aCtrlSize) Then
        $aRetSize[0] = $aCtrlSize[2]; Width
        $aRetSize[1] = $aCtrlSize[3]; Height
        Return SetError(0, 0, $aRetSize)
    EndIf
    Return SetError(1, 0, $aRetSize)
EndFunc   ;==>_ImageSize

;-----Detect extension
$extension = StringMid($ImageFile, StringInStr($ImageFile, ".", 2, -1))

;-----Create GUI
$hGUI = GUICreate($Title, $aiSize[0], $aiSize[1], -1, -1, -1, $WS_EX_LAYERED)
GUISetState(@SW_SHOW)

;-----Load image
_GDIPlus_Startup()
$hImage = _GDIPlus_ImageLoadFromFile($ImageFile)
SetBitMap($hGUI, $hImage, 255)

GUISetState()

Sleep($ShowTime * 1000)

Func SetBitmap($hGUI, $hImage, $iOpacity)
	Local $hScrDC, $hMemDC, $hBitmap, $hOld, $pSize, $tSize, $pSource, $tSource, $pBlend, $tBlend

	$hScrDC = _WinAPI_GetDC(0)
	$hMemDC = _WinAPI_CreateCompatibleDC($hScrDC)
	$hBitmap = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImage)
	$hOld = _WinAPI_SelectObject($hMemDC, $hBitmap)
	$tSize = DllStructCreate($tagSIZE)
	$pSize = DllStructGetPtr($tSize)
	DllStructSetData($tSize, "X", _GDIPlus_ImageGetWidth($hImage))
	DllStructSetData($tSize, "Y", _GDIPlus_ImageGetHeight($hImage))
	$tSource = DllStructCreate($tagPOINT)
	$pSource = DllStructGetPtr($tSource)
	$tBlend = DllStructCreate($tagBLENDFUNCTION)
	$pBlend = DllStructGetPtr($tBlend)
	DllStructSetData($tBlend, "Alpha", $iOpacity)
	DllStructSetData($tBlend, "Format", 1)
	_WinAPI_UpdateLayeredWindow($hGUI, $hScrDC, 0, $pSize, $hMemDC, $pSource, 0, $pBlend, $ULW_ALPHA)
	_WinAPI_ReleaseDC(0, $hScrDC)
	_WinAPI_SelectObject($hMemDC, $hOld)
	_WinAPI_DeleteObject($hBitmap)
	_WinAPI_DeleteDC($hMemDC)
EndFunc   ;==>SetBitmap



;-----RUN APP
If $RunAfterApp <> "" And FileExists($RunAfterApp) Then
	Run($RunAfterApp)
EndIf



#region Functions
Func _GetConfigFile($filename, $silent = False)
	Local $configfilename
	$configfilename = @ScriptDir & "\" & $filename

	If Not FileExists($configfilename) Then
		If Not $silent Then
			MsgBox(16, "File Missing", "The file " & $filename & " is not available." & @CRLF & "Please ensure that it is located in the " & @ScriptDir & " directory." & @CRLF & "The application will now exit.")
			Exit
		EndIf
		SetError(1)
		Return "Error"
	EndIf
	Return $configfilename
EndFunc   ;==>_GetConfigFile
#endregion Functions