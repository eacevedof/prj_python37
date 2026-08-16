from datetime import datetime
from typing import final, Self


@final
class DateTimer:

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def get_datetime_as_ymd(self, str_datetime: str) -> str:
        if not str_datetime:
            return ""
        try:
            date = datetime.fromisoformat(str_datetime.replace("Z", "+00:00"))
            return date.strftime("%Y-%m-%d")
        except ValueError:
            return ""

    def get_datetime_as_ymd_hms(self, str_datetime: str) -> str:
        if not str_datetime:
            return ""
        try:
            date = datetime.fromisoformat(str_datetime.replace("Z", "+00:00"))
            return date.strftime("%Y-%m-%d %H:%M:%S")
        except ValueError:
            return ""

    def get_current_date_ymd(self) -> str:
        return datetime.now().strftime("%Y-%m-%d")

    def get_current_datetime_ymd_hms(self) -> str:
        return datetime.now().strftime("%Y-%m-%d %H:%M:%S")

    def get_timestamp(self) -> int:
        return int(datetime.now().timestamp())
