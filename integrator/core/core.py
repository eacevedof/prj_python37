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

def get_schema(schemas,key,val):
    # print(f"k:{key}, v:{val}");print(schemas); sys.exit()
    for schema in schemas:
        for k in schema:
            # print(k); print(schema[k]);
            if(k==key and schema[k] == val):
                return schema
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

    def get_dbconfig(dicctx, strdatabase):
        # print(dicctx); sys.exit()
        dbconfig = get_schema(dicctx["schemas"],"database",strdatabase)
        print(dbconfig); sys.exit()
        config = {
            "host":       dicctx["server"],
            "port":       dicctx["port"],

            "user":       dbconfig["user"],
            "passwd":     dbconfig["password"],
            "database":   strdatabase
        }
        return config

