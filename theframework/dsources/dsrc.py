"""
/theframework/dsources/dsources.py
"""
from pprint import pprint
import json
import os

class Dsrc():
    full_path = os.path.realpath(__file__)
    dir_path = os.path.dirname(full_path)
    path_file = os.path.join(dir_path,"dsources.json")

    @staticmethod
    def load_config():
        
        with open(Dsrc.path_file,"r") as f:
            distros_dict = json.load(f)
            
        pprint(distros_dict)
        return ""
    
    @staticmethod
    def get_config():
        return "text"