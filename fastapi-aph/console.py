#!/usr/bin/env python3
"""
Console command entry point
Usage: python console.py <command-name>
"""

from app.console.console import main
import asyncio

if __name__ == "__main__":
    asyncio.run(main())