import os
from datetime import datetime

class LogComponent:

    def __init__(self, subtype: str, pathfolder:str):
        self.__subtype = subtype if subtype else "debug"
        self.__pathfolder = self.__get_pathfolder(pathfolder)
        today = self.__get_today()
        self.__filename = f"app_{today}.log"
        self.__fix_folder()

    def __get_pathfolder(self, pathfolder: str):
        if pathfolder:
            return pathfolder
        pathfolder = os.path.dirname(os.path.realpath(__file__))
        return pathfolder

    def __get_today(self):
        today = datetime.today()
        return today.strftime("%Y%m%d")

    def __fix_folder(self):
        logfolder = f"{self.__pathfolder}/{self.__subtype}/"
        isdir = path.isdir(logfolder)
        if not isdir:
            path.mkdir(logfolder, "0777")

    def __var_export(self, obj, pathfile:str) :
        import os,sys,pprint
        temp = sys.stdout             # store original stdout object for later
        sys.stdout = open(pathfile, 'w')    # redirect all prints to temp file
        pprint.pprint(obj)
        sys.stdout.close()
        sys.stdout = temp             # restore print commands to interactive prompt
        return open(pathfile, 'r').read()

    def save(self, mxvar, title="":str):
        pathfile = f"{self.pathfolder}/{self.__subtype}/{self.__filename}"
        isfile = path.isfile(pathfile)
        if isfile:
            resource = open(pathfile, "a")
        else:
            resource = open(pathfile, "x")


        if not isinstance(mxvar, str):


