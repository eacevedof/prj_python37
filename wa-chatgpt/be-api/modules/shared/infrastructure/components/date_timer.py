import re
from typing import final
from datetime import datetime
import pytz
from dataclasses import dataclass


@final
@dataclass(frozen=True)
class DateTimer:

    @staticmethod
    def get_instance():
        return DateTimer()

    def is_valid_date_ymd_format(self, date_string: str) -> bool:
        regex = r"^\d{4}-\d{2}-\d{2}$"
        return bool(re.match(regex, date_string))

    def get_now_ymd_his(self) -> str:
        now = datetime.now(pytz.UTC)
        return now.strftime("%Y-%m-%d %H:%M:%S")

    def is_valid_date_ymd(self, date_string: str) -> bool:
        if not self.is_valid_date_ymd_format(date_string):
            return False

        year, month, day = map(int, date_string.split("-"))
        try:
            date = datetime(year, month, day)
        except ValueError:
            return False

        return date.year == year and date.month == month and date.day == day

    def get_date_ymd_as_ts(self, date_string: str) -> int:
        year, month, day = map(int, date_string.split("-"))
        date = datetime(year, month, day)
        return int(date.timestamp())

    def get_current_date_ymd(self) -> str:
        current_date = datetime.now(pytz.UTC)
        return current_date.strftime("%Y-%m-%d")

    def get_datetime_to_ymd_his(self, obj_dt: datetime) -> str:
        return obj_dt.strftime("%Y-%m-%d %H:%M:%S")
