import os

class EncdecryptComponent:

    def __init__(self, subtype: str="", pathfolder:str=""):
        self.__subtype = subtype if subtype else "debug"
        self.__pathfolder = self.__get_pathfolder(pathfolder)
        today = self.__get_today()
        self.__filename = f"app_{today}.log"
        self.__fix_folder()
