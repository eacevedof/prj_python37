import io
import re
from pprint import pprint

"""
Prueba de componente estatico para debug 
"""
class ComponentDebug():

    _isSqlOn = False
    _isMessageOn = False
    _isPythonInfoOn = False
    _isIncludeOn = False

    _arMessages = []
    _arSqls = []
    _arIncluded = []

    def __init__(self):
        pass

    @classmethod
    def config(cls,isSqlOn=False,isMessageOn=False,isPythonInfoOn=False,isIncludeOn=False):
        cls._isSqlOn = isIncludeOn
        cls._isMessageOn = isIncludeOn
        cls._isPythonInfoOn = isPythonInfoOn
        cls._isIncludeOn = isIncludeOn
        cls.debug(dir(cls))


    @classmethod
    def set_sql(cls,sSQL,iCount=0,fTime=""):
        if cls._isSqlOn:
            cls._arSqls.append({"sql":sSQL,"count":iCount,"time":fTime})


    @classmethod
    def debug(cls,mxVar):
        pprint(mxVar)

if __name__ == "__main__":
    ComponentDebug.config(True,True,True,False)