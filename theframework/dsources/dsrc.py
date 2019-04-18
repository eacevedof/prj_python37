"""
/theframework/dsources/dsources.py
"""
from pprint import pprint
import json
import os

class dsrc():
    full_path = os.path.realpath(__file__)
    dir_path = os.path.dirname(full_path)
    path_json = os.path.join(dir_path,"dsources.json")
    data = {}

    @staticmethod
    def load_config():
        if not dsrc.data:
            with open(dsrc.path_json,"r") as f:
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
            dsrc.data = o_dict
    
    @staticmethod
    def get_config():
        dsrc.load_config()
        return dsrc.data
    
    @staticmethod
    def get_context(id):
        dsrc.load_config()
        o_dic = dsrc.data
        if id in o_dic:
            return o_dic[id]
        return {}
    
    @staticmethod
    def get_value(id,val):
        dsrc.load_config()
        o_dic = dsrc.data
        if id in o_dic:
            if val in o_dic[id]:
                return o_dic[id][val]
        return {}
        