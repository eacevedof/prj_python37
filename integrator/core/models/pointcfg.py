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
        #print(f"get_context_format: {format}");sys.exit()
        ctx = Context(pathfile, id, format)
        #pprint(ctx); sys.exit()
        if self.is_db():
            # print(self.dicconfig); sys.exit()
            ctx.set_database(self.dicconfig["context"]["database"])
        return ctx

    def get_data(self):
        return self.dicconfig

    def is_db(self):
        return self.dicconfig["format"] == "database"
    
    def is_file(self):
        return self.dicconfig["format"] in ["json","xml","csv","fixed","xls"]

    def is_api(self):
        return self.dicconfig["format"] == "api"