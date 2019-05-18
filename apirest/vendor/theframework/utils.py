s("theframework.utils.py")
# utils\utils.py
import random
from datetime import datetime
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

