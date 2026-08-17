from typing import Any, Callable, final


@final
class Routes:
    """Tabla de rutas REST. UNICO sitio donde se declara un endpoint.

    Formato de cada entrada:

        "METODO /ruta": lambda body: MiController.get_instance().invoke(body),

    Tres cosas que hay que entender antes de tocarla:

    1. **El valor es una lambda, no un controller ya construido.** Si pusieras
       `CreateListController.get_instance().invoke` se construiria el controller al
       importar este fichero, y con el toda su cadena de repositorios, antes de que
       exista la conexion a base de datos. La lambda retrasa esa construccion hasta
       la primera peticion.

    2. **El `body` que recibe la lambda ya viene fusionado** por el front
       controller: cuerpo JSON + query params + parametros de ruta, en ese orden de
       precedencia. Tu controller recibe un unico diccionario y no sabe de donde
       vino cada cosa.

    3. **El parametro de ruta se llama `{id}`** (sintaxis de FastAPI) y aqui se
       renombra a la clave que espera el DTO (`list_id`, `task_id`). Asi la URL
       puede cambiar sin tocar el caso de uso.

    Se rellena a partir de la fase 4. Ahora esta vacia: la app arranca y responde
    /health-check, y nada mas.
    """

    BY_PATH: dict[str, Callable[[dict[str, Any]], dict[str, Any]]] = {}
