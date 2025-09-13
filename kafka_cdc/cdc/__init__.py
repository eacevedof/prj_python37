import sys
from pprint import pprint

def die(msg: str) -> None:
    """Log error message and exit"""
    pprint(f" ============================================ [DIE] {msg}")
    sys.exit(1)

def err(msg: str) -> None:
    """Log error message and exit"""
    pprint(f" ============================================ [ERROR] {msg}")
