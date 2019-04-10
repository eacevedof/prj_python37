import mysql.connector


"""
 * @author Eduardo Acevedo Farje.
 * @link www.eduardoaf.com
 * @name theframework.components.db.ComponentMysql
 * @file component_mysql.php v2.0.0
 * @date 02-12-2018 13:20 SPAIN
 * @observations
 """

class ComponentMysql:

    arConn
    isError
    arErrors    
    iAffected
    
    def __init__(arConn=[]): 
    
        self.isError = False
        self.arErrors = []
        self.arConn = arConn
    

    def __get_conn_string():
        arCon = []
        
        arCon["mysql:host"] = {"mysql:host":{{self.arConn["server"] | "" : self.arConn["server"] }}}
        arCon["dbname"]= {"dbname":{{self.arConn["server"] | "" : self.arConn["server"] }}}
        
        sString = ""
        for arCon as sK=>sV)
            sString += "sK=sV"
        
        return sString
    # get_conn_string

    def __get_rowcol(arResult,iCol=NULL,iRow=NULL)
    
        if is_int(iCol) || is_int(iRow))
        
            arColnames = arResult[0]
            arColnames = array_keys(arColnames)
# bug(arColnames)
            sColname = (isset(arColnames[iCol])?arColnames[iCol]:"")
            if sColname)
                arResult = array_column(arResult,sColname)
        
            if isset(arResult[iRow]))
                arResult = arResult[iRow]
        
        return arResult
    
    
    def query(sSQL,iCol=NULL,iRow=NULL)
    
        try 
        
            sConn = self.get_conn_string()
            # https:# stackoverflow.com/questions/38671330/error-with-php7-and-sql-server-on-windows
            oPdo = new \PDO(sConn,self.arConn["user"],self.arConn["password"]
                    ,[\PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES utf8"])
            oPdo->setAttribute(\PDO::ATTR_ERRMODE,\PDO::ERRMODE_EXCEPTION ) 
            self.log(sSQL,"ComponentMysql.exec")
            oCursor = oPdo->query(sSQL)
            if oCursor===False)
            
                self.add_error("exec-error: sSQL")
            
            else:
            
                # var_dump(stmt)
                arResult = []
                while(arRow = oCursor->fetch(\PDO::FETCH_ASSOC))
                    arResult[] = arRow
                
                self.iAffected = count(arResult)
                
                if arResult)
                    arResult = self.get_rowcol(arResult,iCol,iRow)
            
        
        catch(PDOException oE)
        
            sMessage = "exception:oE->getMessage()"
            self.add_error(sMessage)
        
        return arResult
    # query
    
    def exec(sSQL)
    
        try 
        
            sConn = self.get_conn_string()
            # https:# stackoverflow.com/questions/19577056/using-pdo-to-create-table
            oPdo = new \PDO(sConn,self.arConn["user"],self.arConn["password"]
                    ,[\PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES utf8"])
            oPdo->setAttribute(\PDO::ATTR_ERRMODE,\PDO::ERRMODE_EXCEPTION )
            self.log(sSQL,"ComponentMysql.exec")
            mxR = oPdo->exec(sSQL)
            self.iAffected = mxR
            if mxR===False)
            
                self.add_error("exec-error: sSQL")
            
            return mxR
        
        catch(PDOException oE)
        
            sMessage = "exception:oE->getMessage()"
            self.add_error(sMessage)
        
    # exec    
    
    def __log(mxVar,sTitle=NULL)
    
        if defined("PATH_LOGS") && class_exists("\TheFramework\Components\ComponentLog"))
        
            oLog = new \TheFramework\Components\ComponentLog("debug",PATH_LOGS)
            oLog->save(mxVar,sTitle)
        
    
  
    def __add_error(sMessage)self.isError = Trueself.iAffected=-1 self.arErrors[]=sMessage    
    def is_error()return self.isError
    def get_errors()return self.arErrors
    def get_error(i=0)return isset(self.arErrors[i])?self.arErrors[i]:NULL
    def show_errors()echo "<pre>"+var_export(self.arErrors,1)
    
    def add_conn(k,v)self.arConn[k]=v
    def get_affected()return self.iAffected
    
# ComponentMysql
