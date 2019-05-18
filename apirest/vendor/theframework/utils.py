s("theframework.utils.py")
# utils\utils.py
import random
from datetime import datetime
from pytz import timezone
import uuid

def get_now():
    strnow = datetime.now()
    strtoday = "{}{:02d}{:02d}{:02d}{:02d}{:02d}".format(
        strnow.year, strnow.month, strnow.day, 
        strnow.hour, strnow.minute, strnow.second
    )

    return strtoday

def get_uuid():
    return str(uuid.uuid1())
    # return str(uuid.uuid4()) este se repite

def get_objdatetime(strdatetime):
    # strdatetime = "20190102153348"
    strdatetime = strdatetime.replace(" ","").replace("-","").replace(":","")
    if len(strdatetime)<14:
        strdatetime += "0000"
    objdatetimeutc = datetime.strptime(strdatetime,'%Y%m%d%H%M%S')#.strftime('%m/%d/%Y')
    
    # esta me parece bien para el listado pero no va bien para el form de modif ya que necesito un obj fecha
    # objdatetimeutc = timezone('UTC').localize(objdatetime).strftime('%Y-%m-%d %H:%M:%S') #en django: 2019-05-03 20:20:04

    # objdatetimeutc = timezone('UTC').localize(objdatetime) #mostraria en django: May 3, 2019, 8:20 p.m.
    return objdatetimeutc

def get_strdatetime(objdatetime):
    strdatetime = objdatetime.strftime('%Y%m%d%H%M%S')
    return strdatetime


def get_platform():
    """
    de base_array: 
    1 by user on db
    2 dts
    3 backoffice
    4 mobile
    """
    return str(random.randint(1,4))


def get_session_user(isint=1):
    if not isint:
        return str(random.randint(1,10))
    return random.randint(1,10)
 

def get_cruhist():
    lstactions = ["created","modified","deleted"]
    i = random.randint(0,len(lstactions)-1)
    return lstactions[i]

