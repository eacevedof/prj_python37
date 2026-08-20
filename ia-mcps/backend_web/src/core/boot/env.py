import os
from pathlib import Path

from dotenv import load_dotenv

# .../backend_web/src/core/boot/env.py -> parents[3] = backend_web
load_dotenv(Path(__file__).resolve().parents[3] / ".env")


def get(key: str, default: str = "") -> str:
    return os.environ.get(key, default)
