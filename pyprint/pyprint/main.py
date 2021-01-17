import os
import ctypes
import subprocess
from pprint import pprint


def printit():
    pathfile = "./to-print.txt"
    printer = ""
    os.startfile(pathfile, printer)

def show_printers():
    cmd = "lpstat -p | awk '{print $2}'"
    r = os.popen(cmd).read()
    pprint(r)


def show_printers2():
    cmd = "lpstat -p | awk '{print $2}'"
    proc = subprocess.Popen([cmd],stdout=subprocess.PIPE, shell=True)
    (out, err) = proc.communicate()
    pprint(proc)
    print(out)
    print(err)

if __name__ == "__main__":
    # show_printers()
    show_printers2()