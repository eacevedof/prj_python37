from dataclasses import dataclass
from typing import Any, Self, final

from src.modules.{{modulo}}_mod.domain.enums.{{entidad}}_field_enum import {{Entidad}}FieldEnum


@final
@dataclass(frozen=True, slots=True)
class {{CasoDeUso}}Dto:
    """Entrada del caso de uso {{CasoDeUso}}."""

    # <campos, solo primitivos: int, str, bool, str | None>

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        # Solo CONVIERTE. Validar es del service.
        # El `or 0` cubre que llegue None o vacio: int(None) reventaria.
        return cls()
