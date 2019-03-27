import io
import re

class ComponentDebug():

    _isSqlOn = False
    _isMessageOn = False
    _isPythonInfoOn = False
    _isIncludeOn = False

    def __init__(self):
        pass

    @staticmethod
    def config(isSqlOn=False,isMessageOn=False,isPythonInfoOn=False,isIncludeOn=False):
        _isSqlOn = isIncludeOn
        _isMessageOn = isIncludeOn
        _isPythonInfoOn = isPythonInfoOn
        _isIncludeOn = isIncludeOn

    