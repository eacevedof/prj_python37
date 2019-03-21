"""functions_debug.py

"""
from pprint import pprint

def pr(var="",sTitle=None):
    if sTitle:
        sTitle = " {}: ".format(sTitle)

    sTagPre = "<pre function=\"pr\" style=\"border:1px solid black;background:yellow; padding:0px; color:black; font-size:12px;\">\n";
    sTagFinPre = "</pre>\n";
    print(sTagPre)
    print(sTitle)
    pprint(var)
    print(sTagFinPre)


import datetime

def date(unixtime, format = '%m/%d/%Y %H:%M'):
    d = datetime.datetime.fromtimestamp(unixtime)
    return d.strftime(format)

def lg(var,sTitle=None,sType="custom"):
    sLogdate = date("Ymd")
    sNow = date("Y-m-d_H:i:s")
    if sTitle:
        sTitle = "<< {} >>".format(sTitle)
        sTitle = "\n"+sNow+": "+sTitle
        print(sTitle)

    pprint(var)        