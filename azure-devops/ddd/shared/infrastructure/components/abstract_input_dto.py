from dataclasses import dataclass
from typing import Any


@dataclass(frozen=True, slots=True)
class AbstractInputDto:
    user_ip_address: str = ""
    user_browser: str = ""
    user_browser_version: str = ""
    user_os: str = ""
    user_time_zone: str = ""
    language_code: str = "es"

    @classmethod
    def _get_base_fields_from_primitives(cls, primitives: dict[str, Any]) -> dict[str, str]:
        return {
            "user_ip_address": str(primitives.get("user_ip_address", "")).strip(),
            "user_browser": str(primitives.get("user_browser", "")).strip(),
            "user_browser_version": str(primitives.get("user_browser_version", "")).strip(),
            "user_os": str(primitives.get("user_os", "")).strip(),
            "user_time_zone": str(primitives.get("user_time_zone", "")).strip(),
            "language_code": str(primitives.get("language_code", "es")).strip(),
        }
