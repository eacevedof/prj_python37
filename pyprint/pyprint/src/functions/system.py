from sys import platform
from src.enums.os import OS
from src.factories.log_factory import get_log


log = get_log()
log.save(platform,"platform")

def is_linux():
    print(platform)
    return platform == OS.LINUX1.value or platform == OS.LINUX2.value

def is_windows():
    return platform == OS.WINDOWS.value

def is_macos():
    return platform == OS.MACOS.value

def get_os():
    if is_linux():
        return OS.LINUX1.value
    
    if is_windows():
        return OS.WINDOWS.value

    if is_macos():
        return OS.MACOS.value

    return "Not found"