
"""
 * @author Eduardo Acevedo Farje.
 * @link www.eduardoaf.com
 * @name ComponentHydrapk
 * @file component_scandir.php
 * @version 1.0.1
 * @date 27-07-2017 12:06
 * @observations
 * Extrae los 
 *  alter table accounts_agrupation2_tr add constraint acut_guain_r2416_PK primary key (Language_tr,Code,Code_Agrupation1)
 * con el fin de pasarlos a drop para despues poder vaciar las tablas con truncate 
 * https:# stackoverflow.com/questions/2337717/removing-all-primary-keys
 * Al final no ha servido pq al aplicar los drop no se ejecutan bien las consultas
 """
namespace TheFramework\Components

class ComponentHydrapk 

    sRegexp
    sFilePath
    arLines
    
    def __init__() 
    
        self.sRegexp = "alter table .*"
        self.sFilePath = "C:\shared\constraints.sql"
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
            
                iPos1 = strpos(sLine,"alter table")
                iPos1 += 11
                iPos2 = strpos(sLine,"add constraint")
                iPos2 = iPos2-iPos1
                sLine = substr(sLine,iPos1,iPos2)
                self.arLines[i] = trim(sLine)
            
        # foreach        
        # array_unique(self.arLines)
    
    
    def run()
    
        self.load_lines()
        self.arLines = array_unique(self.arLines)
        asort(self.arLines)
        sSQLIn = implode("','",self.arLines)
        echo "'sSQLIn'"
   
    # run()
    
    def set_path_file(value)self.sFilePath=value
    def set_regex(value)self.sRegexp=value
    
    def get_extracted()return self.arLines
    
# ComponentHydrapk