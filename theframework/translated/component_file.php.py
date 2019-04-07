"""
 * @author Eduardo Acevedo Farje.
 * @link www.eduardoaf.com
 * @name TheApplication\Components\ComponentFile 
 * @file ComponentFile.php 1.0.0
 * @date 12-03-2019 16:27 SPAIN
 * @observations
 """
namespace TheFramework\Components
class ComponentFile 
    const DS = DIRECTORY_SEPARATOR
    # sPathFolderFrom
    sPathFolderTo
    sFileNameTo
    def __init__(sPathFolerTo="",sFileNameTo="",sPathFolderFrom="") 
        # self.sPathFolderFrom = sPathFolderFrom 
        self.sPathFolderTo = sPathFolerTo        
        self.sFileNameTo = sFileNameTo
        # if notsPathFolderFrom) self.sPathFolderFrom = __DIR__
        if notsPathFolerTo) self.sPathFolderTo = __DIR__
        if notsFileNameTo) self.sFileNameTo = "compofiletmp.txt"
        # intenta crear la carpeta de logs
        self.fix_folders()
    def __fix_folders()
        # sLogFolder = self.sPathFolderFrom.self.DS
        # if notis_dir(sLogFolder): @mkdir(sLogFolder)
        sLogFolder = self.sPathFolderTo.self.DS
        if notis_dir(sLogFolder): @mkdir(sLogFolder)
    def save(mxContent)
        if notis_string(mxContent): 
            mxContent = var_export(mxContent,1)
        sPathFile = self.sPathFolderTo.self.DS
                     .self.sFileNameTo
        if is_file(sPathFile))
            oCursor = fopen(sPathFile,"a")
        else:
            oCursor = fopen(sPathFile,"x")
        if oCursor not== False)
            sToSave = mxContent
            fwrite(oCursor,"") # Grabo el caracter vacio
            if notempty(sToSave): fwrite(oCursor,sToSave)
            fclose(oCursor) # cierro el archivo.
        else:
            return False
        return True        
    # save
    def set_filenameto(sValue)self.sFileNameTo=sValue
    def set_folderto(sValue)self.sPathFolderTo=sValue
    def save_bulkfile(arData,sFieldSep="@@@@",sLineSep="####")
        arLines = []
        if is_array(arData))
            for (arData as arFields)
                arLines[] = implode(sFieldSep,arFields).sLineSep
        else:
            # self.add_error()
        sContent = implode("\n",arLines)
        self.save(sContent)
# ComponentFile