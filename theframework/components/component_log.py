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
        sLogFolder = self.sPathFolder+self.DS+self.sSubfType+self.DS
        if not os.path.isdir(sLogFolder):
            os.mkdir(sLogFolder)

    def __merge(sContent,sTitle)
        sNow = datetime.now().strftime("%Y%m%d-%H%i%s")
        sReturn = "-- ["+sNow+"]\n"
        if sTitle: 
            sReturn += sTitle + ":\n"
        if sContent:
            sReturn += sContent + "\n\n"
        return sReturn

    def save(mxVar,sTitle=None)
    
        if not isinstance(mxVar, str):
            mxVar = var_export(mxVar,1)
        
        sPathFile = self.sPathFolder.self::DS
                        .self.sSubfType.self::DS
                        .self.sFileName
        
        if(is_file(sPathFile))
            oCursor = fopen(sPathFile,"a")
        else:
            oCursor = fopen(sPathFile,"x")
        if(oCursor !== False)
            sToSave = self.merge(mxVar,sTitle)
            fwrite(oCursor,"") //Grabo el caracter vacio
            if(!empty(sToSave)) fwrite(oCursor,sToSave)
            fclose(oCursor) //cierro el archivo.
        else:
            return False
        return True
    
    def set_filename(sValue){self.sFileName="sValue.log"}
    def set_subfolder(sValue){self.sSubfType="sValue"}


    def write(self):

        sFile = self.sPathFolder+self.DS+self.sFileName
        print(sFile)
        f = open(sFile, "a")
        f.write("Now the file has more content!")
        f.close()


if __name__ == "__main__":
    o = ComponentLog()
    o.write()