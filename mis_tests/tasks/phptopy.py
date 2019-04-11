"""
mis_tests\tasks\phptopy.py
Traduce en lo posible código php a python
"""
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
        self.pathfrom = self.currpath+"\\prj_mysqlhive\\backend\\vendor\\theframework\\components\\db"
        self.pathto = self.currpath+"\\prj_python37\\theframework\\translated"
        print(self.pathfrom,os.path.isdir(self.pathfrom))

    def __get_files(self):
        arFiles = [
            filename for filename in listdir(self.pathfrom) if isfile(join(self.pathfrom, filename))
        ]
        return arFiles

    def __get_content(self,filename):
        with open(filename) as f:
                return f.read()

    def __get_intopy(self,content):
        arCharsRm = ["{","}","$","private ","public ",";","<?php","?>","<?"]
        arCharsRep = [
            ("/**","\"\"\""), ("*/","\"\"\""), ("= array()","= []"), ("=array()","=[]"),
            ("include_once","import"), ("private function ","def __"), ("public function ","def "),
            ("foreach(","for "), ("elseif","elif:"), ("if(","if "), ("else","else:"), ("__construct","__init__"),
            ("this->","self."), ("self::","self."), ("//","# "),
            ("TRUE","True"), ("true","True"), ("FALSE","False"),("false","False"),("!===","!="),
            ("!==","!="),(")) ","): "),(".$","+$"),(".=","+="),(".\"","+\""),("\".","\"+"),("NULL","None")
            # ,("!","not")
        ]

        for dic in arCharsRep:
            content = content.replace(dic[0],dic[1])

        for c in arCharsRm:
            content = content.replace(c,"")

        return content

    def __get_in_lines(self,content):
        return content.split("\n")

    def __get_not_emptylines(self,content):
        arLines = self.__get_in_lines(content)
        arFiltered = filter(lambda sLine: not re.match(r'^\s*$', sLine), arLines)
        return "\n".join(arFiltered)

    def __write_file(self,filename,content):
        f = open(filename, "w")
        f.write(content)
        f.close()


    def __translate(self,arFiles):
        for filename in arFiles:
            if ".php" not in filename:
                continue
            pprint(filename)
            sFile = self.pathfrom +"\\"+ filename
            sContent = self.__get_content(sFile)
            #sContent = sContent.strip()
            # pprint(sContent)
            sContent = self.__get_intopy(sContent)
            # sContent = self.__get_not_emptylines(sContent)
            sFileNew = self.pathto + "\\"+filename+".py"
            print("sFileNew: ",sFileNew)
            self.__write_file(sFileNew,sContent)

    def run(self):
        arFiles = self.__get_files()
        self.__translate(arFiles)


if __name__ == "__main__":
    o = Phptopy()
    o.run()
