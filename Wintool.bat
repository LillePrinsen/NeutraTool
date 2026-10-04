@echo off
setlocal
cd /d "%~dp0"

:: --- Check for admin, self-elevate if needed ---
net session >nul 2>&1
if errorlevel 1 (
    echo Requesting administrator privileges...
    powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)

:: --- Verify the PS1 exists ---
if not exist "%~dp0WinTool.ps1" (
    echo.
    echo  ERROR: WinTool.ps1 was not found next to this launcher.
    echo  Put both files in the SAME folder.
    echo.
    pause
    exit /b 1
)

:: --- Launch the tool ---
powershell -NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File "%~dp0WinTool.ps1"

if errorlevel 1 (
    echo.
    echo  The tool exited with an error.
    echo  See: %TEMP%\WinTool-error.log
    echo.
    pause
)