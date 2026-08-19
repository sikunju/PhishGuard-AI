@echo off
title PhishGuard AI - Build Windows Executable
color 0A

echo ==========================================================
echo   Building PhishGuardAI.exe with PyInstaller (free, local)
echo ==========================================================
echo.

if not exist "venv\Scripts\activate.bat" (
    echo Virtual environment not found. Please run setup_windows.bat first.
    pause
    exit /b 1
)

call venv\Scripts\activate.bat

echo Ensuring PyInstaller is installed...
pip install pyinstaller >nul 2>&1

echo Cleaning previous build artifacts...
if exist "build" rmdir /s /q build
if exist "dist" rmdir /s /q dist
if exist "PhishGuardAI.spec" del /q PhishGuardAI.spec

echo Building PhishGuardAI.exe ...
pyinstaller --noconfirm --windowed --name "PhishGuardAI" ^
    --add-data "data;data" ^
    --add-data "datasets;datasets" ^
    --add-data "models;models" ^
    --collect-all PySide6 ^
    app\main.py

if errorlevel 1 (
    echo.
    echo Build failed. See the output above for details.
    pause
    exit /b 1
)

echo.
echo ==========================================================
echo   Build complete!
echo   Executable: dist\PhishGuardAI\PhishGuardAI.exe
echo   Copy the entire dist\PhishGuardAI folder to distribute/run
echo   it portably (e.g. from a USB drive) -- no installer needed.
echo ==========================================================
pause
