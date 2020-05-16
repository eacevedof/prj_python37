import sys
from core.core import Core as core
from core.core import get_row_by_keyval
from core.models.context import Context

class Pointcfg:

    dicconfig = {}

    def __init__(self, dicconfig):
        self.dicconfig = dicconfig


    def get(self, key=""):
        if key in self.dicconfig:
            return self.dicconfig[key]
        return None
    
    def get_format(self):
        return self.get("format")

    def get_table(self):
        return self.get("table")

    def get_context(self):
        pathfile = self.dicconfig["context"]["file"]
        id = self.dicconfig["context"]["id"]
        format = self.dicconfig["format"]
        ctx = Context(pathfile, id, format)
        if self.dicconfig["format"] == "database":
            # print(self.dicconfig); sys.exit()
            ctx.set_database(self.dicconfig["context"]["database"])
        return ctx

    def get_data():
        return self.dicconfig