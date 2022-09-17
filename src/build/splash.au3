#include "Include\GDIPlus.au3"
#include "Include\WindowsConstants.au3"
#include "Include\GUIConstantsEx.au3"

Dim $ConfigFile ;Configuration File

Dim $ImageFile ;Image to be shown.  Must be PNG
Dim $ImageWidth ;Width of the image to display in pixels
Dim $ImageHeight ;Height of image in pixels
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

$ImageHeight = IniRead($ConfigFile, "Splash", "ImageHeight", 1)
$ImageWidth = IniRead($ConfigFile, "Splash", "ImageWidth", 1)
$Title = IniRead($ConfigFile, "Splash", "Title", "powered by: ImTheROY")
$ShowTime = IniRead($ConfigFile, "Splash", "ShowTime", 3)
$RunAfterApp = IniRead($ConfigFile, "Splash", "RunAfterApp", "")

$swfObj = ObjCreate("ShockwaveFlash.ShockwaveFlash")
$swfActiveX = GUICtrlCreateObj($swfObj, 0, 0, $ImageWidth, $ImageHeight)

;-----Detect extension
$extension = StringMid($ImageFile, StringInStr($ImageFile, ".", 2, -1))

;-----Create GUI
$hGUI = GUICreate($Title, $ImageWidth, $ImageHeight, -1, -1, -1, $WS_EX_LAYERED)
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