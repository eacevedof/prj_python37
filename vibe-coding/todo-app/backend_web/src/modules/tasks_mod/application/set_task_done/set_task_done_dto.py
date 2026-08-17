from dataclasses import dataclass
from typing import Any, Self, final

from src.modules.shared.domain.enums.boolean_input_enum import BooleanInputEnum
from src.modules.tasks_mod.domain.enums.task_field_enum import TaskFieldEnum


@final
@dataclass(frozen=True, slots=True)
class SetTaskDoneDto:
    """Entrada del caso de uso SetTaskDone.

    El cliente manda el estado que QUIERE (`is_done: true|false`), no "cambia el
    estado". La diferencia importa:

      - Con estado deseado, llamar dos veces deja el mismo resultado (es
        idempotente). Dos pestanas del navegador pulsando a la vez no se pisan.
      - Con un interruptor que alterna, dos llamadas seguidas vuelven al principio
        y el resultado depende de en que orden lleguen.
    """

    task_id: int
    is_done: bool

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        raw_is_done = primitives.get(TaskFieldEnum.IS_DONE, False)
        return cls(
            task_id=int(primitives.get(TaskFieldEnum.TASK_ID, 0) or 0),
            # Por JSON llega un booleano; por query string, la cadena "1" o "true".
            is_done=raw_is_done is True or str(raw_is_done) in BooleanInputEnum.TRUTHY_VALUES,
        )
