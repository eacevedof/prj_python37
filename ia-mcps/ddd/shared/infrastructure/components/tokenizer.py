import os
from datetime import datetime
from zoneinfo import ZoneInfo
from typing import final, Self

from nacl import pwhash


@final
class Tokenizer:
    _ANUBIS_TIMEZONE: str = "Europe/Berlin"

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def get_auth_raw_token(self) -> str | None:
        return os.getenv("API_AUTH_RAW_TOKEN")

    def get_anubis_auth_token(self) -> str:
        anubis_tz = ZoneInfo(self._ANUBIS_TIMEZONE)
        today = datetime.now(anubis_tz).strftime("%Y-%m-%d")

        # timezone-aware datetime convertido a timestamp como PHP
        today_datetime = datetime.strptime(today, "%Y-%m-%d")
        today_datetime = today_datetime.replace(tzinfo=anubis_tz)
        today_timestamp = int(today_datetime.timestamp())

        anubis_domain = os.getenv("API_ANUBIS_DOMAIN", "")
        anubis_salt_encrypt = os.getenv("API_ANUBIS_SALT", "")
        raw_token = f"{anubis_domain}{anubis_salt_encrypt}{today_timestamp}".encode("utf-8")

        auth_token = pwhash.str(
            raw_token,
            opslimit=pwhash.OPSLIMIT_INTERACTIVE,
            memlimit=pwhash.MEMLIMIT_INTERACTIVE
        ).decode("utf-8")

        return auth_token