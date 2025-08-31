import asyncio
from abc import ABC

from app.shared.infrastructure.components.date_timer import DateTimer
from app.shared.infrastructure.components.cli.cli_color import CliColor
from app.shared.infrastructure.components.logger import Logger


class AbstractCommand(ABC):
    """Abstract base class for console commands"""
    
    def __init__(self):
        self._date_timer = DateTimer.get_instance()
        self.logger = Logger.get_instance()
        self.dt_start = ""
        self.dt_end = ""
    
    def echo_start(self, message: str) -> None:
        """Print command start message"""
        self.dt_start = self._date_timer.get_now_ymd_his()
        CliColor.echo_orange(f"[{self.dt_start}] start: {message}")
    
    def echo_end(self, message: str) -> None:
        """Print command end message"""
        self.dt_end = self._date_timer.get_now_ymd_his()
        CliColor.echo_orange(f"[{self.dt_start}] [{self.dt_end}] end: {message}")
    
    def echo_step(self, message: str) -> None:
        """Print command step message"""
        now = self._date_timer.get_now_ymd_his()
        CliColor.echo_green(f"[{now}]: {message}")
    
    async def sleep_seconds(self, secs: int = 1) -> None:
        """Sleep for specified seconds"""
        await asyncio.sleep(secs)