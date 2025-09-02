import os
from enum import Enum
from typing import Dict, Optional, final
from app.shared.infrastructure.enums.environment_enum import EnvironmentEnum

@final
class EnvKeyEnum(Enum):

    APP_ENV = "APP_ENV"
    APP_NAME = "APP_NAME"
    APP_URL = "APP_URL"
    APP_PORT = "APP_PORT"
    
    APP_ELASTIC_API_URL = "APP_ELASTIC_API_URL"
    APP_REDIS_URL = "APP_REDIS_URL"
    APP_REDIS_DB = "APP_REDIS_DB"
    
    APP_DB_HOST = "APP_DB_HOST"
    APP_DB_PORT = "APP_DB_PORT"
    APP_DB_NAME = "APP_DB_NAME"
    APP_DB_USER = "APP_DB_USER"
    APP_DB_PWD = "APP_DB_PWD"
    
    APP_SHARED_FOLDER_PATH = "APP_SHARED_FOLDER_PATH"
    
    APP_TUNNEL_SERVER = "APP_TUNNEL_SERVER"
    APP_TUNNEL_PORT = "APP_TUNNEL_PORT"
    APP_TUNNEL_USER = "APP_TUNNEL_USER"
    APP_TUNNEL_KEY_FILE = "APP_TUNNEL_KEY_FILE"

def get_env(env_key: EnvKeyEnum) -> Optional[str]:
    """Get environment variable value"""
    return os.getenv(env_key.value)

def get_envs() -> Dict[str, str]:
    """Get all defined environment variables as dictionary"""
    envs: Dict[str, str] = {}
    for key in EnvKeyEnum:
        value = get_env(key)
        if value is not None:
            envs[key.value] = value
    return envs

def is_environment(app_env: EnvironmentEnum) -> bool:
    """Check if current environment matches the specified one"""
    current_env = get_env(EnvKeyEnum.APP_ENV)
    return current_env == app_env.value