
"""
 * @author Eduardo Acevedo Farje.
 * @link www.eduardoaf.com
 * @name ComponentHydralogs
 * @file component_hydralogs.php
 * @version 1.0.1
 * @date 30-01-2018 11:24
 * @observations
 * Genera un archivo log work_total con todos los archivos de trabajo de admin y developer
 """
namespace TheFramework\Components

class ComponentHydralogs 

    arErros
    isError
    
    sRegexp
    sPathLogs
    arLines
    
    def __init__() 
    
        self.sRegexp = "\[([0-9]+\-[0-9]+\-[0-9]+ [0-9]+:[0-9]+:[0-9]+)\] \[ok\] "
        self.sPathLogs = realpath("C:\\shared\\flamagas_logs")
        self.arLines = []
    
    
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
    
    
    def __get_only_work(arLogs)
    
        arWorkLogs = array_filter(arLogs,function(sFileName)return strstr(sFileName,"work_"))
        return arWorkLogs
    
    
    def __get_over_date(arLogs,sDate)
    
        arWorkLogs = array_filter(arLogs,function (sFileName) use (sDate) 
            arTmp = explode(".",sFileName)
            arTmp = arTmp[0]
            arTmp = explode("_",arTmp)
            sFileDate = end(arTmp)
            return (sFileDate>=sDate)
        )
        return arWorkLogs
    
    
    def __get_by_users(arLogs,arUsers)
    
        arWorkLogs = array_filter(arLogs, function(sFileName) use (arUsers) 
            arTmp = explode(".",sFileName)
            arTmp = arTmp[0]
            arTmp = explode("_",arTmp)
            sUser = arTmp[3]
            return (in_array(sUser,arUsers))
        )
        return arWorkLogs
    
    
    def __get_date(sFileName)
    
        arTmp = explode(".",sFileName)
        arTmp = arTmp[0]
        arTmp = explode("_",arTmp)
        sFileDate = end(arTmp)
        return sFileDate
    
    
    def __get_sorted_by_date(arLogs)
    
         isOk = usort(arLogs, function(sFileA,sFileB)
            sDateA = (int)self.get_date(sFileA)
            sDateB = (int)self.get_date(sFileB)
            return (sDateA>sDateB)
        )
        return arLogs
    
    
    def __get_worklogs()
    
        arLogs = scandir(self.sPathLogs)
        # unset(arLogs[0]) unset(arLogs[1])# . y ..
        arLogs = self.get_only_work(arLogs)
        arLogs = self.get_over_date(arLogs,"20180115")
        arLogs = self.get_by_users(arLogs,["2","x0"])
        arLogs = self.get_sorted_by_date(arLogs)
        # self.debug(arLogs)
        # die
        return arLogs
    # get_worklogs
    
    def __load_lines(sPathLog)
    
        sContent = file_get_contents(sPathLog)
        arContent = explode("\n",sContent)
        for arContent as i=>sLine)
        
            arMatches = []
            preg_match("/self.sRegexp/",sLine,arMatches)
            if arMatches)
            
                self.arLines[i] = trim(sLine)
            
        # foreach        
        # array_unique(self.arLines)
    
    
    def run()
    
        if is_dir(self.sPathLogs))
        
            arRm = scandir(self.sPathLogs)
            unset(arRm[0]) unset(arRm[1])

            arLogs = self.get_worklogs()
            for arRm as sFileName)
            
                if notin_array(sFileName,arLogs))
                
                    iR = unlink(self.sPathLogs.DIRECTORY_SEPARATOR.sFileName)
                    self.debug("borrado sFileName,r:iR")
                
                # self.load_lines(self.sPathLogs.DIRECTORY_SEPARATOR.sFileName)            
            
        
        else:
            self.add_error("sPathLogs:self.sPathLogs no es un dir")
    # run()
    
    def debug(mxVar)echo "<pre>".var_export(mxVar,1)    
    def __add_error(sMessage)self.isError = Trueself.arErrors[]=sMessage
    
    def set_path_file(value)self.sPathLogs=value
    def set_regex(value)self.sRegexp=value
    
    def get_extracted()return self.arLines
    
    def is_error()return self.isError
    def get_errors()return self.arErrors
    def show_errors()echo "<pre>".var_export(self.arErrors,1)    
# ComponentHydralogs