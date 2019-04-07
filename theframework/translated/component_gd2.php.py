"""
 * @author Eduardo Acevedo Farje.
 * @link www.eduardoaf.com
 * @name ComponentGd2
 * @file component_gd2.php
 * @version 1.1.0
 * @date 31-03-2018 17:41
 * @observations
 """
namespace TheFramework\Components
class ComponentGd2 
    arFrom
    arTo
    isError
    arErrors
    # GLOBALS["config_app_dir"].GLOBALS["config_web_folder"].config_bar.GLOBALS["config_res_dir"].config_bar."products_picture".config_bar.Nom_Photo
    def __init__() 
        if notdefined("DS"))define("DS",defined("config_bar")?config_bar:DIRECTORY_SEPARATOR)  
        self.define_resdir()
        self.isError = False
        self.arErrors = array()
        self.arFrom = array("pathfolder"=>PATH_RESDIR.DS."products_picture".DS,"filename"=>"")
        self.arTmp = array()
        self.arTo = array("pathfolder"=>PATH_RESDIR.DS."products_picture".DS,"filename"=>"")
    def __define_resdir()
        if notdefined("PATH_RESDIR"))
            define("PATH_RESDIR",realpath(GLOBALS["config_app_dir"].GLOBALS["config_web_folder"].DS.GLOBALS["config_res_dir"]))        
    def __get_type(sFilename)return end(explode(".",trim(sFilename)))
    def __get_image_obj(sExtension,sPathFile)
        switch(sExtension) 
            case "png": oImage = imagecreatefrompng(sPathFile) break
            case "gif": oImage = imagecreatefromgif sPathFile) break
            case "bmp": oImage = imagecreatefromwbmp(sPathFile) break
            default:
                oImage = imagecreatefromjpeg(sPathFile)
        # switch(extension)
        return oImage
    # get_image_obj
    def __get_image_blank_obj(iW,iH)
        oImage = imagecreateTruecolor(iW,iH)
        return oImage
    # get_image_blank_obj
    """
     * a partir de dos objetos, uno en blanco (lienzo) y otro original (arFrom[object]) se copia el original en el blanco
     * @param array arFrom array("object","x","y","w","h")
     * @param array arTo array("object","x","y","w","h")
     * @return boolean
     """
    def __save_in_blank(arFrom,arTo)
        # imagecopyresampled(dst_image, src_image, int dst_x, int dst_y, int src_x, int src_y, int dst_w, int dst_h, int src_w, int src_h): bool 
        # imagecopyresampled(dst_image, src_image, dst_x, dst_y, src_x, src_y, dst_w, dst_h, src_w, src_h)
        # imagecopyresampled(tnImage,fullImage, 0,isy, 0,0, ix,iy, fullSize[0],fullSize[1])
        return imagecopyresampled(arTo["object"],arFrom["object"]
            ,arTo["x"],arTo["y"],arFrom["x"],arFrom["y"]
            ,arTo["w"],arTo["h"], arFrom["w"],arFrom["h"])
    # save_in_blank
    def get_size(sPathFile)
        # getimagesize("https:# www.virginexperiencedays.co.uk/content/img/product/large/big-cat-encounter--17120907.jpg")
        /*array(7) [0]=>int(1200) [1]=> int(800) [2]=> int(2) [3]=> string(25) "width="1200" height="800"" ["bits"]=> int(8)
        ["channels"]=>int(3) ["mime"]=> string(10) "image/jpeg""""
        arSize = getimagesize(sPathFile)
        return array("w"=>arSize[0],"h"=>arSize[1])
    # get_size
    """
     * w: El ancho en el que se desea transformar la imagen original
     * h: La altura que tendrá la imagen original. 
     * Son excluyentes, en caso de pasar los dos valores se tomara unicamente w
     * @param array arTo array("w","h")
     """
    def resize(arTo)
        iW = isset(arTo["w"])?arTo["w"]:NULL
        iH = isset(arTo["h"])?arTo["h"]:NULL
        self.arFrom["pathfile"] = self.arFrom["pathfolder"].DS.self.arFrom["filename"]
        self.arTo["pathfile"] = self.arFrom["pathfolder"].DS.self.arFrom["filename"]
        sPathFileFrom = self.arFrom["pathfile"]
        if notsPathFileFrom) self.add_error ("Ruta de origen no proporcionada")
        if notself.arTo["pathfile"]) self.add_error ("Ruta de destino no proporcionada")
        if notis_file(sPathFileFrom): self.add_error("Archivo no encontrado en sPathFileFrom")
        if (iW || iH) && notself.isError)
            sExt = self.get_type(self.arFrom["filename"])
            oImgFrom = self.get_image_obj(sExt,sPathFileFrom)
            arSize = self.get_size(sPathFileFrom)
            if iW)
                iH = floor(arSize["h"]/arSize["w"]*iW)                
            else:if iH)
                iW = floor(arSize["h"]/arSize["w"]*iH)
            oImgBlank = self.get_image_blank_obj(iW,iH)
            arFrom = array("object"=>oImgFrom,"x"=>0,"y"=>0,"w"=>arSize["w"],"h"=>arSize["h"])
            arTo = array("object"=>oImgBlank,"x"=>0,"y"=>0,"w"=>iW,"h"=>iH)
            # se guarda en el lienzo en blanco
            isPrinted = self.save_in_blank(arFrom,arTo)
            if isPrinted)
                imagejpeg(arTo["object"],self.arTo["pathfile"])
                imagedestroy(oImgFrom)
                imagedestroy(oImgBlank)
            else:
                self.add_error("Ocurrio un error al guardar en blanco: arFrom:".var_export(arFrom,1)." arTo:".var_export(arTo,1))
        else:
            self.add_error("No hay datos de destino:".var_export(arTo,1))
    # resize
    def __add_error(sMessage)self.isError = Trueself.arErrors[]=sMessage
    def add_from(sKey,sValue)self.arFrom[sKey] = sValue
    def add_to(sKey,sValue)self.arTo[sKey] = sValue
    def is_error()return self.isError
    def get_errors()return self.arErrors
    def show_errors()echo "<pre>".var_export(self.arErrors,1)
# class ComponentGd2