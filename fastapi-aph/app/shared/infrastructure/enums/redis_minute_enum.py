from enum import IntEnum
from typing import final

@final
class RedisMinuteEnum(IntEnum):
    TEN_MINUTES = 10
    ONE_HOUR = 60
    EIGHT_HOURS = 480
    ONE_DAY = 1440
    ONE_WEEK = 10080