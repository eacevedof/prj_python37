import os
from datetime import datetime

class ComponentLog():
    """
    theframework/components/component_log.py
    """
    DS = os.sep
    DIR = os.getcwd()

    strnow = datetime.now().strftime("%Y%m%d")
    pathfolder = ""
    strsubtype = ""
    strfilename = ""

    def __init__(self, strsubtype = "", pathfolder = ""):
        self.pathfolder = pathfolder
        self.strsubtype = strsubtype
        self.strfilename = "app_"+self.strnow+".log"

        if not pathfolder:
            self.pathfolder = self.DIR

        if not strsubtype:
            self.strsubtype = "debug"

        self.__fix_folder()
    
    
    def __get_now(self):
        strnow = datetime.now().strftime("%Y%m%d-%H%i%s")
        return strnow
    

    def __fix_folder(self):
        sLogFolder = self.pathfolder+self.DS+self.strsubtype+self.DS
        if not os.path.isdir(sLogFolder):
            os.mkdir(sLogFolder)


    def write(self):

        sFile = self.pathfolder+self.DS+self.strfilename
        print(sFile)
        f = open(sFile, "a")
        f.write("Now the file has more content!")
        f.close()


if __name__ == "__main__":
    o = ComponentLog()
    o.write()