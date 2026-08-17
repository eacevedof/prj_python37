from typing import Protocol


# Un PUERTO no lleva @final (algo tiene que poder cumplirlo) ni el sufijo "_port"
# (el nombre ya dice lo que es: una capacidad que este modulo necesita).
class TasksCounter(Protocol):
    """Puerto: cuantas tareas sin terminar tiene una lista.

    QUE ES UN PUERTO Y POR QUE EXISTE ESTO
    --------------------------------------
    El modulo de listas necesita un dato que vive en el modulo de tareas: cuantas
    tareas abiertas hay en cada lista. Lo necesita en dos sitios: para pintar el
    contador junto a cada lista, y para no dejar borrar una lista que aun tiene
    trabajo pendiente.

    La forma facil seria importar el repositorio de tareas desde aqui. La forma
    facil es tambien la que acaba con dos modulos que no se pueden tocar por
    separado, porque cada uno conoce las tablas del otro.

    En su lugar, listas declara AQUI lo unico que necesita: "dame un numero a
    partir de un id de lista". Quien lo cumple es `TasksCounterAdapter`, que vive
    en tareas. Consecuencias practicas:

      - Listas no sabe como se llama la tabla de tareas, ni que el borrado es
        logico, ni que existe una columna `is_done`.
      - Se puede probar el caso de uso de listas dando un contador falso de tres
        lineas, sin base de datos.
      - El dia que las tareas se muden a otro servicio, cambia el adaptador y
        listas no se entera.

    DOS REGLAS de este puerto, y las dos importan:

      1. Entra y sale en PRIMITIVOS (un int, un bool). Un puerto es una frontera:
         si cruzaran objetos de dominio, los modulos volverian a acoplarse.
      2. NUNCA lanza. Si lanzara una TasksException, cruzaria la frontera hasta un
         controller de listas que solo captura ListsException, y acabaria siendo
         un 500 en vez del error que toca.
    """

    def get_open_tasks_count(self, list_id: int) -> int:
        ...
