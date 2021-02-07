from src.factories.log_factory import get_log
from src.components.cmd_component import CmdComponent
import win32print

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
        # ctypes.wintypes.LP_c_byte
        devices = ctypes.POINTER(BYTE)()
        pr(devices,"devices")
        pcbNeeded = DWORD(0)
        pr(pcbNeeded,"pcbneeded")
        pcReturned = DWORD(0)  # the number of PRINTER_INFO_1 structures retrieved
        pr(pcReturned,"pcreturned")
        winspool.EnumPrintersW(PRINTER_ENUM_LOCAL, Name, Level, ctypes.byref(devices), 0,
                ctypes.byref(pcbNeeded), ctypes.byref(pcReturned))

        bufsize = pcbNeeded.value
        buffer = msvcrt.malloc(bufsize)
        winspool.EnumPrintersW(PRINTER_ENUM_LOCAL, Name, Level, buffer, bufsize,
                ctypes.byref(pcbNeeded), ctypes.byref(pcReturned))
        devices = ctypes.cast(buffer, ctypes.POINTER(PRINTER_INFO_1))

        printers = []
        for i in range(pcReturned.value):
            print(devices[i].pName)
            printers.append({"name": devices[i].pName, "description":devices[i].pDescription})
            #print devices[i].pName, '=>', devices[i].pDescription
        msvcrt.free(buffer)
        return printers

    
    def print(self):
        tempprinter = "\\\\server01\\printer01"
        currentprinter = win32print.GetDefaultPrinter()

        win32print.SetDefaultPrinter(tempprinter)
        win32api.ShellExecute(0, "print", filename, None,  ".",  0)
        win32print.SetDefaultPrinter(currentprinter)
        pass
        #win32api.ShellExecute(0, 'open', 'gsprint.exe', '-printer "\\\\' + self.server + '\\' + self.printer_name + '" ' + file, '.', 0)