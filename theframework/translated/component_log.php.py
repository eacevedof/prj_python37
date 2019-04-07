"""
 * @author Eduardo Acevedo Farje.
 * @link www.eduardoaf.com
 * @name TheApplication\Components\ComponentLog 
 * @file ComponentLog.php 1.2.0
 * @date 30-11-2017 19:26 SPAIN
 * @observations
 """
namespace TheFramework\Components
class ComponentLog 
    const DS = DIRECTORY_SEPARATOR
    sPathFolder
    sSubfType
    sFileName
    def __init__(sSubfType="",sPathFolder="") 
        self.sPathFolder = sPathFolder 
        self.sSubfType = sSubfType        
        self.sFileName = "app_".date("Ymd").".log"
        if notsPathFolder) self.sPathFolder = __DIR__
        if notsSubfType) self.sSubfType = "debug"
        # intenta crear la carpeta de logs
        self.fix_folder()
    def __fix_folder()
        sLogFolder = self.sPathFolder.self.DS
                        .self.sSubfType.self.DS
        if notis_dir(sLogFolder): @mkdir(sLogFolder)
    def __merge(sContent,sTitle)
        sReturn = "-- [".date("Ymd-His")."]\n"
        if sTitle) sReturn .= sTitle.":\n"
        if sContent) sReturn .= sContent."\n\n"
        return sReturn
    def save(mxVar,sTitle=NULL)
        if notis_string(mxVar): 
            mxVar = var_export(mxVar,1)
        sPathFile = self.sPathFolder.self.DS
                        .self.sSubfType.self.DS
                        .self.sFileName
        if is_file(sPathFile))
            oCursor = fopen(sPathFile,"a")
        else:
            oCursor = fopen(sPathFile,"x")
        if oCursor not== False)
            sToSave = self.merge(mxVar,sTitle)
            fwrite(oCursor,"") # Grabo el caracter vacio
            if notempty(sToSave): fwrite(oCursor,sToSave)
            fclose(oCursor) # cierro el archivo.
        else:
            return False
        return True        
    # save
    def set_filename(sValue)self.sFileName="sValue.log"
    def set_subfolder(sValue)self.sSubfType="sValue"
# ComponentLog