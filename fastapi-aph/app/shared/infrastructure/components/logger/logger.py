import os
import json
import asyncio
from datetime import datetime
from pathlib import Path
from typing import Any, Optional, Dict, Union, final

from app.shared.infrastructure.components.cli.cli_color import CliColor
from app.shared.infrastructure.components.logger.log_extension_enum import LogExtensionEnum
from app.modules.elastic.domain.enums.log_level_enum import LogLevelEnum
from app.shared.infrastructure.components.logger.logger_meta_type import LoggerMetaType
from app.modules.elastic.infrastructure.repositories.elastic_writer_api_repository import ElasticWriterApiRepository


async def file_put_contents(path_file: str, str_data: str) -> None:
    """Write content to file with error handling"""
    try:
        # Ensure directory exists
        path_obj = Path(path_file)
        path_obj.parent.mkdir(parents=True, exist_ok=True)
        
        # Append to file
        with open(path_file, 'a') as f:
            f.write(str_data)
    except Exception as error:
        print(f"file_put_contents: error writing to file: {path_file}", error)


@final
class Logger:
    """Logger with Elasticsearch integration following original Deno implementation"""
    
    _instance: Optional['Logger'] = None
    _meta_data: Optional[LoggerMetaType] = None
    
    def __init__(self):
        pass
    
    @classmethod
    def get_instance(cls, meta_data: Optional[LoggerMetaType] = None) -> 'Logger':
        if cls._instance:
            return cls._instance
        
        cls._meta_data = meta_data
        cls._instance = cls()
        return cls._instance
    
    def log_debug(self, mixed: Any, title: str = "") -> None:
        """Log debug message to file and Elasticsearch"""
        if self.__is_test_mode():
            print(CliColor.get_color_green(f"[logger-test-mode] DEBUG {title}:"), mixed)
            return
        
        content_arr = [f"request_ip: {self._meta_data['request_ip'] if self._meta_data else ''}"]
        
        if title:
            content_arr.append(title)
        
        content_arr.append(
            mixed if isinstance(mixed, str) else self.__get_as_json(mixed)
        )
        
        content = "\n".join(content_arr)
        content = f"[DEBUG] {content}"
        
        # Log to file (async but don't wait)
        asyncio.create_task(self.__log_in_file(content, LogLevelEnum.DEBUG))
        
        # Log to Elasticsearch (async but don't wait)
        elastic_repo = ElasticWriterApiRepository.get_instance({
            "request_ip": self._meta_data["request_ip"] if self._meta_data else "",
            "request_uri": self._meta_data["request_uri"] if self._meta_data else "",
        })
        asyncio.create_task(self.__safe_elastic_log(elastic_repo.log_debug(content)))
    
    def log_sql(self, sql: str, title: str = "") -> None:
        """Log SQL query to file and Elasticsearch"""
        if self.__is_test_mode():
            print(CliColor.get_color_blue(f"[logger-test-mode] SQL {title}:"), sql)
            return
        
        content_arr = [f"request_ip: {self._meta_data['request_ip'] if self._meta_data else ''}"]
        
        if title:
            content_arr.append(title)
        
        content_arr.append(sql)
        content = "\n".join(content_arr)
        content = f"[SQL] {content}"
        
        # Log to file (async but don't wait)
        asyncio.create_task(self.__log_in_file(content, LogLevelEnum.SQL))
        
        # Log to Elasticsearch (async but don't wait)
        elastic_repo = ElasticWriterApiRepository.get_instance({
            "request_ip": self._meta_data["request_ip"] if self._meta_data else "",
            "request_uri": self._meta_data["request_uri"] if self._meta_data else "",
        })
        asyncio.create_task(self.__safe_elastic_log(elastic_repo.log_sql(content)))
    
    def log_error(self, mixed: Any, title: str = "") -> None:
        """Log error message to file and Elasticsearch"""
        if self.__is_test_mode():
            print(CliColor.get_color_red(f"[logger-test-mode] ERROR {title}:"), mixed)
            return
        
        content_arr = [f"request_ip: {self._meta_data['request_ip'] if self._meta_data else ''}"]
        
        if title:
            content_arr.append(title)
        
        content_arr.append(
            mixed if isinstance(mixed, str) else self.__get_as_json(mixed)
        )
        
        content = "\n".join(content_arr)
        content = f"[ERROR] {content}"
        
        # Log to file (async but don't wait)
        asyncio.create_task(self.__log_in_file(content, LogLevelEnum.ERROR))
        
        # Log to Elasticsearch (async but don't wait)
        elastic_repo = ElasticWriterApiRepository.get_instance({
            "request_ip": self._meta_data["request_ip"] if self._meta_data else "",
            "request_uri": self._meta_data["request_uri"] if self._meta_data else "",
        })
        asyncio.create_task(self.__safe_elastic_log(elastic_repo.log_error(content)))
    
    def log_security(self, mixed: Any, title: str = "") -> None:
        """Log security event to file and Elasticsearch"""
        if self.__is_test_mode():
            print(CliColor.get_color_yellow(f"[logger-test-mode] SECURITY {title}:"), mixed)
            return
        
        content_arr = [f"request_ip: {self._meta_data['request_ip'] if self._meta_data else ''}"]
        
        if title:
            content_arr.append(title)
        
        content_arr.append(
            mixed if isinstance(mixed, str) else self.__get_as_json(mixed)
        )
        
        content = "\n".join(content_arr)
        content = f"[SECURITY] {content}"
        
        # Log to file (async but don't wait) 
        asyncio.create_task(self.__log_in_file(content, LogLevelEnum.SECURITY))
        
        # Log to Elasticsearch (async but don't wait)
        elastic_repo = ElasticWriterApiRepository.get_instance({
            "request_ip": self._meta_data["request_ip"] if self._meta_data else "",
            "request_uri": self._meta_data["request_uri"] if self._meta_data else "",
        })
        asyncio.create_task(self.__safe_elastic_log(elastic_repo.log_security(content)))
    
    def log_warning(self, mixed: Any, title: str = "") -> None:
        """Log warning message to file and Elasticsearch"""
        if self.__is_test_mode():
            print(CliColor.get_color_orange(f"[logger-test-mode] WARNING {title}:"), mixed)
            return
        
        content_arr = [f"request_ip: {self._meta_data['request_ip'] if self._meta_data else ''}"]
        
        if title:
            content_arr.append(title)
        
        content_arr.append(
            mixed if isinstance(mixed, str) else self.__get_as_json(mixed)
        )
        
        content = "\n".join(content_arr)
        content = f"[WARNING] {content}"
        
        # Log to file (async but don't wait)
        asyncio.create_task(self.__log_in_file(content, LogLevelEnum.WARNING))
        
        # Log to Elasticsearch (async but don't wait)
        elastic_repo = ElasticWriterApiRepository.get_instance({
            "request_ip": self._meta_data["request_ip"] if self._meta_data else "",
            "request_uri": self._meta_data["request_uri"] if self._meta_data else "",
        })
        asyncio.create_task(self.__safe_elastic_log(elastic_repo.log_warning(content)))
    
    def log_exception(self, throwable: Any, title: str = "ERROR") -> None:
        """Log exception to file and Elasticsearch"""
        if self.__is_test_mode():
            print(CliColor.get_color_red(f"[logger-test-mode] {title}:"), throwable)
            return
        
        content_arr = [f"request_ip: {self._meta_data['request_ip'] if self._meta_data else ''}"]
        
        if title:
            content_arr.append(title)
        
        if isinstance(throwable, str):
            content_arr.append(throwable)
        else:
            content_arr.append(self.__get_as_json(throwable))
        
        content = "\n".join(content_arr)
        content = f"[ERROR] {content}"
        
        # Log to file (async but don't wait)
        asyncio.create_task(self.__log_in_file(content, LogLevelEnum.ERROR))
        
        # Log to Elasticsearch (async but don't wait)
        elastic_repo = ElasticWriterApiRepository.get_instance({
            "request_ip": self._meta_data["request_ip"] if self._meta_data else "",
            "request_uri": self._meta_data["request_uri"] if self._meta_data else "",
        })
        asyncio.create_task(self.__safe_elastic_log(elastic_repo.log_error(content)))
    
    def __is_test_mode(self) -> bool:
        """Check if running in test mode"""
        return os.getenv("IS_TEST_MODE", "").lower() == "true"
    
    def __get_today(self) -> str:
        """Get current date in YYYY-MM-DD format"""
        return datetime.now().strftime("%Y-%m-%d")
    
    def __get_now(self) -> str:
        """Get current datetime in YYYY-MM-DD HH:MM:SS format"""
        return datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    
    async def __log_in_file(self, content: str, file_name: str) -> None:
        """Write log content to file"""
        today = self.__get_today()
        now = self.__get_now()
        content = f"\n[{now}]\n{content}"
        
        extension = LogExtensionEnum.SQL if file_name == LogExtensionEnum.SQL else LogExtensionEnum.LOG
        
        # Get logs folder path
        logs_path = Path.cwd() / "storage" / "logs"
        path_log_file = logs_path / f"{file_name}-{today}.{extension}"
        
        await file_put_contents(str(path_log_file), content)
    
    def __get_as_json(self, variable: Any) -> str:
        """Convert variable to JSON string with special handling for exceptions"""
        if isinstance(variable, Exception):
            return json.dumps({
                "name": type(variable).__name__,
                "message": str(variable),
                "stack": getattr(variable, '__traceback__', None),
            }, indent=2, default=str)
        
        try:
            return json.dumps(variable, indent=2, default=str)
        except TypeError:
            return str(variable)
    
    async def __safe_elastic_log(self, elastic_coroutine) -> None:
        """Safely execute Elasticsearch logging without blocking"""
        try:
            await elastic_coroutine
        except Exception as e:
            print(f"Elasticsearch logging error: {e}")
    
    # Legacy method names for backward compatibility
    def log_info(self, message: str, data: Dict[str, Any] = None):
        """Legacy method - maps to log_debug"""
        self.log_debug(data or {}, message)