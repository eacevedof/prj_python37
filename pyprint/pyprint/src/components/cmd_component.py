from subprocess import PIPE, Popen
from src.factories.log_factory import get_log

class CmdComponent:

    def __init__(self):
        self.__log = get_log()

    @staticmethod
    def exec(cmd: str) -> str:
        process = Popen(
            args=cmd,
            stdout=PIPE,
            shell=True
        )
        return process.communicate()[0]

