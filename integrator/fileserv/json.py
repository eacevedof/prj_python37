import sys
import json

class Json:
    
    def __init__(self, pathfile):
        self.pathfile = pathfile
        self.data = []

    def _load_data(self):
        # print(self.pathfile)
        # sys.exit()
        with open(self.pathfile) as jfile:
            self.data = json.load(jfile)

    def get_data(self):
        self._load_data()
        return self.data



