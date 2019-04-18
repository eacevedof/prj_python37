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
    data = {}

    @staticmethod
    def load_config():
        
        with open(Dsrc.path_json,"r") as f:
            # lista de diccionarios
            o_list = json.load(f)
          
        o_dict = {}
        for i in range(len(o_list)):
            id = o_list[i]["id"]
            o_dict[id] = o_list[i]
            
        #pprint(o_dict)
        # from inspect import getmembers
        #from pprint import pprint
        # pprint(getmembers(o_list))
    
        # print(type(o_list),dir(o_list))
        # pprint(distros_dict)
        
        # y = json.dumps(distros_dict)
        # print(dir(y))
        # pprint(y)
        Dsrc.data = o_dict
    
    @staticmethod
    def get_config():
        Dsrc.load_config()
        return Dsrc.data