from datetime import datetime


def get_yyyy_mm_dd() -> str:
    return datetime.today().strftime('%Y-%m-%d')
