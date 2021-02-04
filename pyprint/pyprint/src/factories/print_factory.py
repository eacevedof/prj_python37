from src.functions.system import *
from src.components.print_osx_component import PrintOsxComponent
from src.components.print_windows_component import PrintWindowsComponent

def get_print_component():
    
    if is_linux() or is_macos():
        return PrintOsxComponent()
    elif is_windows():
        return PrintWindowsComponent()