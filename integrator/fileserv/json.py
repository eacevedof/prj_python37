import sys
import json

class Json:
    
    def __init__(self, pathfile=""):
        self.pathfile = pathfile
        self.data = []

    def load_data(self):
        # print(self.pathfile)
        # sys.exit()
        with open(self.pathfile) as jfile:
            self.data = json.load(jfile)

    def get_loaded(self):
        self.load_data()
        return self.data

    def set_pathfile(self,pathfile):
        self.pathfile = pathfile

    def get_dictbykey(self,k,v):
        for objdict in self.data:
            for key in objdict:
                if(key == k and objdict[key]==v):
                    return objdict
        return None

    def get_data(self):
        return self.data

