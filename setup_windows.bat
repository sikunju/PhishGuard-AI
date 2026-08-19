@echo off
setlocal enabledelayedexpansion
title PhishGuard AI - Setup
color 0A

echo ==========================================================
echo   PhishGuard AI - Setup (100%% Free, Offline-First)
echo ==========================================================
echo.

REM ----------------------------------------------------------------
REM 1. Check Python installation
REM ----------------------------------------------------------------
echo [1/7] Checking Python installation...
python --version >nul 2>&1
if errorlevel 1 (
    echo.
    echo ERROR: Python was not found on PATH.
    echo Please install Python 3.12+ from https://www.python.org/downloads/
    echo and make sure "Add Python to PATH" is checked during installation.
    echo.
    pause
    exit /b 1
)
python --version
echo.

REM ----------------------------------------------------------------
REM 2. Create virtual environment
REM ----------------------------------------------------------------
echo [2/7] Creating virtual environment (venv)...
if not exist "venv" (
    python -m venv venv
    if errorlevel 1 (
        echo ERROR: Failed to create virtual environment.
        pause
        exit /b 1
    )
) else (
    echo Virtual environment already exists, skipping.
)
echo.

REM ----------------------------------------------------------------
REM 3. Activate virtual environment
REM ----------------------------------------------------------------
echo [3/7] Activating virtual environment...
call venv\Scripts\activate.bat
if errorlevel 1 (
    echo ERROR: Failed to activate virtual environment.
    pause
    exit /b 1
)
echo.

REM ----------------------------------------------------------------
REM 4. Install free dependencies
REM ----------------------------------------------------------------
echo [4/7] Installing dependencies (all free/open-source)...
python -m pip install --upgrade pip
pip install -r requirements.txt
if errorlevel 1 (
    echo ERROR: Dependency installation failed.
    pause
    exit /b 1
)
echo.

REM ----------------------------------------------------------------
REM 5. Create required directories
REM ----------------------------------------------------------------
echo [5/7] Creating required directories...
if not exist "models" mkdir models
if not exist "datasets" mkdir datasets
if not exist "data" mkdir data
if not exist "reports" mkdir reports
if not exist "logs" mkdir logs
echo Directories ready.
echo.

REM ----------------------------------------------------------------
REM 6. Initialize database
REM ----------------------------------------------------------------
echo [6/7] Initializing local SQLite database...
python scripts\init_db.py
echo.

REM ----------------------------------------------------------------
REM 7. Generate dataset + train/load local ML model
REM ----------------------------------------------------------------
echo [7/7] Preparing local ML model...
if not exist "datasets\sample_urls.csv" (
    echo Generating sample dataset...
    python scripts\generate_dataset.py
)
if not exist "models\phishing_model.joblib" (
    echo Training local ML model - this runs 100%% on-device, no cloud AI...
    python scripts\train_model.py --algorithm random_forest
) else (
    echo Existing trained model found, skipping training.
)
echo.

echo ==========================================================
echo   Setup complete!
echo   Run "run_windows.bat" to launch PhishGuard AI.
echo ==========================================================
echo.
pause
