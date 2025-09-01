#!/bin/bash

# FastAPI APH API Start Script

set -e

echo "🚀 Starting FastAPI APH API"

# Check if virtual environment exists
if [ ! -d "venv" ]; then
    echo "📦 Creating virtual environment..."
    python -m venv ./.venv-wsl
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

# Start the application
echo "🌟 Starting FastAPI application..."
echo "📍 API will be available at: http://localhost:8123"
echo "📖 Documentation will be available at: http://localhost:8123/docs"
echo "🔍 Health check: http://localhost:8123/health"

uvicorn app.main:app --host 0.0.0.0 --port 8123 --reload