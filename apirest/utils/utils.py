# utils\utils.py
from datetime import datetime
import uuid

def get_now():
    strnow = datetime.now()
    strtoday = "{}{}{}{}{}{}".format(strnow.day,strnow.month,strnow.year,strnow.hour,strnow.minute,strnow.second)
    return strtoday

def get_uuid():
    return str(uuid.uuid4())