from datetime import datetime, date, timedelta


def get_yyyy_mm_dd() -> str:
    return datetime.today().strftime('%Y-%m-%d')


def get_ymd_plus(days: int = 1) -> str:
    end_date = date.today() + timedelta(days=days)
    return end_date.strftime("%Y-%m-%d")
