@echo off
title PhishGuard AI
color 0A

if not exist "venv\Scripts\activate.bat" (
    echo Virtual environment not found. Please run setup_windows.bat first.
    pause
    exit /b 1
)

call venv\Scripts\activate.bat
echo Starting PhishGuard AI...
python app\main.py

if errorlevel 1 (
    echo.
    echo PhishGuard AI exited with an error. See logs\phishguard.log for details.
    pause
)
