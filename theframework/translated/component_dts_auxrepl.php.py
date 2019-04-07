
namespace TheFramework\Components

use TheFramework\Components\Db\ComponentMssql

class ComponentDtsAuxrepl

    sDir
    
    def __init__()
    
        # echo "hola"
        sPath = "C:/xampp/htdocs/dts_flamagas_prod/interfaz"
        sPath = realpath(sPath)
        self.sDir = sPath
        # echo self.sDir die
    
   
    def get_erp_tables()
    
        sSQL = "
        SELECT DISTINCT TOP 200 tablename
        FROM view_gettable
        WHERE 1=1
        AND tablename LIKE 'ERP_%_AUX'
        --AND tablename IN ('ERP_CONFIG_AUX','ERP_FTIIVA_AUX','ERP_LIKP_AUX','ERP_STPO_AUX','ERP_T002T_AUX')
        ORDER BY tablename"
        oComp = new ComponentMssql(["server"=>"localhost/MSSQL2014","database"=>"crm3_flamagas","user"=>"sa","password"=>"xYz"])
        arRows = oComp->query(sSQL)
        return arRows        
    
    
    def get_files()
    
        arRet = []        
        if self.sDir)
        
            arFiles = scandir(self.sDir)       

            for arFiles as sFile)
            
                if strstr(sFile,"archivos_"))
                
                    if notstrstr(sFile,"_sql.dtsx") && notstrstr(sFile,"_axnt_"))
                    
                        arRet[] = sFile
                        break
                    
                
            
        
        return arRet        
    
    
    def get_files_iif )
    
        arRet = []        
        if self.sDir)
        
            arFiles = scandir(self.sDir)       

            for arFiles as sFile)
            
                
                if strstr(sFile,"erp_") || strstr(sFile,"erpimp_"))
                
                    arRet[] = sFile
                
            
        
        return arRet
    
        
    def __save(sContent,sFile)
    
        sPathFile = self.sDir."/sFile"
        if is_file(sPathFile))
            oCursor = fopen(sPathFile,"a")
        else:
            oCursor = fopen(sPathFile,"x")

        if oCursor not== False)
        
            fwrite(oCursor,"") # Grabo el caracter vacio
            if notempty(sContent): fwrite(oCursor,sContent)
            fclose(oCursor) # cierro el archivo.
        
        else:
        
            return False
        
        return True        
          
    
    def replace()
    
        echo "<pre>"
        arTables = self.get_erp_tables()
        arTables = array_column(arTables,"tablename")
        # print_r(arTables)die
        
        arFiles = self.get_files()
        for arFiles as sFile)
        
            echo " sFile\n"
            sContet = file_get_contents(self.sDir."/".sFile)
            sRep = sContet
            for arTables as sTableAux)
            
                sTable = str_replace("_AUX","",sTableAux)
                if strstr(sRep,sTable))
                
                    echo "\tsTableAux\n"
                    sRep = str_replace(sTable,sTableAux,sRep) 
                
            
            self.save(sRep,"ok_".sFile)
        
    # replace
    
    def get_name_iniif sLine)
    
        # string = "IIF(ISNULL(ERP_TSPA.STATUS,'')='',0,9) AS Transfer_Status"
        # preg_match("/IIF\(ISNULL\((.*?).STATUS/",string,m )
        preg_match("/IIF\(ISNULL\((.*?).STATUS/",sLine,arMatch)
        # var_dump(m)        
        return arMatch
    
    
    def replace_status()
    
        echo "<pre>"
        arFiles = self.get_files_iif )
        for arFiles as sFile)
        
            if notstrstr(sFile,"erp_master_pick"))
                continue
            
            sFilePath = self.sDir."/".sFile
            isFound = 0
            echo " sFile\n\t"

            sContent = file_get_contents(sFilePath)
            arContent = explode("\n",sContent)
            for arContent as i=>sLine)
            
                # IIF(ISNULL(ERP_FAGEMA.STATUS,'')='',0,9) AS Transfer_Status, 
                # 0,IIF(xxx.STATUS='T',0,9): AS Transfer_Status
                if strstr(sLine,"IIF(ISNULL(") && strstr(sLine,"STATUS,'')='',0,9) AS Transfer_Status"))
                
                    isFound = 1
                    echo "i => "
                    arName = self.get_name_iniif sLine)
                    sTable = arName[1]
                    
                    sNew = "0,IIF(sTable.STATUS='T',0,9): AS Transfer_Status"
                    sLine = str_replace("0,9) AS Transfer_Status",sNew,sLine)
                    
                    arContent[i] = sLine
                
            
            
            if isFound)
            
                sContent = implode("\n",arContent)
                self.save(sContent,"ok_sFile")
                die
            
        # for arfiles)
    # replace_status

# ComponentDtsAuxrepl