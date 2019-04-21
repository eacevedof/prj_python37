from datetime import datetime

def get_now():
    strnow = datetime.now()
    strtoday = "{}{}{}{}{}{}".format(strnow.day,strnow.month,strnow.year,strnow.hour,strnow.minute,strnow.second)
    return strtoday