import io
import sys
from pprint import pprint
import re
import os
from os import listdir
from os.path import isfile, join

class Phptopy:

    def __init__(self):
        currpath = os.path.dirname(os.path.abspath(__file__))
        self.currpath = os.path.dirname(os.path.abspath(currpath+"/../../../"))
        self.pathfrom = self.currpath+"\\prj_mysqlhive\\backend\\vendor\\theframework"
        self.pathto = self.currpath+"\\prj_python37\\theframework"
        print(self.pathfrom,os.path.isdir(self.pathfrom))


    def __get_files(self):
        arFiles = [
            f
            for f in listdir(self.mypath) if isfile(join(self.mypath, f))
        ]
        return arFiles

    def __get_content(self,filename):
        with open(filename) as f:
                return f.read()

    def __get_intopy(self,content):
        arCharsRm = ["{","}","$","private ","public ",";"]
        arCharsRep = [
            ("/**","\"\"\""),
            ("*/","\"\"\""),
            ("private function ","def __"),
            ("public function ","def "),
            ("foreach ","for "),
            ("if(","if "),
            ("else","else:"),
            ("__construct","__init__"),
            ("this->","self."),
            ("self::","self."),
            ("!","not"),
            ("//","# "),
            ("TRUE","True"),
            ("true","True"),
            ("FALSE","False"),
            ("false","False"),
            ("!===","!="),
            ("!==","!="),
            (")) ","): ")
        ]

        for dic in arCharsRep:
            content = content.replace(dic[0],dic[1])

        for c in arCharsRm:
            content = content.replace(c,"")

        return content

    def __write_file(self,filename,content):
        sFile = filename,

    def __rename_files(self,arFiles):
        for filename in arFiles:
            sFile = self.pathfrom +"\\"+ filename
            sContent = self.__get_content(sFile)
            sContent = self.__get_intopy(sContent)
            sFileNew = self.pathto + "\\"+filename+".py"
            self.__write_file(sFileNew,sContent)




    def run(self):
        pass


if __name__ == "__main__":
    o = Phptopy()
    o.run()
