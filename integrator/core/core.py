import sys

class Core:
    REPLACES = {
        "%in%": "./data/in",
        "%contexts%": "./config/contexts",
        "%mapping%": "./config/mapping",
        "%credentials%": "./config/credentials",
    }

    
    @staticmethod
    def get_path_in(extra=None):
        path = Core.REPLACES["%in%"]
        if extra is not None:
            path = extra.replace("%in%",path)
             
        return path

    @staticmethod
    def get_path_context(extra=None):
        path = Core.REPLACES["%contexts%"]
        if extra is not None:
            path = extra.replace("%contexts%",path)
        
        return path

    @staticmethod
    def get_path_credential(extra=None):
        path = Core.REPLACES["%credentials%"]
        if extra is not None:
            path = extra.replace("%credentials%",path)
        
        return path

    @staticmethod
    def get_path_mapping(extra=None):
        path = Core.REPLACES["%mapping%"]
        if extra is not None:
            path = extra.replace("%mapping%",path)
        
        return path  

        

