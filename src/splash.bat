@echo off
title Quick Splash Creator
mode con cols=58 lines=11
COLOR 0c

::Introduccion...
echo Quick Splash Creator v.2.0.0
echo.
echo Todos los derechos reservados ธ -ImTheROY- 2012
echo.
echo Solo para uso personal.
echo Prohibida la venta y cambio de propietario del producto.
echo.
echo Todo el codigo fue escrito por ImTheROY.
echo.
echo Si esta de acuerdo, presione una tecla para continuar...
pause>nul
cls



mode con cols=100 lines=14
COLOR F0



goto exe

::ruta completa del exe
:errexe
COLOR 0c
cls
echo EL PROGRAMA DEBE DE SER .exe!
echo.
goto exe
:clsEXE
cls
:exe
echo Arrastra tu programa portable.exe aqui y luego presiona ENTER
echo.
set /p exeFULLdir=
cls

set exeDIR=%exeFULLdir:"=%

::Revisar si es .exe
if "%exeDIR:~-4%"==".exe" (goto buc1) else (goto errexe)

:buc1
if "%exeDIR:~-1%"=="\" (goto next1) else (set exeDIR=%exeDIR:~0,-1%)
goto buc1

:next1
set exeFILE=%exeFULLdir:"=%

:buc2
echo %exeFILE% | find "\"
if errorlevel 1 (goto next2) else (set exeFILE=%exeFILE:~1% & cls)
goto buc2

:next2
cls
COLOR F0
echo Directorio del exe: %exeDIR%
echo.
echo Nombre del programa: %exeFILE%
echo.
echo.
echo ษอออออออออออออออออออออออออออป
echo บEs correcta la informacion?บ
echo ฬอออออออออออออออออออออออออออน
echo บ           Si: 1           บ
echo บ           No: 2           บ
echo ศอออออออออออออออออออออออออออผ
set /p ans1=Escribe 1 o 2 y presiona ENTER: 
if %ans1%==2 (goto clsEXE) else (goto clsIMG)
cls



::ruta completa de imagen
:errimg
COLOR 0c
cls
echo LA IMAGEN DEBE SER .png, .jpg, .bmp O .gif!
echo.
goto img
:clsIMG
cls
:img
echo Arrastra tu imagen (png, jpg, bmp o gif[NO ANIMADO]) aqui y luego presiona ENTER
echo.
set /p imgFULLdir=
set imgFULLdir=%imgFULLdir:"=%
cls

set imgDIR=%imgFULLdir:"=%

::Revisar si la imagen es admitida
:png
if "%imgDIR:~-4%"==".png" (goto buc3) else (goto jpg)
:jpg
if "%imgDIR:~-4%"==".jpg" (goto buc3) else (goto jpeg)
:jpeg
if "%imgDIR:~-4%"==".jpeg" (goto buc3) else (goto bmp)
:bmp
if "%imgDIR:~-4%"==".bmp" (goto buc3) else (goto gif)
:gif
if "%imgDIR:~-4%"==".gif" (goto buc3) else (goto errimg)

:buc3
if "%imgDIR:~-1%"=="\" (goto next3) else (set imgDIR=%imgDIR:~0,-1%)
goto buc3

:next3
set imgFILE=%imgFULLdir:"=%

:buc4
echo %imgFILE% | find "\"
if errorlevel 1 (goto next4) else (set imgFILE=%imgFILE:~1% & cls)
goto buc4

:next4
cls
COLOR F0
echo Directorio de la imagen: %imgDIR%
echo.
echo Nombre de la imagen: %imgFILE%
echo.
echo.
echo ษอออออออออออออออออออออออออออป
echo บEs correcta la informacion?บ
echo ฬอออออออออออออออออออออออออออน
echo บ           Si: 1           บ
echo บ           No: 2           บ
echo ศอออออออออออออออออออออออออออผ
set /p ans2=Escribe 1 o 2 y presiona ENTER: 
if %ans2%==2 (goto clsIMG) else (goto size)



::Dimensiones de la imagen
:size
cls
echo Introduce las dimensiones de %imgFILE% (en pixeles)...
echo.
set /p imgWIDTH=Largo (Base): 
echo.
set /p imgHEIGHT=Altura: 
echo.
echo.
echo ษอออออออออออออออออออออออออออป
echo บEs correcta la informacion?บ
echo ฬอออออออออออออออออออออออออออน
echo บ           Si: 1           บ
echo บ           No: 2           บ
echo ศอออออออออออออออออออออออออออผ
set /p ans3=Escribe 1 o 2 y presiona ENTER: 
if %ans3%==2 goto size
cls



