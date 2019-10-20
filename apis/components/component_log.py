# component_log.py
import os.path
from time import gmtime, strftime
from .component_file import fwrite

global pathdirlogs

pathdirlogs = os.path.dirname(os.path.abspath(__file__))
pathdirlogs = os.path.realpath(pathdirlogs+"/../../../logs")

def lg(mxvalue,strtitle="",strtype="debug"):
    global pathdirlogs

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
    pathfile = os.path.realpath(pathdirlogs +"/"+strtype+"/"+logname)
    print(pathfile)
    fwrite(pathfile, strcontent)
#lg
    
def lgd(mxvalue,strtitle="",print=0):
    if(print):
        sc(strtitle,"2;37;42")
        sc(mxvalue,"2;37;42")
    lg(mxvalue, strtitle, strtype="debug")
#lgd

def lgerr(mxvalue,strtitle="",print=0):
    if(print):
        sc(strtitle,"7;33;41")
        sc(mxvalue,"7;33;41")
    lg(mxvalue, strtitle, strtype="errors")
#lgerr

def lgsql(mxvalue,strtitle="",print=0):
    if(print):
        sc(strtitle,"5;37;46")
        sc(mxvalue,"5;37;46")    
    lg(mxvalue, strtitle, strtype="sql")
#lgsql

