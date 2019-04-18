"""
/theframework/dsources/dsources.py
"""
from pprint import pprint
import json
import os

class Dsrc():
    full_path = os.path.realpath(__file__)
    dir_path = os.path.dirname(full_path)
    path_json = os.path.join(dir_path,"dsources.json")

    @staticmethod
    def load_config():
        
        with open(Dsrc.path_json,"r") as f:
            distros_dict = json.load(f)
            
        
        #print(type(distros_dict))
        # pprint(distros_dict)
        
        # y = json.dumps(distros_dict)
        # print(dir(y))
        # pprint(y)
        return ""
    
    @staticmethod
    def get_config():
        return "text"