#!/bin/bash
# Kafka Python Environment Setup for Linux/WSL
# This script sets up a virtual environment and installs dependencies

set -e  # Exit on any error

echo "Setting up Kafka Python environment for Linux/WSL..."

# Get the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# Check if we're in WSL or native Linux
if grep -qi microsoft /proc/version 2>/dev/null; then
    echo "Detected WSL environment"
    ENV_NAME=".venv-wsl"
else
    echo "Detected native Linux environment"
    ENV_NAME=".venv-linux"
fi

# Check if python3 is available
if ! command -v python3 &> /dev/null; then
    echo "ERROR: python3 is not installed or not in PATH"
    echo "Please install python3 first:"
    echo "  Ubuntu/Debian: sudo apt update && sudo apt install python3 python3-venv python3-pip"
    echo "  CentOS/RHEL: sudo yum install python3 python3-venv python3-pip"
    exit 1
fi

# Create virtual environment
echo "Creating virtual environment: $ENV_NAME"
python3 -m venv "$ENV_NAME"

# Activate virtual environment
echo "Activating virtual environment..."
source "$ENV_NAME/bin/activate"

# Upgrade pip
echo "Upgrading pip..."
"$ENV_NAME/bin/python" -m pip install --upgrade pip

# Install requirements
echo "Installing dependencies from requirements.txt..."
"$ENV_NAME/bin/python" -m pip install -r requirements.txt

echo ""
echo "========================================"
echo "Setup completed successfully!"
echo "========================================"
echo ""
echo "To run the applications:"
echo "1. Activate environment: source $ENV_NAME/bin/activate"
echo "2. Producer: python kafka-producer.py"
echo "3. Consumer: python kafka-consumer.py"
echo ""
echo "Environment details:"
echo "- Virtual env: $ENV_NAME"
echo "- Python: $("$ENV_NAME/bin/python" --version)"
echo "- Pip packages installed:"
"$ENV_NAME/bin/pip" list
echo ""
echo "Make sure your Kafka server is running on localhost:9092"
echo ""

# Ask if user wants to test the installation
read -p "Do you want to test the consumer now? (y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Starting consumer test..."
    python kafka-consumer.py
else
    echo "Setup complete. You can run the applications manually."
fi