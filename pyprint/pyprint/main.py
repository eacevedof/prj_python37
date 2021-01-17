import os
import ctypes
from subprocess import PIPE, Popen
from pprint import pprint

#Common UNIX Printing System (CUPS)
# https://askubuntu.com/questions/416995/how-to-list-all-available-printers-from-terminal
# libreria en python (python-escpos)
# https://github.com/python-escpos/python-escpos

def exec(cmd):
    process = Popen(
        args=cmd,
        stdout=PIPE,
        shell=True
    )
    return process.communicate()[0]

def printit():
    print("printing....")
    pathfile = "./to-print.txt"
    printer = "Brother_DCP_1610W_series"
    # os.startfile(pathfile, printer) # error
    cmd = f"lpr -P {printer} {pathfile}"
    r = exec(cmd)
    print(r)

def show_printers():
    cmd = "lpstat -p | awk '{print $2}'"
    r = os.popen(cmd).read()
    print(r)

def show_printers2():
    print("show printers 2:\n")
    cmd = "lpstat -p | awk '{print $2}'"
    r = exec(cmd)
    print(r)

def show_pool():
    print("show pool:\n")
    cmd = "lpstat -p | awk '{print $2}' | xargs -n1 lpq -P"
    r = exec(cmd)
    print(r)

if __name__ == "__main__":
    show_printers()
    show_printers2()
    show_pool()
    printit()