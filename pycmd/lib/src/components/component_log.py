# component_log.py
import os.path
from time import gmtime, strftime

from .component_file import fwrite

def lg(mxvalue,strtitle=""):
    pathdir = os.path.dirname(os.path.abspath(__file__))
    pathdir = os.path.realpath(pathdir+"/../../../logs")
    print(pathdir)
    strtoday = strftime("%Y%m%d", gmtime())
    strnow = "- "+strftime("%Y-%m-%d %H:%M:%S", gmtime())+":"

    strcontent = "\n"+strnow
    if(strtitle):
        strcontent += "\n" + strtitle

    strcontent += "\n"
    
    if(not isinstance(mxvalue, str)):
        strcontent += repr(mxvalue)
    else:
        strcontent += mxvalue

    logname = "pycmd_"+strtoday +".log"
    pathfile = os.path.realpath(pathdir +"/"+ logname)
    
    fwrite(pathfile,strcontent)
#lg
    




