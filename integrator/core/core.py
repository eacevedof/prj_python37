import sys

def is_instring(search,string):
    return string.find(search) != -1

def get_replace(tag,repl,string):
    if(strstr(tag,strstr)):
        return string.replace(tag,repl)

def get_path(extra,path,tag):
    newpath = path
    if is_instring(tag, extra):
        # print(f"is_string {tag}, {extra}")
        newpath = extra.replace(tag, path)
    else:
        newpath = path +"/"+ extra
    return newpath

def get_row_by_keyval(rows,key,val):
    # print(f"k:{key}, v:{val}");print(rows); sys.exit()
    for row in rows:
        for k in row:
            # print(k); print(row[k]);
            if(k==key and row[k] == val):
                return row
    return None

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

    @staticmethod
    def get_dbconfig(dicctx, strdatabase):
        # print(dicctx); sys.exit()
        dbconfig = get_row_by_keyval(dicctx["schemas"],"database",strdatabase)
        # print(dbconfig); sys.exit()
        config = {
            "host":       dicctx["server"],
            "port":       dicctx["port"],

            "user":       dbconfig["user"],
            "passwd":     dbconfig["password"],
            "database":   strdatabase
        }
        return config

