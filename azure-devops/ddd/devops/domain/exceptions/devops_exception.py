from typing import final


@final
class DevOpsException(Exception):
    """Exception for local DevOps operations."""

    def __init__(self, message: str, context: dict | None = None) -> None:
        super().__init__(message)
        self.message = message
        self.context = context or {}

    @classmethod
    def clone_failed(cls, repo_url: str, error: str) -> "DevOpsException":
        return cls(f"Failed to clone repository: {error}", {"repo_url": repo_url})

    @classmethod
    def vhost_write_failed(cls, path: str, error: str) -> "DevOpsException":
        return cls(f"Failed to write VirtualHost config: {error}", {"path": path})

    @classmethod
    def database_creation_failed(cls, db_name: str, error: str) -> "DevOpsException":
        return cls(
            f"Failed to create database '{db_name}': {error}", {"db_name": db_name}
        )

    @classmethod
    def hosts_file_failed(cls, error: str) -> "DevOpsException":
        return cls(f"Failed to update hosts file: {error}", {})

    @classmethod
    def env_file_failed(cls, path: str, error: str) -> "DevOpsException":
        return cls(f"Failed to create .env file: {error}", {"path": path})

    @classmethod
    def apache_restart_failed(cls, error: str) -> "DevOpsException":
        return cls(f"Failed to restart Apache: {error}", {})

    @classmethod
    def port_detection_failed(cls, error: str) -> "DevOpsException":
        return cls(f"Failed to detect next available port: {error}", {})

    @classmethod
    def empty_password(cls) -> "DevOpsException":
        return cls("Password cannot be empty", {})

    @classmethod
    def anubis_query_failed(cls, status_code: int, error: str) -> "DevOpsException":
        return cls(
            f"Anubis query failed with status {status_code}: {error}",
            {"status_code": status_code},
        )

    @classmethod
    def anubis_empty_query(cls) -> "DevOpsException":
        return cls("SQL query cannot be empty", {})

    @classmethod
    def anubis_write_rejected(cls) -> "DevOpsException":
        return cls("Write operation was rejected by user", {})

    @classmethod
    def missing_env_variable(cls, var_name: str) -> "DevOpsException":
        return cls(
            f"Missing required environment variable: {var_name}",
            {"variable": var_name},
        )
