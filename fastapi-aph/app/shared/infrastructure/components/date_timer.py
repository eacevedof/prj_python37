import re
from datetime import datetime, timezone
from typing import Optional, Union

class DateTimer:
    @classmethod
    def get_instance(cls) -> 'DateTimer':
        return cls()
    
    def get_timezone(self) -> str:
        """Get current timezone"""
        return str(datetime.now().astimezone().tzinfo)
    
    def get_now_ymd_his(self) -> str:
        """Get current datetime in YYYY-MM-DD HH:MM:SS format"""
        now = datetime.now()
        return now.strftime("%Y-%m-%d %H:%M:%S")
    
    def get_now_as_timestamp(self) -> int:
        """Get current timestamp in milliseconds"""
        return int(datetime.now().timestamp() * 1000)
    
    def get_today(self) -> str:
        """Get current date in YYYY-MM-DD format"""
        now = datetime.now()
        return now.strftime("%Y-%m-%d")
    
    def is_valid_date_ymd(self, date_string: str) -> bool:
        """Check if date string is valid YYYY-MM-DD format and valid date"""
        if not self.is_valid_date_ymd_format(date_string):
            return False
        
        try:
            year, month, day = map(int, date_string.split("-"))
            date_obj = datetime(year, month, day)
            
            return (
                date_obj.year == year and
                date_obj.month == month and
                date_obj.day == day
            )
        except (ValueError, IndexError):
            return False
    
    def is_valid_date_ymd_format(self, date_string: str) -> bool:
        """Check if string matches YYYY-MM-DD format"""
        pattern = re.compile(r'^\d{4}-\d{2}-\d{2}$')
        return bool(pattern.match(date_string))
    
    def get_date_ymd_his_as_string(self, date_time: Optional[Union[datetime, str]]) -> str:
        """Convert datetime to YYYY-MM-DD HH:MM:SS string"""
        if not date_time:
            return ""
        
        if isinstance(date_time, str):
            try:
                parsed_date = datetime.fromisoformat(date_time.replace('Z', '+00:00'))
                date_time = parsed_date
            except ValueError:
                try:
                    # Try parsing as standard format
                    parsed_date = datetime.strptime(date_time, "%Y-%m-%d %H:%M:%S")
                    date_time = parsed_date
                except ValueError:
                    return ""
        
        if not isinstance(date_time, datetime):
            return ""
        
        return date_time.strftime("%Y-%m-%d %H:%M:%S")