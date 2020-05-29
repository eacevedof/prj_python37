import sys
import os
from core.core import Core as core, get_row_by_keyval
from core.models.base import Base
from core.helpers.json import Json
from core.helpers.googleserv.sheets import Sheets

class Context(Base):

    format = ""
    database = ""

    def __init__(self, pathfile, id, format):
        pathcontext = core.get_path_context(pathfile)
        #print(f"pathcontext: {pathcontext}"); sys.exit()
        super().__init__(pathcontext, id)
        #print("contructor"); sys.exit()
        self.format = format

    def _is_file(self):
        formats = ["json","csv","xls","xml","fixed"]
        return self.format in formats

    def _is_db(self):
        return self.format == "database"

    def _is_api(self):
        return self.format == "api"

    def _is_folder(self):
        return self.format == "folder"        

    def _get_files(self,pathdir):
        dir = []
        isdir = os.path.isdir(pathdir)
        if not isdir:
            return dir 

        obj = os.scandir(pathdir) 
        for entry in obj : 
            # if entry.is_dir() or entry.is_file(): 
            if entry.is_file(): 
                #print(entry.name)
                dir.append(entry.name)
        obj.close() 
        return dir
  

    def get_content(self):
        # carga los datos del fichero o api en un array y lo devuelve
        # en el caso de carpeta deberia devolver un scandir
        if self._is_file():
            pathconf = core.get_path_in(self.get("path"))
            ojson = Json(pathconf)
            return ojson.get_loaded()
        elif self._is_api():
            # print("\nis_api():");print(self.dataid);sys.exit()
            if self.get("type") == "google-sheets":
                gsheets = Sheets(self.get("spread_id"),self.get("worksheet_num"))
                gsheets.set_credential(self.get("credentials"))
                return gsheets.get_data()
        elif self._is_folder():        
            return {
                "pathfolder": self.get("path"),
                "files": self._get_files(self.get("path"))
                }

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