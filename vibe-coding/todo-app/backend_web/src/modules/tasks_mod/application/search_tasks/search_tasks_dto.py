from dataclasses import dataclass
from typing import Any, Self, final

from src.modules.shared.domain.enums.boolean_input_enum import BooleanInputEnum
from src.modules.tasks_mod.domain.enums.task_done_enum import TaskDoneEnum
from src.modules.tasks_mod.domain.enums.task_field_enum import TaskFieldEnum


@final
@dataclass(frozen=True, slots=True)
class SearchTasksDto:
    """Entrada del caso de uso SearchTasks (filtros del listado).

    `is_done` tiene TRES estados, no dos, y esa es la parte interesante:

        None   -> el cliente no filtro: devuelve hechas y pendientes
        0      -> solo pendientes
        1      -> solo hechas

    Por eso es `int | None` y no `bool`. Con un bool no habria forma de distinguir
    "no me lo has pedido" de "damelo a false", y `?is_done=false` acabaria
    devolviendo lo mismo que no poner el filtro.
    """

    id_list: int
    is_done: int | None

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            id_list=int(primitives.get(TaskFieldEnum.ID_LIST, 0) or 0),
            is_done=cls.__get_is_done(primitives),
        )

    @classmethod
    def __get_is_done(cls, primitives: dict[str, Any]) -> int | None:
        # Ausente = sin filtro. Se comprueba la presencia de la clave, no su valor,
        # justamente para poder distinguir "no viene" de "viene a false".
        if TaskFieldEnum.IS_DONE not in primitives:
            return None
        raw_is_done = primitives[TaskFieldEnum.IS_DONE]
        if raw_is_done is None or str(raw_is_done).strip() == "":
            return None
        # Por query string llega "1"/"true"; por JSON llega el booleano de verdad.
        is_done = raw_is_done is True or str(raw_is_done) in BooleanInputEnum.TRUTHY_VALUES
        return int(TaskDoneEnum.DONE.value if is_done else TaskDoneEnum.PENDING.value)
