"""Componente: parseo JSON best-effort (envuelve json.loads)."""

import json
from typing import Self


class JsonParser:
    """Deserializa JSON con fallback.

    Si `value` no es JSON válido devuelve el default: ese default es el RESULTADO
    del contrato (no un error tragado), de modo que quien lee columnas JSON no
    necesita try/except.
    """

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def parse_list(self, value: object, default: list | None = None) -> list:
        """Lista deserializada de `value` (str JSON, o ya lista), o `default`/[]."""
        fallback = default if default is not None else []
        if isinstance(value, list):
            return value
        if not isinstance(value, str) or not value:
            return fallback
        try:
            parsed = json.loads(value)
        except (ValueError, TypeError):
            return fallback
        return parsed if isinstance(parsed, list) else fallback
