from datetime import datetime
from typing import Self, final

from src.modules.tasks_mod.domain.enums.task_limit_enum import TaskLimitEnum


@final
class DueDate:
    """Servicio de dominio: la regla de que es una fecha de vencimiento valida.

    QUE ES UN SERVICIO DE DOMINIO
    -----------------------------
    Logica de negocio pura: sin base de datos, sin red, sin ficheros. Se usa
    cuando una regla no encaja de forma natural dentro de un caso de uso concreto,
    normalmente porque la comparten varios.

    Aqui la comparten dos: CreateTask y UpdateTask. Antes estaba duplicada en los
    dos services, y una regla duplicada es una regla que tarde o temprano cambia
    solo en un sitio.

    Fijate en el NOMBRE: `DueDate`, sin sufijo. Los servicios de dominio no llevan
    `Service` detras -eso es de los casos de uso- porque no son una accion, son un
    concepto del negocio con comportamiento.

    SOBRE EL try/except
    -------------------
    Este es uno de los cuatro sitios del proyecto donde esta permitido capturar, y
    la razon es concreta: `strptime` comunica "esto no es una fecha" lanzando, y
    aqui se traduce a un booleano del dominio. **No se oculta nada**: el resultado
    de la comprobacion sale entero, y quien decide que hacer con el (devolver un
    400) es el caso de uso.

    Lo que NO seria aceptable es capturar para seguir adelante como si nada. La
    diferencia entre traducir un error y tragarselo es que despues de traducirlo
    quien llama sigue sabiendo que paso.
    """

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def is_valid(self, value: str) -> bool:
        try:
            datetime.strptime(value, TaskLimitEnum.DUE_DATE_FORMAT)
            return True
        except ValueError:
            return False
