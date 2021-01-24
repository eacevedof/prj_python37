import os
import socket
from datetime import datetime

class LogComponent:

    def __init__(self, subtype: str="", pathfolder:str=""):
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

    def __get_now(self):
        now = datetime.today()
        return now.strftime("%Y-%m-%d %H:%M:%S")

    def __fix_folder(self):
        logfolder = f"{self.__pathfolder}/{self.__subtype}/"
        print(logfolder)
        isdir = os.path.isdir(logfolder)
        if not isdir:
            os.mkdir(logfolder, 0o777)

    def __var_export(self, obj, resource) :
        import sys,pprint
        temp = sys.stdout             # store original stdout object for later
        sys.stdout = open(pathfile, 'w')    # redirect all prints to temp file
        pprint.pprint(obj)
        sys.stdout.close()
        sys.stdout = temp             # restore print commands to interactive prompt
        return open(pathfile, 'r').read()

    def __get_resource(self):
        pathfile = f"{self.__pathfolder}/{self.__subtype}/{self.__filename}"
        isfile = os.path.isfile(pathfile)
        if isfile:
            resource = open(pathfile, "a")
        else:
            resource = open(pathfile, "w")
        return resource

    def __get_remote_ip(self):
        hostname = socket.gethostname()
        return socket.gethostbyname(hostname)

    def save(self, mxvar, title:str=""):
        logresouce = self.__get_resource()
        if not logresouce:
            return False

        if logresouce.mode == "a":
            logresouce.write("\n\n")

        headline = f"-- [{self.__get_now()} - ip:{self.__get_remote_ip()}]\n"
        logresouce.write(headline)
        if title:
            logresouce.write(f"{title}:\n")

        if not isinstance(mxvar, str):
            __var_export(mxvar, resource)
        else:
            logresouce.write(mxvar)
        logresouce.close()

        return True
