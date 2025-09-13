@echo off
REM kafka cdc in python for windows
REM create venv and install requirements

echo Setting up Kafka Python environment for Windows...

REM Change to kafka directory
cd /d "%~dp0"

REM Create virtual environment
echo Creating virtual environment...
python -m venv .venv-win
if errorlevel 1 (
    echo ERROR: Failed to create virtual environment
    echo Make sure Python is installed and accessible
    pause
    exit /b 1
)

REM Activate virtual environment
echo Activating virtual environment...
call .venv-win\Scripts\activate

REM Upgrade pip
echo Upgrading pip...
.venv-win\Scripts\python.exe -m pip install --upgrade pip
if errorlevel 1 (
    echo WARNING: Failed to upgrade pip, continuing...
)

REM Install requirements
echo Installing dependencies from requirements.txt...
.venv-win\Scripts\python.exe -m pip install -r requirements.txt
if errorlevel 1 (
    echo ERROR: Failed to install requirements
    pause
    exit /b 1
)

echo.
echo ========================================
echo Setup completed successfully!
echo ========================================
