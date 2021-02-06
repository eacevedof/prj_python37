from src.factories.log_factory import get_log
from src.components.cmd_component import CmdComponent

# Use EnumPrintersW to list local printers with their names and descriptions.
# Tested with CPython 2.7.10 and IronPython 2.7.5.

import ctypes
from ctypes.wintypes import BYTE, DWORD, LPCWSTR

winspool = ctypes.WinDLL('winspool.drv')  # for EnumPrintersW
msvcrt = ctypes.cdll.msvcrt  # for malloc, free

# Parameters: modify as you need. See MSDN for detail.
PRINTER_ENUM_LOCAL = 2
Name = None  # ignored for PRINTER_ENUM_LOCAL
Level = 1  # or 2, 4, 5

class PRINTER_INFO_1(ctypes.Structure):
    _fields_ = [
        ("Flags", DWORD),
        ("pDescription", LPCWSTR),
        ("pName", LPCWSTR),
        ("pComment", LPCWSTR),
    ]



class PrintWindowsComponent:

    def __init__(self):
        self.__log = get_log()


    def get_printers(self):
        # Invoke once with a NULL pointer to get buffer size.
        info = ctypes.POINTER(BYTE)()
        pr(info,"info")
        pcbNeeded = DWORD(0)
        pcReturned = DWORD(0)  # the number of PRINTER_INFO_1 structures retrieved
        winspool.EnumPrintersW(PRINTER_ENUM_LOCAL, Name, Level, ctypes.byref(info), 0,
                ctypes.byref(pcbNeeded), ctypes.byref(pcReturned))

        bufsize = pcbNeeded.value
        buffer = msvcrt.malloc(bufsize)
        winspool.EnumPrintersW(PRINTER_ENUM_LOCAL, Name, Level, buffer, bufsize,
                ctypes.byref(pcbNeeded), ctypes.byref(pcReturned))
        info = ctypes.cast(buffer, ctypes.POINTER(PRINTER_INFO_1))
        for i in range(pcReturned.value):
            print(info[i].pName)
            #print info[i].pName, '=>', info[i].pDescription
        msvcrt.free(buffer)
        return info

    