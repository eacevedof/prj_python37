"""
* @author Eduardo Acevedo Farje.
* @link www.eduardoaf.com
* @version 1.3.0
* @name ComponentDebug 
* @file component_debug.php
* @date 25-11-2018 16:14 (SPAIN)
* @observations: Para poder escribir en archivos se debe tener permisos de escritura y/o
* lectura para IUSR_<SERVERNAME>
*  load:24
* @requires: functions_utils.php v1.0.10
"""
namespace TheFramework\Components
class ComponentDebug
    static _isSqlsOn = False
    static _isMessagesOn = False
    static _isPhpInfoOn = False
    static _isIncludedOn = False
    static arMessages = array()
    static arSqls = array()
    static arIncluded = array()
    static function config(isSqlsOn=False, isMessagesOn=False, isPhpInfoOn=False, isIncludedOn=False)
        self._isSqlsOn = isSqlsOn
        self._isMessagesOn = isMessagesOn
        self._isPhpInfoOn = isPhpInfoOn
        self._isIncludedOn = isIncludedOn
    static function set_sql(sSQL,iCount=00,fTime="")
        if self._isSqlsOn)
            self.arSqls[] = array("sql"=>sSQL,"count"=>iCount,"time"=>fTime)
    static function set_message(sMessage,sTitle="")
        if self._isMessagesOn)
            self.arMessages[] = array("Title"=>sTitle,"Message"=>sMessage)
    static function get_php_info()if self._isPhpInfoOn)return phpinfo()
    static function get_messages_in_array()if self._isMessagesOn) return self.arMessages
    static function get_messages_in_html_table()if self._isMessagesOn && notself.is_ajax_request(): echo self.build_html_table(self.arMessages)
    static function get_sqls_in_array()if self._isSqlsOn) return self.arSqls
    static function get_sqls_in_html_table()
        if self._isSqlsOn) 
            sLog = self.build_string(self.arSqls)
            self.log(sLog)            
            if notself.is_ajax_request())
                echo self.build_html_table(self.arSqls)
    # get_sqls_in_html_table
    static function set_messages_on(isMessagesOn)self._isMessagesOn = isMessagesOn
    static function set_sqls_on(isSqlsOn)self._isSqlsOn = isSqlsOn
    static function set_php_info_on(isPhpInfoOn)self._isPhpInfoOn = isPhpInfoOn
    static function is_php_info_on()return self._isPhpInfoOn
    static function is_sqls_on()return self._isSqlsOn
    static function is_messages_on()return self._isMessagesOn
    static function is_ajax_request()
        # https:# stackoverflow.com/questions/2579254/does-serverhttp-x-requested-with-exist-in-php-or-not
        header = isset(_SERVER["HTTP_X_REQUESTED_WITH"]) ? _SERVER["HTTP_X_REQUESTED_WITH"] : null
        return (header === "XMLHttpRequest")
    static function build_html_tr_header(arArray=array())
        sHtmlTrHd = ""
        if notempty(arArray))
            sHtmlTrHd .="<tr><th>Nº</th>\n"
            arRow = arArray[0]
            foreach(arRow as sTitle=>sValue)
                sHtmlTrHd .= "<th>sTitle</th>\n"
            sHtmlTrHd .= "</tr>\n"
        return sHtmlTrHd
    static function get_style_td_background(iRow,asError=0)
        if notasError)
            if (iRow%2)==0)
                return "clsTrEven"
            else: 
                return "clsTrUneven"
        return "clsTrError"
    static function build_style()
        sSytle = "<style type=\"text/css\">"
        sSytle .= "table#tblDebug
            font-size:14pxnotimportant 
            width:1000px
            border-collapse: collapsenotimportant
            margin-bottom: 0
            overflow:auto
            font-weight:normal 
            font-family: 'Courier New', Courier, monospace notimportant
        table#tblDebug tr td 
            border: 1px solid black
            padding-bottom: 0
        table#tblDebug tr td pre
            line-height:normalnotimportant
            padding:0
            margin:0
            border:0
        table#tblDebug tr th
            border:1px solid black
            background-color: #F29A02
            color:black
        .clsTrEven
            background-color: #e9eaeb
            color: black
        .clsTrUneven
            background-color: #ECF71D
            color: black
        .clsTrError
            background-color: #F92104
            color: white
        .clsTrList
            background-color: #00CE41/*verde"""
            color: white
        .clsTrHighlight
            background-color: #55A9FC/*celeste"""
            color: white
        .clsTrSession
            background-color: #554455/*not used"""
            color: white
        "
        sSytle .= "</style>"
        return sSytle
    static function build_html_table(arArray=array())
        if isset(_SESSION["componentdebug"]) && is_array(_SESSION["componentdebug"]))
            # bug(_SESSION["componentdebug"])
            arArray = array_merge(_SESSION["componentdebug"],arArray)
            _SESSION["componentdebug"] = NULL
        if isset(_POST["componentdebug"]) && is_array(_POST["componentdebug"]))
            arArray = array_merge(_POST["componentdebug"],arArray)
            _POST["componentdebug"] = NULL
        sHtmlTable = ""
        if notempty(arArray))
            sHtmlTable .= self.build_style()
            sHtmlTable .= "<table id=\"tblDebug\">\n"
            sHtmlTable .= self.build_html_tr_header(arArray)
            foreach(arArray as iRow=>arRow)
                isError=0
                # bug(arRow)
                if isset(arRow["count"]) && arRow["count"]=="-1")
                    isError=1
                    arRow["count"]="ERROR"
                sTdStyle = self.get_style_td_background(iRow,isError)
                sHtmlTable .= "<tr>\n"
                sHtmlTable .= "<td class=\"sTdStyle\" >iRow</td>\n"
                foreach(arRow as sFieldValue)
                    # si se aplican tags de html se mejora la visibilidad de las consultas y se puede copiar y pegar
                    # respetando los saltos de linea ya que los br los pasa el portapapeles o el navegador a salto de linea simple \n
                    # el problema es que si se quiera recuperar la consulta del html generado los tags fastidian la consulta.
                    sFieldValue = str_replace("SELECT ","<b>SELECT </b>",sFieldValue) 
                    sFieldValue = str_replace(" AS ","<b> AS </b>",sFieldValue)
                    sFieldValue = str_replace("FROM","<br/><b>FROM</b>",sFieldValue)
                    sFieldValue = str_replace("WHERE ","<br/><b>WHERE </b>",sFieldValue)
                    sFieldValue = str_replace("INNER JOIN","<br/><b>INNER JOIN </b>",sFieldValue)
                    sFieldValue = str_replace("LEFT JOIN","<br/><b>LEFT JOIN </b>",sFieldValue)
                    sFieldValue = str_replace(" AND ","<br/><b> AND </b>",sFieldValue)
                    sFieldValue = str_replace(" OR ","<br/><b> OR </b>",sFieldValue)
                    sFieldValue = str_replace(" IN ","<b> IN </b>",sFieldValue)
                    sFieldValue = str_replace(" ON ","<b> ON </b>",sFieldValue)
                    sFieldValue = str_replace(" NULL","<b> NULL</b>",sFieldValue)
                    sFieldValue = str_replace("ORDER BY ","<br/><b>ORDER BY </b>",sFieldValue)
                    sFieldValue = str_replace("GROUP BY ","<br/><b>GROUP BY </b>",sFieldValue)
                    sFieldValue = str_replace("INSERT INTO ","<b>INSERT INTO </b>",sFieldValue)
                    sFieldValue = str_replace("VALUES","<br/><b>VALUES </b>",sFieldValue)
                    if strstr(sFieldValue,"UPDATE "))
                        sFieldValue = str_replace("UPDATE ","<b>UPDATE </b>",sFieldValue)
                        sFieldValue = str_replace(",","<br/>,",sFieldValue)
                        sFieldValue = str_replace("SET ","<br/><b>SET </b>",sFieldValue)
                    sFieldValue = str_replace("DELETE FROM ","<b>DELETE FROM </b>",sFieldValue)
                    if notisError)
                        arSubstrings = array("get_select_","load_by","autoinsert","autoupdate","autoquarantine","autodelete")
                        if isone_substring(arSubstrings,sFieldValue): 
                            sTdStyle = "clsTrList"
                        if strstr(sFieldValue,"%highlight%"))
                            sTdStyle = "clsTrHighlight"    
                    sHtmlTable .= "<td class=\"sTdStyle\">sFieldValue</td>\n"
                sHtmlTable .= "</tr>\n"
            sHtmlTable .= "</table>\n"
        return sHtmlTable
    # build_html_table
    static function build_string(arArray=array())
        if isset(_SESSION["componentdebug"]) && is_array(_SESSION["componentdebug"]))
            # bug(_SESSION["componentdebug"])
            arArray = array_merge(_SESSION["componentdebug"],arArray)
            _SESSION["componentdebug"] = NULL
        if isset(_POST["componentdebug"]) && is_array(_POST["componentdebug"]))
            arArray = array_merge(_POST["componentdebug"],arArray)
            _POST["componentdebug"] = NULL
        sLog = ""
        if notempty(arArray))
            foreach(arArray as iRow=>arRow)
                foreach(arRow as sFieldValue)
                    sFieldValue = str_replace("\n\t\t\t","\n",sFieldValue)
                    sFieldValue = str_replace("\n\t\t","\n",sFieldValue)
                    sFieldValue = str_replace("\n\t","\n",sFieldValue)
                    sFieldValue = str_replace("\n     ","\n",sFieldValue)
                    sFieldValue = str_replace("\n    ","\n",sFieldValue)
                    sFieldValue = str_replace("\n   ","\n",sFieldValue)
                    sFieldValue = str_replace("\n  ","\n",sFieldValue)
                    sFieldValue = str_replace("\n ","\n",sFieldValue)
                    # sFieldValue = str_replace("\t"," ",sFieldValue)
                    sLog .= "\n\n-- iRow =>\n".trim(sFieldValue)
                # for arRow
            # for arArray
        return sLog
    # build_string
    static function log(mxVar,sTitle="")
        sPathFolder = realpath(_SERVER["DOCUMENT_ROOT"]).DIRECTORY_SEPARATOR
        sFileName = "componentdebug_".date("Ymd").".log"
        sPathFile = sPathFolder.sFileName
        # pr(sPathFile)die
        sValue = mxVar
        if notis_string(sValue): sValue = var_export(mxVar,1)
        if sTitle) sValue = "- [sTitle] -\nsValue"
        file_put_contents(sPathFile,sValue)
    # log
# ComponentDebug