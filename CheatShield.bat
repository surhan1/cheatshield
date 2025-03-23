@echo off 
title Cheat Shield v1.0.0
color 9
chcp 65001 >nul 2>&1

:menu
echo.   
echo.                  ██████╗██╗  ██╗███████╗ █████╗ ████████╗    ███████╗██╗  ██╗██╗███████╗██╗     ██████╗ 
echo.                 ██╔════╝██║  ██║██╔════╝██╔══██╗╚══██╔══╝    ██╔════╝██║  ██║██║██╔════╝██║     ██╔══██╗
echo.                 ██║     ███████║█████╗  ███████║   ██║       ███████╗███████║██║█████╗  ██║     ██║  ██║
echo.                 ██║     ██╔══██║██╔══╝  ██╔══██║   ██║       ╚════██║██╔══██║██║██╔══╝  ██║     ██║  ██║
echo.                 ╚██████╗██║  ██║███████╗██║  ██║   ██║       ███████║██║  ██║██║███████╗███████╗██████╔╝
echo.                  ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝   ╚═╝       ╚══════╝╚═╝  ╚═╝╚═╝╚══════╝╚══════╝╚═════╝ 
echo.
echo.                                     ╔═══════════════════════════════════════╗
echo.                                     ║ [1] Start scan                        ║
echo.                                     ╠═══════════════════════════════════════╣
echo.                                     ║ [2] Process list                      ║
echo.                                     ╠═══════════════════════════════════════╣
echo.                                     ║ [3] Last activity viewer              ║
echo.                                     ╠═══════════════════════════════════════╣
echo.                                     ║ [4] Exit                              ║
echo.                                     ╚═══════════════════════════════════════╝
echo.
set /p input=═══════════^>  
if /I "%input%"=="1" goto :scan
if /I "%input%"=="2" goto :pl
if /I "%input%"=="3" goto :lav
if /I "%input%"=="4" goto :exit

:scan
cls
echo [CHEAT SHIELD] Scanning system for known cheats
timeout /t 2 >nul
echo [CHEAT SHIELD] Checking downloads
echo.
timeout /t 1 >nul

if exist "%UserProfile%\Downloads\Wave-Setup.exe" (
    echo [DETECTION] Wave executor found in downloads
) else (
    echo [CS] Wave executor not found in downloads
)

if exist "%UserProfile%\Downloads\Bootstrapper.exe" (
    echo [DETECTION] Solara V3 executor found in downloads
) else (
    echo [CS] Solara V3 executor not found in downloads
)

if exist "%UserProfile%\Downloads\CeleryExecutor.zip" (
    echo [DETECTION] Celery executor found in downloads
) else (
    echo [CS] Celery executor not found in downloads
) 

if exist "%UserProfile%\Downloads\Synz" (
    echo [DETECTION] Synapse Z executor found in downloads
) else (
    echo [CS] Synapse Z executor not found in downloads
)

timeout /t 1 >nul
echo.
echo [CHEAT SHIELD] Checking for auto execute folders - this may take a while
echo.
timeout /t 1 >nul


for /f "delims=" %%G in ('dir C:\autoexec /ad /s /b 2^>nul') do (
    echo [DETECTION] "autoexec" folder found at: %%G
    set "found=1"
)

if not defined found (
    echo [CS] No "autoexec" folder found on this PC.
)

timeout /t 1 >nul
echo.
echo [CHEAT SHIELD] Checking currently running proccesses
echo.
timeout /t 1 >nul


tasklist /fi "imagename eq CeleryApp.exe" | find /i "CeleryApp.exe" >nul
if %errorlevel%==0 (
    echo [DETECTION] Celery is running
) else (
    echo [CS] Celery is not running
)

tasklist /fi "imagename eq Wave.exe" | find /i "Wave.exe" >nul
if %errorlevel%==0 (
    echo [DETECTION] Wave is running
) else (
    echo [CS] Wave is not running
)

tasklist /fi "imagename eq Solara.exe" | find /i "Solara.exe" >nul
if %errorlevel%==0 (
    echo [DETECTION] Solara is running
) else (
    echo [CS] Solara is not running
)

tasklist /fi "imagename eq Clumsy.exe" | find /i "Clumsy.exe" >nul
if %errorlevel%==0 (
    echo [DETECTION] Clumsy is running
) else (
    echo [CS] Clumsy is not running
)

timeout /t 1 >nul
echo.
echo [CHEAT SHIELD] Checking recycle bin
echo.
timeout /t 1 >nul
setlocal enabledelayedexpansion

if exist "C:\$Recycle.Bin" (
    echo Scanning C:\$Recycle.Bin...
    for /r "C:\$Recycle.Bin" %%f in (*.*) do (
        echo %%f | findstr /i "Synz Solara Bootstrapper Wave autoexec Celery Celex Matcha Clumsy Mumuplayer" >nul
        if !errorlevel! == 0 (
            echo [DETECTION] Potential cheat-related file found: %%f
        )
    )
) else (
    echo [CS] No Recycle Bin found on C drive
)

timeout /t 1 >nul
echo.
echo [CHEAT SHIELD] Scan completed
echo [CHEAT SHIELD] Please proceed with manual inspection
echo.
set /p dummy="Press enter to return to the menu..."
goto :menu

:lav
cls
echo [CHEAT SHIELD] Loading processes opened this session
timeout /t 2 >nul
powershell -Command "Get-Process | Where-Object { $_.StartTime -gt (Get-Date).AddHours(-48) } | Select-Object Name, Id, StartTime"
set /p dummy="Press enter to return to the menu..."
goto :menu

:pl
cls
echo [CHEAT SHIELD] Loading all running process..
timeout /t 2 >nul
tasklist
set /p dummy="Press enter to return to the menu..."
goto :menu

:exit
exit
