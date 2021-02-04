from sys import platform
from src.enums.os import OS
from src.factories.log_factory import get_log


log = get_log()
log.save(platform,"platform")

def is_linux():
    print(platform)
    return platform == OS.LINUX1 or platform == OS.LINUX2

def is_windows():
    return platform == OS.WINDOWS

def is_macos():
    return platform == OS.MACOS

def get_os():
    if is_linux():
        return OS.LINUX1
    
    if is_windows():
        return OS.WINDOWS

    if is_macos():
        return OS.MACOS

    return "Not found"