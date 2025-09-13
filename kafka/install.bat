@echo off
REM Kafka Python Environment Setup for Windows
REM This script sets up a virtual environment and installs dependencies

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
echo.
echo To run the applications:
echo 1. Producer: python kafka-producer.py
echo 2. Consumer: python kafka-consumer.py
echo.
echo To activate the virtual environment manually:
echo .venv-win\Scripts\activate
echo.
echo Make sure your Kafka server is running on localhost:9092
echo.

REM Ask if user wants to test the installation
set /p test_install="Do you want to test the consumer now? (y/n): "
if /i "%test_install%"=="y" (
    echo Starting consumer test...
    python kafka-consumer.py
) else (
    echo Setup complete. You can run the applications manually.
)

pause