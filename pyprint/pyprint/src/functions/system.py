from sys import platform
from src.enums.os import OS


def is_linux():
    return platform == OS.LINUX1 or platform == OS.LINUX2

def is_windows():
    return platform == OS.WINDOWS

def is_macos():
    return platform == OS.MACOS