::Especificaciones del icono
echo ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
echo บAntes de importar el icono, desea ver las especificaciones del icono?บ
echo ฬอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออน
echo บ                                Si: 1                                บ
echo บ                                No: 2                                บ
echo ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
set /p ans4=Escribe 1 o 2 y presiona ENTER: 
if %ans4%==1 (start "" "iconinfo.txt") else (goto clsICO)
goto clsICO
cls



::Ruta completa del icono
:errico
COLOR 0c
cls
echo EL ICONO DEBE DE SER .ico!
echo.
goto ico
:clsICO
cls
:ico
echo Arrastra tu icono.ico aqui y luego presiona ENTER
echo.
set /p icoFULLdir=
set icoFULLdir=%icoFULLdir:"=%
cls

set icoDIR=%icoFULLdir:"=%

::Revisar si es .ico
if "%icoDIR:~-4%"==".ico" (goto buc5) else (goto errico)

:buc5
if "%icoDIR:~-1%"=="\" (goto next5) else (set icoDIR=%icoDIR:~0,-1%)
goto buc5

:next5
set icoFILE=%icoFULLdir:"=%

:buc6
echo %icoFILE% | find "\"
if errorlevel 1 (goto next6) else (set icoFILE=%icoFILE:~1% & cls)
goto buc6

:next6
cls
COLOR F0
echo Directorio del icono: %icoDIR%
echo.
echo Nombre del icono: %icoFILE%
echo.
echo.
echo ษอออออออออออออออออออออออออออป
echo บEs correcta la informacion?บ
echo ฬอออออออออออออออออออออออออออน
echo บ           Si: 1           บ
echo บ           No: 2           บ
echo ศอออออออออออออออออออออออออออผ
set /p ans1=Escribe 1 o 2 y presiona ENTER: 
if %ans1%==2 (goto clsICO) else (goto ttl)
cls



::Titulo del Splash
:ttl
cls
set /p splashTITLE=Escribe el titulo del Splash: 
cls



::Duracion del Splash
cls
set /p splashTIME=Por cuantos segundos se mostrara el Splash?: 
cls



::Compilar codigo AutoIt3
cls
echo compilando launcher, espere...
echo.
build\Aut2exe.exe /in "build\splash.au3" /icon "%icoFULLdir%" /pack
cls



::Obtiene directorio donde se esta ejecutando el BAT
set batDIR=%0
set batDIR=%batDIR:"=%

:batbuc
if "%batDIR:~-1%"=="\" (goto setini) else (set batDIR=%batDIR:~0,-1%)
goto batbuc



::Crea primeras lineas del .ini
:setini
cls
echo Creando archivos, espere...

>splash.ini echo [Splash]
>>splash.ini echo Title=%splashTITLE%
>>splash.ini echo ImageFile=%imgFILE%
>>splash.ini echo ImageWidth=%imgWIDTH%
>>splash.ini echo ImageHeight=%imgHEIGHT%
>>splash.ini echo ShowTime=%splashTIME%



::Copiar archivos
:cop
cls
echo copiando archivos, espere...
move /y "%batDIR%build\splash.exe" "%exeDIR%"
copy /y "%imgFULLdir%" "%exeDIR%"
cls



:Acciones...
cls
mode con cols=81 lines=7
echo ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
echo บ                               Que desea hacer?                               บ
echo ฬออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออน
echo บ1:    Seguir usando los accesos directos al programa (se renombraran archivos)บ
echo บ2: Usar el nombre "splash.exe" como launcher (recomendado si se va a compilar)บ
echo ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
set /p ans1=Escribe 1 o 2 y presiona ENTER: 
if %ans1%==1 goto rena

::FINALIZAR

>>splash.ini echo RunAfterApp=%exeFILE%

move "splash.ini" "%exeDIR%"

cls
mode con cols=90 lines=6
echo LISTO! los archivos estan listos en "%exeDIR%"
echo.
echo.
echo.
echo Presione una tecla para probar el Splash o cierre la ventana para hacerlo manualmente...
pause>nul

start "" "%exeDIR%splash.exe"
exit


:rena

>>splash.ini echo RunAfterApp=[original]%exeFILE%

move "splash.ini" "%exeDIR%"

cls
rename "%exeDIR%%exeFILE%" "[original]%exeFILE%"
rename "%exeDIR%splash.exe" "%exeFILE%"

cls
mode con cols=90 lines=6
echo LISTO! los archivos estan listos en "%exeDIR%"
echo.
echo.
echo.
echo Presione una tecla para probar el Splash o cierre la ventana para hacerlo manualmente...
pause>nul

start "" "%exeDIR%%exeFILE%"
exit