import sys
from typing import List, Optional


class LzCliArgs:
    __instance: Optional['LzCliArgs'] = None
    
    def __init__(self):
        self.__args = sys.argv[1:]  # Skip the script name
    
    @classmethod
    def get_instance(cls) -> 'LzCliArgs':
        if cls.__instance is None:
            cls.__instance = cls()
        return cls.__instance
    
    def get_args(self) -> List[str]:
        """Get all command line arguments"""
        return self.__args
    
    def get_arg(self, index: int) -> str:
        """Get argument at specific index, return empty string if not found"""
        if 0 <= index < len(self.__args):
            return self.__args[index]
        return ""