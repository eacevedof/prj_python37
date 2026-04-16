import json
import os
from datetime import datetime
from typing import final, Self, Any
from zoneinfo import ZoneInfo

from argon2 import PasswordHasher
from argon2.profiles import RFC_9106_LOW_MEMORY

from ddd.shared.infrastructure.components.curler import Curler
from ddd.shared.infrastructure.components.logger import Logger
from ddd.devops.domain.enums.anubis_environment_enum import AnubisEnvironmentEnum
from ddd.devops.domain.exceptions.devops_exception import DevOpsException


@final
class ProvisionApiRepository:
    """Repository for executing SQL queries against provision API.

    Token generation follows the same algorithm as PHP:
    - Timezone: configurable via PROVISION_TIMEZONE env var
    - Raw token: {domain}{salt}{timestamp}
    - Hash: Argon2id (sodium_crypto_pwhash_str compatible)
    """

    _ENDPOINT_PATH = "lazarus"

    def __init__(self) -> None:
        self._curler = Curler.get_instance()
        self._logger = Logger.get_instance()
        self._hasher = PasswordHasher.from_parameters(RFC_9106_LOW_MEMORY)

        self._salt = self._require_env("PROVISION_SALT")
        self._timezone = self._require_env("PROVISION_TIMEZONE")
        self._domain_production = self._require_env("PROVISION_DOMAIN_PRODUCTION")
        self._domain_development = self._require_env("PROVISION_DOMAIN_DEVELOPMENT")
        self._domain_local = self._require_env("PROVISION_DOMAIN_LOCAL")
        self._environment = self._require_env("PROVISION_ENVIRONMENT")

    @staticmethod
    def _require_env(name: str) -> str:
        """Get required environment variable or raise exception."""
        value = os.getenv(name, "").strip()
        if not value:
            raise DevOpsException.missing_env_variable(name)
        return value

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def _get_domain(self) -> str:
        """Get domain based on current environment."""
        if self._environment == AnubisEnvironmentEnum.PRODUCTION:
            return self._domain_production
        if self._environment == AnubisEnvironmentEnum.LOCAL:
            return self._domain_local
        return self._domain_development

    def _generate_auth_token(self) -> str:
        """Generate authentication token following PHP algorithm.

        Token = Argon2id({domain}{salt}{today_timestamp})
        Timestamp is calculated in configured timezone.
        """
        tz = ZoneInfo(self._timezone)
        today_str = datetime.now(tz).strftime("%Y-%m-%d")
        today_timestamp = int(
            datetime.strptime(today_str, "%Y-%m-%d")
            .replace(tzinfo=tz)
            .timestamp()
        )

        domain = self._get_domain()
        raw_token = f"{domain}{self._salt}{today_timestamp}"

        return self._hasher.hash(raw_token)

    async def execute_query(self, sql: str) -> dict[str, Any]:
        """Execute SQL query against Anubis API.

        Args:
            sql: SQL query to execute.

        Returns:
            Dict with 'result' (list of rows) and 'status_code'.

        Raises:
            DevOpsException: If query fails.
        """
        if not sql.strip():
            raise DevOpsException.anubis_empty_query()

        domain = self._get_domain()
        endpoint = f"{domain}{self._ENDPOINT_PATH}"
        auth_token = self._generate_auth_token()

        headers = {
            "Content-Type": "application/json",
            "Authorization": auth_token,
        }

        response = await self._curler.post_response(
            url=endpoint,
            payload={"sql": sql},
            headers=headers,
            timeout=60,
        )

        status_code = response.get("status_code", 0)

        if status_code != 200:
            error_msg = response.get("response", "") or response.get("error", "")
            self._logger.write_error(
                module="AnubisApiRepository.execute_query",
                message=f"Query failed: {error_msg}",
                context={"status_code": status_code, "sql": sql[:200]},
            )
            raise DevOpsException.anubis_query_failed(status_code, error_msg)

        try:
            response_data = json.loads(response.get("response", "{}"))
            return {
                "result": response_data.get("result", []),
                "status_code": status_code,
            }
        except json.JSONDecodeError as e:
            raise DevOpsException.anubis_query_failed(status_code, str(e))

    def is_write_query(self, sql: str) -> bool:
        """Check if SQL query is a write operation."""
        sql_upper = sql.strip().upper()
        write_keywords = ("INSERT", "UPDATE", "DELETE", "DROP", "CREATE", "ALTER", "TRUNCATE")
        return sql_upper.startswith(write_keywords)
