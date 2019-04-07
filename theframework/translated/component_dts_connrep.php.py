
"""
 * @author Eduardo Acevedo Farje.
 * @link www.eduardoaf.com
 * @name ComponentDtsConnrep
 * @file component_dts_connrep.php
 * @version 1.0.1
 * @date 01-06-2014 12:45
 * @observations
 * usado en flamagas para extraer de los archivos .dtsx (xml)
 * devuelve las tablas que ya se han tratado 
 """
namespace TheFramework\Components

class ComponentDtsConnrep 

    sRegexp
    sFilePath
    arLines
    
    def __init__() 
    
        self.sRegexp = "<DTS:Property DTS:Name=\"ObjectName\">.*<\/DTS:Property>"
        self.sFilePath = "C:\Proyectos\Interfaz\Flamagas\Interfaz Flamagas\ImportFlamagas.dtsx"
        self.arLines = []
        # echo "<DTS:Property DTS:Name=\"ObjectName\">FATRVA - ERP_auxiliar</DTS:Property>"
    
    
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
    
    
    def __load_lines()
    
        sContent = file_get_contents(self.sFilePath)
        arContent = explode("\n",sContent)
        for arContent as i=>sLine)
        
            arMatches = []
            preg_match("/self.sRegexp/",sLine,arMatches)
            if arMatches)
            
                # bug(arMatches,"line:i")
                if notself.in_string(["","",".log","sql.desa1","Restricción"],sLine))
                
                    self.clean(["<DTS:Property DTS:Name=\"ObjectName\">","</DTS:Property>"],sLine)
                    self.arLines[i] = trim(sLine) 
                
            
        # foreach        
    
    
    def run(isPrintL=1)
    
        self.load_lines()
        self.arLines = array_unique(self.arLines)
        asort(self.arLines)
        if isPrintL)
            print_r(self.arLines)
        sSQLIn = implode("','",self.arLines)
        sSQLIn = "('sSQLIn')"
        sSQLIn = "
        SELECT DISTINCT tabla,a_erptabla
        FROM ERP_Taules_Telynet
        WHERE 1=1
        AND tabla IN sSQLIn
        "
        print_r(sSQLIn)     
    # run()
    
    def set_path_file(value)self.sFilePath=value
    def set_regex(value)self.sRegexp=value
    
    def get_extracted()return self.arLines
    
# ComponentDtsConnrep