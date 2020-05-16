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
        json = Json(self.pathfile)
        self.data = json.get_loaded()

    def _load_byid(self):
        if self._id_exists():
            self.dataid = get_row_by_keyval(self.data, "id", self.id)

    def get_data(self):
        if self._id_exists():
            return dataid
        return data

    def get(self,key=""):
        if self._id_exists():
            if key=="":
                return dataid
            return dataid[key]
        else:
            if key=="":
                return data
            return data[key]