from src.factories.log_factory import get_log
from src.components.cmd_component import CmdComponent

class PrintOsxComponent:

    def __init__(self):
        self.__log = get_log()


    def get_printers(self):
        cmd = "lpstat -p | awk '{print $2}'"
        self.__log.save(cmd,"cmd get_printers")
        r = CmdComponent.exec(cmd)
        return r

    