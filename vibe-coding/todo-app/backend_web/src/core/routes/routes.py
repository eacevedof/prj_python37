from collections.abc import Callable
from typing import Any, final

from src.modules.lists_mod.infrastructure.controllers.create_list_controller import CreateListController
from src.modules.lists_mod.infrastructure.controllers.delete_list_controller import DeleteListController
from src.modules.lists_mod.infrastructure.controllers.get_list_controller import GetListController
from src.modules.lists_mod.infrastructure.controllers.search_lists_controller import SearchListsController
from src.modules.lists_mod.infrastructure.controllers.update_list_controller import UpdateListController
from src.modules.tasks_mod.infrastructure.controllers.create_task_controller import CreateTaskController
from src.modules.tasks_mod.infrastructure.controllers.delete_task_controller import DeleteTaskController
from src.modules.tasks_mod.infrastructure.controllers.get_task_controller import GetTaskController
from src.modules.tasks_mod.infrastructure.controllers.search_tasks_controller import SearchTasksController
from src.modules.tasks_mod.infrastructure.controllers.set_task_done_controller import SetTaskDoneController
from src.modules.tasks_mod.infrastructure.controllers.update_task_controller import UpdateTaskController


@final
class Routes:
    """Tabla de rutas REST. UNICO sitio donde se declara un endpoint.

    Formato de cada entrada:

        "METODO /ruta": lambda body: MiController.get_instance().invoke(body),

    Cuatro cosas que hay que entender antes de tocarla:

    1. **El valor es una lambda, no un controller ya construido.** Si pusieras
       `CreateListController.get_instance().invoke` se construiria el controller al
       importar este fichero, y con el toda su cadena de repositorios, antes de que
       exista la conexion a base de datos. La lambda retrasa esa construccion hasta
       la primera peticion.

    2. **El `body` ya viene fusionado** por el front controller: cuerpo JSON +
       query params + parametros de ruta, en ese orden de precedencia. Tu
       controller recibe un unico diccionario y no sabe de donde vino cada cosa.

    3. **El parametro de la URL se llama `{id}`** y aqui se renombra a la clave que
       espera el DTO (`list_id`, `task_id`). Por eso la URL puede cambiar sin tocar
       el caso de uso. Es la unica traduccion que ocurre en este fichero.

    4. **Dos rutas pueden compartir controller.** `GET /api/tasks?id_list=3` y
       `GET /api/lists/3/tasks` devuelven lo mismo; lo unico que cambia es de donde
       sale el filtro. No hay dos casos de uso porque no hay dos comportamientos.

    Para anadir un endpoint: importa el controller arriba y anade una linea aqui.
    No hay nada mas que registrar en ningun otro sitio.
    """

    BY_PATH: dict[str, Callable[[dict[str, Any]], dict[str, Any]]] = {
        # ---- listas -------------------------------------------------------------
        "GET /api/lists": lambda body: SearchListsController.get_instance().invoke(body),
        "POST /api/lists": lambda body: CreateListController.get_instance().invoke(body),
        "GET /api/lists/{id}": lambda body: GetListController.get_instance().invoke(
            {**body, "list_id": body.get("id")},
        ),
        "PUT /api/lists/{id}": lambda body: UpdateListController.get_instance().invoke(
            {**body, "list_id": body.get("id")},
        ),
        "DELETE /api/lists/{id}": lambda body: DeleteListController.get_instance().invoke(
            {**body, "list_id": body.get("id")},
        ),
        # ---- tareas -------------------------------------------------------------
        # Sub-recurso: las tareas DE una lista. Mismo controller que GET /api/tasks;
        # solo cambia de donde sale el filtro id_list.
        "GET /api/lists/{id}/tasks": lambda body: SearchTasksController.get_instance().invoke(
            {**body, "id_list": body.get("id")},
        ),
        "GET /api/tasks": lambda body: SearchTasksController.get_instance().invoke(body),
        "POST /api/tasks": lambda body: CreateTaskController.get_instance().invoke(body),
        "GET /api/tasks/{id}": lambda body: GetTaskController.get_instance().invoke(
            {**body, "task_id": body.get("id")},
        ),
        "PUT /api/tasks/{id}": lambda body: UpdateTaskController.get_instance().invoke(
            {**body, "task_id": body.get("id")},
        ),
        # PATCH y no PUT: se manda el estado deseado, no un interruptor que alterna.
        # Asi llamarlo dos veces deja el mismo resultado.
        "PATCH /api/tasks/{id}/done": lambda body: SetTaskDoneController.get_instance().invoke(
            {**body, "task_id": body.get("id")},
        ),
        "DELETE /api/tasks/{id}": lambda body: DeleteTaskController.get_instance().invoke(
            {**body, "task_id": body.get("id")},
        ),
    }
