from typing import final


@final
class ListFieldEnum:
    """Nombres de los campos de una lista.

    Estas cadenas se usan en tres sitios: como clave de lo que llega del cliente
    (`primitives["name"]`), como nombre de columna en el SQL y como clave de lo
    que se devuelve. Escribirlas a mano en los tres sitios es como se acaba
    teniendo un `nombre` en un lado y un `name` en otro.

    Que el campo de la peticion, la columna y la respuesta se llamen igual es una
    decision de este proyecto: menos traduccion, menos sitios donde equivocarse.
    Cuando NO puedan llamarse igual, la traduccion se hace en `from_primitives`
    del DTO, que es el sitio previsto para eso.
    """

    ID = "id"
    LIST_ID = "list_id"
    NAME = "name"
    COLOR = "color"
    POSITION = "position"
    INSERT_DATE = "insert_date"
    UPDATE_DATE = "update_date"
    OPEN_TASKS_COUNT = "open_tasks_count"
    NAME_CONTAINS = "name_contains"
    IS_DELETED = "is_deleted"
    ITEMS = "items"
    TOTAL = "total"
