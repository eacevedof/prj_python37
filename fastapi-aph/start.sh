#!/bin/bash

# FastAPI APH API Start Script

set -e

echo "🚀 Starting FastAPI APH API"

# Check if virtual environment exists
if [ ! -d "venv" ]; then
    echo "📦 Creating virtual environment..."
    python3 -m venv ./.venv-wsl
fi

# Activate virtual environment
echo "🔧 Activating virtual environment..."
source ./.venv-wsl/bin/activate

# Install dependencies
echo "📥 Installing dependencies..."
pip install --upgrade pip
pip install -r requirements.txt

# Load environment variables
if [ -f ".env" ]; then
    echo "🔧 Loading environment variables..."
    export $(grep -v '^#' .env | xargs)
fi

# Start the application using the front controller
echo "🌟 Starting FastAPI application..."
echo "📍 API will be available at: http://localhost:8000"
echo "📖 Documentation will be available at: http://localhost:8000/docs"
echo "🔍 Health check: http://localhost:8000/health"

python public/index.py