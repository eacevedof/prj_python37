import sys
from pprint import pprint
import logging

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)

def die(msg: str) -> None:
    """Log error message and exit"""
    pprint(f" ============================================ [DIE] {msg}")
    sys.exit(1)

def err(msg: str) -> None:
    """Log error message and exit"""
    pprint(f" ============================================ [ERROR] {msg}")
