from typing import Self, final

from src.modules.tasks_mod.infrastructure.repositories.tasks_reader_sqlite_repository import (
    TasksReaderSqliteRepository,
)


@final
class TasksCounterAdapter:
    """Cumple el puerto `TasksCounter` que declara lists_mod.

    QUE ES UN ADAPTADOR
    -------------------
    La otra mitad del puerto. `lists_mod/domain/ports/tasks_counter.py` dice QUE
    hace falta; esto dice COMO se consigue con lo que hay en este modulo.

    Fijate en que esta clase NO declara que implementa nada (no hereda de
    `TasksCounter` ni lo importa). Funciona igual porque `TasksCounter` es un
    `Protocol`: en Python basta con TENER los metodos correctos. Eso significa que
    tareas ni siquiera necesita saber que existe ese puerto, que es el maximo
    desacoplamiento posible entre dos modulos.

    POR QUE ENVUELVE EL REPOSITORIO Y NO UN CASO DE USO
    --------------------------------------------------
    Es la duda tipica al escribir el primer adaptador, y tiene dos respuestas:

    1. **No hay caso de uso que invocar.** Contar tareas abiertas no es una
       operacion del negocio de tareas: nadie pide "cuentame las tareas abiertas"
       por la API. Es un dato que otro modulo necesita. Crear un caso de uso solo
       para esto seria ceremonia.

    2. **Evita un ciclo de imports.** Si este adaptador llamase a un caso de uso de
       tareas, y ese caso de uso a su vez usara el puerto ListsReader (que lo
       cumple un adaptador de listas)... tendrias listas -> tareas -> listas. Los
       adaptadores solo bajan a la infraestructura de su propio modulo, y con esa
       regla el grafo de ficheros queda sin ciclos aunque los modulos se
       referencien en los dos sentidos.

    UN ADAPTADOR NO LANZA. Si algo va mal, el error de infraestructura sube tal
    cual; lo que no puede hacer es convertirlo en una TasksException, porque
    cruzaria a un controller de listas que no la captura.
    """

    _tasks_reader_sqlite_repository: TasksReaderSqliteRepository

    def __init__(self) -> None:
        self._tasks_reader_sqlite_repository = TasksReaderSqliteRepository.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def get_open_tasks_count(self, list_id: int) -> int:
        return self._tasks_reader_sqlite_repository.get_open_count_by_list(list_id)
