import os
import ctypes


def printit():
    pathfile = "./to-print.txt"
    printer = ""
    os.startfile(pathfile, printer)

def show_printers():
    cmd = "lpstat -p | awk '{print $2}'"
    os.system(cmd)


if __name__ == "__main__":
    show_printers()