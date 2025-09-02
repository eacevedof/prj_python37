import asyncio
from abc import ABC

from app.shared.infrastructure.components.date_timer import DateTimer
from app.shared.infrastructure.components.cli.cli_color import CliColor
from app.shared.infrastructure.components.logger import Logger


class AbstractCommand(ABC):
    """Abstract base class for console commands"""
    
    def __init__(self) -> None:
        self.__date_timer = DateTimer.get_instance()
        self.logger = Logger.get_instance()
        self.dt_start = ""
        self.dt_end = ""
    
    def _echo_start(self, message: str) -> None:
        """Print command start message"""
        self.dt_start = self.__date_timer.get_now_ymd_his()
        CliColor.echo_orange(f"[{self.dt_start}] start: {message}")
    
    def _echo_end(self, message: str) -> None:
        """Print command end message"""
        self.dt_end = self.__date_timer.get_now_ymd_his()
        CliColor.echo_orange(f"[{self.dt_start}] [{self.dt_end}] end: {message}")
    
    def _echo_step(self, message: str) -> None:
        """Print command step message"""
        now = self.__date_timer.get_now_ymd_his()
        CliColor.echo_green(f"[{now}]: {message}")
    
    async def _sleep_seconds(self, secs: int = 1) -> None:
        """Sleep for specified seconds"""
        await asyncio.sleep(secs)