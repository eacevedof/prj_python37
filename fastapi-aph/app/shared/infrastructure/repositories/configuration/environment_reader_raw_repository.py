import os
from pathlib import Path
from typing import Optional

from app.shared.infrastructure.enums.env_key_enum import EnvKeyEnum
from app.shared.infrastructure.enums.environment_enum import EnvironmentEnum
from app.shared.infrastructure.repositories.configuration.env_var_type import EnvVarType


class EnvironmentReaderRawRepository:
    """Repository for reading environment configuration"""
    
    _instance: Optional['EnvironmentReaderRawRepository'] = None
    
    def __init__(self):
        self.env_vars: EnvVarType = {
            "app_version": "v.0.0.5",
            "app_version_update": "2025-08-28", 
            "environment": self._get_env(EnvKeyEnum.APP_ENV) or EnvironmentEnum.PRODUCTION.value,
            "app_name": self._get_env(EnvKeyEnum.APP_NAME) or "env-app-name",
            "base_url": self._get_env(EnvKeyEnum.APP_URL) or "env-base-url",
            "elastic_api_url": self._get_env(EnvKeyEnum.APP_ELASTIC_API_URL) or "",
            "log_paths": str(Path.cwd() / "storage" / "logs"),
        }
    
    @classmethod
    def get_instance(cls) -> 'EnvironmentReaderRawRepository':
        if cls._instance is None:
            cls._instance = cls()
        return cls._instance
    
    def _get_env(self, key: EnvKeyEnum) -> Optional[str]:
        """Get environment variable by enum key"""
        return os.getenv(key.value)
    
    def is_local(self) -> bool:
        """Check if environment is local"""
        return self.get_environment() == EnvironmentEnum.LOCAL
    
    def is_production(self) -> bool:
        """Check if environment is production"""
        return self.get_environment() == EnvironmentEnum.PRODUCTION
    
    def get_environment(self) -> EnvironmentEnum:
        """Get current environment"""
        return EnvironmentEnum(self.env_vars["environment"])
    
    def get_app_name(self) -> str:
        """Get application name"""
        return self.env_vars["app_name"]
    
    def get_base_url(self) -> str:
        """Get base URL"""
        return self.env_vars["base_url"]
    
    def get_log_path(self) -> str:
        """Get log path"""
        return self.env_vars["log_paths"]
    
    def get_app_version(self) -> str:
        """Get application version"""
        return self.env_vars["app_version"]
    
    def get_app_version_update(self) -> str:
        """Get application version update date"""
        return self.env_vars["app_version_update"]
    
    def get_env_vars(self) -> EnvVarType:
        """Get all environment variables"""
        return self.env_vars