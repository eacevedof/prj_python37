import os
import ctypes

from src.components.cmd_component import CmdComponent
from pprint import pprint
#Common UNIX Printing System (CUPS)
# https://askubuntu.com/questions/416995/how-to-list-all-available-printers-from-terminal
# libreria en python (python-escpos)
# https://github.com/python-escpos/python-escpos
# https://stackoverflow.com/questions/24225647/docker-a-way-to-give-access-to-a-host-usb-or-serial-device


from src.factories.log_factory import get_log
class PrintComponent:

    def __init__(self):
        self.__log = get_log()


    def get_printers(self):
        cmd = "lpstat -p | awk '{print $2}'"
        self.__log.save(cmd,"cmd get_printers")
        r = CmdComponent.exec(cmd)
        return r


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
