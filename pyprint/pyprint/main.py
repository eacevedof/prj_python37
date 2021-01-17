import os
import ctypes
import subprocess
from pprint import pprint

# https://askubuntu.com/questions/416995/how-to-list-all-available-printers-from-terminal


def exec(cmd):
    proc = subprocess.Popen([cmd],stdout=subprocess.PIPE, shell=True)
    (out, err) = proc.communicate()
    pprint(proc)
    print(out)
    print(err)
    return out

def printit():
    pathfile = "./to-print.txt"
    printer = ""
    os.startfile(pathfile, printer)

def show_printers():
    cmd = "lpstat -p | awk '{print $2}'"
    r = os.popen(cmd).read()
    pprint(r)


def show_pool():
    cmd = "lpstat -p | awk '{print $2}' | xargs -n1 lpq -P"
    r = exec(cmd)
    print(r)

def show_printers2():
    cmd = "lpstat -p | awk '{print $2}'"
    r = exec(cmd)
    print(r)


if __name__ == "__main__":
    # show_printers()
    show_printers2()