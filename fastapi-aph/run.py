#!/usr/bin/env python3
"""
Convenience runner script for common commands
Usage: 
    python run.py dev          # Start development server
    python run.py test         # Run tests  
    python run.py deploy       # Run deploy command
    python run.py <command>    # Run console command
"""

import sys
import subprocess
import os

def main():
    if len(sys.argv) < 2:
        print("Usage: python run.py <command>")
        print("Available shortcuts:")
        print("  dev    - Start development server")
        print("  test   - Run tests")
        print("  deploy - Run deploy console command")
        print("  <cmd>  - Run console command lz:<cmd>")
        sys.exit(1)
    
    command = sys.argv[1]
    
    # Command shortcuts
    if command == "dev":
        os.system("uvicorn app.main:app --reload --host 0.0.0.0 --port 8000")
    elif command == "test":
        os.system("pytest -v")
    elif command == "deploy":
        os.system("python console.py lz:deploy")
    else:
        # Try to run as console command
        console_command = f"lz:{command}" if not command.startswith("lz:") else command
        os.system(f"python console.py {console_command}")

if __name__ == "__main__":
    main()