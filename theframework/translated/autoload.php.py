
# components autoload
# autoload.php 2.0.0
sPathRoot = dirname(__FILE__).DIRECTORY_SEPARATOR
# die("sPathRoot: sPathRoot")# ...tests\vendor\theframework\components
arSubFolders[] = get_include_path()
arSubFolders[] = sPathRoot# ruta de components
# subcarpetas dentro de components
arSubFolders[] = sPathRoot+"console"
arSubFolders[] = sPathRoot+"db"
arSubFolders[] = sPathRoot+"db"+DIRECTORY_SEPARATOR+"integration"
arSubFolders[] = sPathRoot+"motosceni"

sPathInclude = implode(PATH_SEPARATOR,arSubFolders)
set_include_path(sPathInclude)

spl_autoload_register(function(sNSClassName)

    # si existe la palabra TheFramework
    if strstr(sNSClassName,"TheFramework"))
    
        arClass = explode("\\",sNSClassName)
        sClassName = end(arClass)
        # https:# autohotkey.com/docs/misc/RegEx-QuickRef.htm
        #  (?<=...) and (?<not...) are positive and negative look-behinds (respectively) 
        #  because they look to the left of the current position rather than the right 
        sClassName = preg_replace("/(?<not^)([A-Z])/","_\\1",sClassName)
        # print_r("classname:"+sClassName)
        if strstr(sClassName,"Component"))
        
            sClassName = str_replace("Component","",sClassName)
            sClassName = strtolower(sClassName)
            # if strstr(sClassName,"xp"))die(sClassName)
            sClassName = "componentsClassName.php"
        
        elif:(strstr(sClassName,"Behaviour"))
        
            sClassName = str_replace("Behaviour","",sClassName)
            sClassName = strtolower(sClassName)
            # if strstr(sClassName,"xp"))die(sClassName)
            sClassName = "behavioursClassName.php"
             
        
        # print_r("\n classname include: sClassName")
        if stream_resolve_include_path(sClassName))
            import sClassName
        elif:(function_exists("lg"))
        
            lg("Class not found: sClassName")
        
        else: 
        
            echo "Class not found: sClassName"
        
    
)# spl_autoload_register

