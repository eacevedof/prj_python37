
"""
 * @author Eduardo Acevedo Farje.
 * @link www.eduardoaf.com
 * @name ComponentDtsExtract
 * @file component_dts_extract.php
 * @version 1.0.0
 * @date 31-03-2018 17:34
 * @observations
 * Flamagas devuelve todos los archivos .XNT que nos han pasado
 """
namespace TheFramework\Components

class ComponentDtsExtract 

    arPaths
    arFiles

    def __init__() 
    
        self.arPaths = [
            "E:/xampp/htdocs/proy_hydra_flamagas/dts/update_20170620_pricing",
            "E:/xampp/htdocs/proy_hydra_flamagas/dts/update_20170705_tablas_enblanco",
            "E:/xampp/htdocs/proy_hydra_flamagas/dts/update_20170706_campo_en_knb1",
            "e:/xampp/htdocs/proy_hydra_flamagas/dts/Datos/IN/BackUP"
        ]
        
        self.arFiles = []
    
    
    def __in_string(arChars=[],sString)
    
        for arChars as c)
            if strstr(sString,c))
                return True
        return False
    
    
    def __clean(arSubstrings=[],&sString)
    
        sReplace = sString
        for arSubstrings as str)
            sReplace = str_replace (str,"",sReplace)
        sString = sReplace
    
    
    def __get_files()
    
        for self.arPaths as sPath)
        
            if is_dir(sPath))
            
                arFiles = scandir(sPath)
                sPath = explode("/",sPath)
                sPath = end(sPath)
                for arFiles as sFileName)
                
                    if self.in_string([".XNT"],sFileName))
                    
                        self.clean([".XNT"],sFileName)
                        if strlen(sFileName)>(14+3))
                            sFileName = substr(sFileName,14)
                        self.arFiles[sPath][] = sFileName
                    
                
                if isset(self.arFiles[sPath]))
                    asort(self.arFiles[sPath])
            
        
        return self.arFiles
    
    
    def run()
    
        arFiles = self.get_files()
        pr(arFiles)
    

    def add_path(value)
    
# ComponentDtsExtract