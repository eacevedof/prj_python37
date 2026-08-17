from typing import Protocol


class ListsReader(Protocol):
    """Puerto: ¿existe esta lista y esta viva?

    El puerto simetrico al de listas, en el otro sentido. Una tarea NO puede
    existir sin lista, asi que antes de crear una hay que preguntar. Pero tareas
    no debe saber como se llama la tabla de listas, ni que el borrado es logico,
    ni el SQL que hace falta: solo necesita un si o un no.

    Devuelve `bool` y NUNCA lanza. Si lanzara una `ListsException`, subiria hasta
    el controller de tareas -que solo captura `TasksException`- y acabaria
    convertida en un 500, cuando lo que hay es un 404 perfectamente normal.

    Lo cumple `ListsReaderAdapter`, en el modulo de listas.
    """

    def has_list(self, list_id: int) -> bool: ...
