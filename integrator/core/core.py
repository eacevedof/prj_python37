import sys

def is_instring(search,string):
    return string.find(search) != -1

def get_replace(tag,repl,string):
    if(strstr(tag,strstr)):
        return string.replace(tag,repl)

def get_path(extra,path,tag):
    newpath = path
    if is_instring(tag, extra):
        print(f"is_string {tag}, {extra}")
        newpath = extra.replace(tag, path)
    else:
        newpath = path +"/"+ extra
    return newpath

class Core:
    REPLACES = {
        "%in%": "./data/in",
        "%contexts%": "./config/contexts",
        "%mapping%": "./config/mapping",
        "%credentials%": "./config/credentials",
    }
    
    @staticmethod
    def get_path_in(extra=None):
        tag = "%in%"
        path = Core.REPLACES[tag]
        if extra is not None:
            path = get_path(extra, path, tag)
        return path

    @staticmethod
    def get_path_context(extra=None):
        tag = "%contexts%"
        path = Core.REPLACES[tag]
        if extra is not None:
            path = get_path(extra, path, tag)
        return path

    @staticmethod
    def get_path_credential(extra=None):
        tag = "%credentials%"
        path = Core.REPLACES[tag]
        if extra is not None:
            path = get_path(extra, path, tag)
        return path

    @staticmethod
    def get_path_mapping(extra=None):
        tag = "%mapping%"
        path = Core.REPLACES[tag]
        if extra is not None:
            path = get_path(extra, path, tag)
        return path

        

