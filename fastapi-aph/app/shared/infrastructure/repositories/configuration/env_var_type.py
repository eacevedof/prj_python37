from typing import TypedDict


class EnvVarType(TypedDict):
    """Environment variables type definition"""
    environment: str
    app_name: str
    base_url: str
    elastic_api_url: str
    log_paths: str
    app_version: str
    app_version_update: str