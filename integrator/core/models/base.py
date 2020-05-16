import sys
from pprint import pprint
from core.helpers.json import Json
from core.core import get_row_by_keyval

class Base:
    
    pathfile = ""
    id = ""
    
    data = []
    dataid = []

    def __init__(self, pathfile, id=""):
        self.pathfile = pathfile
        self.id = id

        self._load_data()
        self._load_byid()
        self.data = []

    def _id_exists(self):
        return self.id != ""

    def _load_data(self):
        #print(f"base. _load_data"); sys.exit()
        json = Json(self.pathfile)
        self.data = json.get_loaded()
        # pprint(self.data); sys.exit()

    def _load_byid(self):
        if self._id_exists():
            self.dataid = get_row_by_keyval(self.data, "id", self.id)
        #pprint(self.dataid); sys.exit()

    def get_data(self):
        if self._id_exists():
            return self.dataid
        return self.data

    def get(self,key=""):
        if self._id_exists():
            if key in self.dataid:
                return self.dataid[key]
            return None
        else:
            if key in self.data:
                return self.data[key]
            return None