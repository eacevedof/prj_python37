import sys
from core.core import Core as core, get_row_by_keyval
from core.models.base import Base
from core.helpers.json import Json

class Context(Base):

    format = ""
    database = ""

    def __init__(self, pathfile, id, format):
        pathcontext = core.get_path_context(pathfile)
        super().__init__(pathcontext, id)
        self.format = format

    def _is_file(self):
        formats = ["json","csv","xls","xml","fixed"]
        return self.format in formats

    def _is_db(self):
        return self.format == "database"

    def _is_api(self):
        return self.format == "api"

    def get_content(self):
        if self._is_file():
            pathconf = core.get_path_in(self.get("path"))
            ojson = Json(pathconf)
            return ojson.get_loaded()
        return {"msg":"this context is not a file"}


    def get_dbconfig(self):
        if self._is_db():
            schemas = self.get("schemas")
            # print("get_data\n")
            # print(self.get_data())
            dbconfig = get_row_by_keyval(schemas, "database", self.database)
            # print(dbconfig); sys.exit()
            config = {
                "host":       self.get("server"),
                "port":       self.get("port"),

                "user":       dbconfig["user"],
                "passwd":     dbconfig["password"],
                "database":   dbconfig["database"],
            }
            return config

        return {"msg":f"This contextsis not a database! {self.format}"}

    # def set_format(self,strval):
        # self.format =  strval

    def set_database(self, strval):
        self.database = strval