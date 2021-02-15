import os

# https://github.com/eacevedof/prj_phpapify/blob/master/backend/vendor/theframework/components/session/component_encdecrypt.php

class EncdecryptComponent:

    def __init__(self, usesalt: bool=True, pathfolder:str=""):
        self.__sSslMethod = "AES-256-CBC"
        self.__sSslKey = "@11111111@"
        self.__sSslIv = "99326425"
        self.__useSalt = usesalt
        self.__sSalt = "@#$.salt.$#@"

