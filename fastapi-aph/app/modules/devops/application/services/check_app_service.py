import os
import platform
import psutil
from datetime import datetime
from typing import Dict, Any, final

@final
class CheckAppService:
    def __init__(self):
        pass
    
    @classmethod
    def get_instance(cls):
        return cls()
    
    async def invoke(self) -> Dict[str, Any]:
        return {
            "app_info": self.__get_app_info(),
            "system_info": self.__get_system_info(),
            "environment": self.__get_environment_info(),
            "timestamp": datetime.now().isoformat()
        }
    
    def __get_app_info(self) -> Dict[str, Any]:
        return {
            "name": os.getenv("APP_NAME", "FastAPI APH"),
            "version": os.getenv("APP_VERSION", "1.0.0"),
            "environment": os.getenv("APP_ENV", "development"),
            "debug": os.getenv("APP_DEBUG", "False").lower() == "true"
        }
    
    def __get_system_info(self) -> Dict[str, Any]:
        try:
            memory = psutil.virtual_memory()
            disk = psutil.disk_usage('/')
            
            return {
                "platform": platform.platform(),
                "python_version": platform.python_version(),
                "architecture": platform.architecture()[0],
                "processor": platform.processor() or "Unknown",
                "memory": {
                    "total": memory.total,
                    "available": memory.available,
                    "percent": memory.percent
                },
                "disk": {
                    "total": disk.total,
                    "free": disk.free,
                    "percent": (disk.used / disk.total) * 100
                }
            }
        except Exception as e:
            return {
                "platform": platform.platform(),
                "python_version": platform.python_version(),
                "error": str(e)
            }
    
    def __get_environment_info(self) -> Dict[str, Any]:
        return {
            "database_url": bool(os.getenv("DATABASE_URL")),
            "redis_url": bool(os.getenv("REDIS_URL")),
            "smtp_configured": all([
                os.getenv("SMTP_HOST"),
                os.getenv("SMTP_PORT"),
                os.getenv("SMTP_USERNAME")
            ])
        }