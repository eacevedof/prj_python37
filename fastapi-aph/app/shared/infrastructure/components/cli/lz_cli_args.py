import sys
from typing import List, Optional


class LzCliArgs:
    _instance: Optional['LzCliArgs'] = None
    
    def __init__(self):
        self._args = sys.argv[1:]  # Skip the script name
    
    @classmethod
    def get_instance(cls) -> 'LzCliArgs':
        if cls._instance is None:
            cls._instance = cls()
        return cls._instance
    
    def get_args(self) -> List[str]:
        """Get all command line arguments"""
        return self._args
    
    def get_arg(self, index: int) -> str:
        """Get argument at specific index, return empty string if not found"""
        if 0 <= index < len(self._args):
            return self._args[index]
        return ""