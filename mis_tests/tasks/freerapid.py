import io
import sys
from pprint import pprint
import re
import os
from os import listdir
from os.path import isfile, join

class FreeRapid:

    def __init__(self):
        self.mypath = "E:\\shared\\videos\\"


    def __get_files(self):

        arFiles = [
            f
            for f in listdir(self.mypath) if isfile(join(self.mypath, f))
        ]
        return arFiles

    def __rename_files(self,arFiles):

        for f in arFiles:
            sFile = self.mypath + f
            sFileNew = f.lower()
            #print(sFileNew)
            rgx = re.compile('vídeo(.+?)\.mp4')
            #rgx = re.compile('[\d]+\.mp4')
            sNumber = rgx.search(sFileNew)
            sNumber = sNumber.group(1).strip()
            sNumber = sNumber.zfill(3)
            sFileNew = sNumber +"-"+ sFileNew.replace(" vídeo ","").replace(" ","-").replace(".-","-")
            sFileNew = self.mypath+sFileNew
            # print(sIni["match"])
            #pprint(sIni.group(1))
            #print(sFileNew," ",sNumber)
            os.rename(sFile,sFileNew)


    def run(self):
        arFiles = self.__get_files()
        self.__rename_files(arFiles)
        # pprint(arFiles)



if __name__ == "__main__":
    o = FreeRapid()
    o.run()
