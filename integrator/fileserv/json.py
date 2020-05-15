import json

class Json:

    pathfile = ""
    data = None
    
    def __init__(self, pathfile):
        self.pathfile = pathfile
        self.data = []

    def _load_data(self):
        with open(self.pathfile) as jfile:
            self.data = json.load(jfile)

    def get_data(self):
        _load_data()
        return self.data


