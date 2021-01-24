from datetime import datetime

def get_today():
    today = datetime.today()
    return today.strftime("%Y%m%d")