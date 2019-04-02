"""
theframework/components/component_log.py
"""
import os
from datetime import datetime

class ComponentLog():

    DS = os.sep
    DIR = os.getcwd()

    sNow = datetime.now().strftime("%Y%m%d")
    sPathFolder = ""
    sSubfType = ""
    sFileName = ""

    def __init__(self, sSubfType = "", sPathFolder = ""):
        self.sPathFolder = sPathFolder
        self.sSubfType = sSubfType
        self.sFileName = "app_"+self.sNow+".log"

        if not sPathFolder:
            self.sPathFolder = self.DIR

        if not sSubfType:
            self.sSubfType = "debug"

        self.fix_folder()
    

    def fix_folder(self):
        pass

    def write(self):

        sFile = self.sPathFolder+self.DS+self.sFileName
        print(sFile)
        f = open(sFile, "a")
        f.write("Now the file has more content!")
        f.close()


if __name__ == "__main__":
    o = ComponentLog()
    o.write()