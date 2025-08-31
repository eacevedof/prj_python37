import sys
from typing import NoReturn


class CliColor:
    """Console color utilities for CLI output"""
    
    @staticmethod
    def die_red(text: str) -> NoReturn:
        """Print red text and exit with code 1"""
        CliColor.echo_red(text)
        sys.exit(1)
    
    @staticmethod
    def echo_blue(text: str) -> None:
        """Print blue text"""
        print(CliColor.get_color_blue(text))
    
    @staticmethod
    def echo_green(text: str) -> None:
        """Print green text"""
        print(CliColor.get_color_green(text))
    
    @staticmethod
    def echo_orange(text: str) -> None:
        """Print orange text"""
        print(CliColor.get_color_orange(text))
    
    @staticmethod
    def echo_red(text: str) -> None:
        """Print red text to stderr"""
        print(CliColor.get_color_red(text), file=sys.stderr)
    
    @staticmethod
    def echo_white(text: str) -> None:
        """Print white text"""
        print(CliColor.get_color_white(text))
    
    @staticmethod
    def echo_yellow(text: str) -> None:
        """Print yellow text"""
        print(CliColor.get_color_yellow(text))
    
    @staticmethod
    def get_color_blue(text: str) -> str:
        """Get text with blue ANSI color codes"""
        return f"\033[94m{text}\033[0m"
    
    @staticmethod
    def get_color_green(text: str) -> str:
        """Get text with green ANSI color codes"""
        return f"\033[92m{text}\033[0m"
    
    @staticmethod
    def get_color_orange(text: str) -> str:
        """Get text with orange ANSI color codes"""
        return f"\033[38;5;214m{text}\033[0m"
    
    @staticmethod
    def get_color_red(text: str) -> str:
        """Get text with red ANSI color codes"""
        return f"\033[91m{text}\033[0m"
    
    @staticmethod
    def get_color_white(text: str) -> str:
        """Get text with white ANSI color codes"""
        return f"\033[97m{text}\033[0m"
    
    @staticmethod
    def get_color_yellow(text: str) -> str:
        """Get text with yellow ANSI color codes"""
        return f"\033[93m{text}\033[0m"
    
    @staticmethod
    def get_yellow(text: str) -> str:
        """Alias for get_color_yellow"""
        return CliColor.get_color_yellow(text)