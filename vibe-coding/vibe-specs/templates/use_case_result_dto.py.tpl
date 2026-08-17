from dataclasses import dataclass
from typing import Any, Self, final

from src.modules.{{modulo}}_mod.domain.enums.{{entidad}}_field_enum import {{Entidad}}FieldEnum


@final
@dataclass(frozen=True, slots=True)
class {{CasoDeUso}}ResultDto:
    """Salida del caso de uso {{CasoDeUso}}."""

    # <campos, solo primitivos>

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls()

    def to_dict(self) -> dict[str, Any]:
        """Lo que el controller mete en `data`. ES EL CONTRATO con quien llama:
        si cambias una clave aqui, rompes al front."""
        return {}
