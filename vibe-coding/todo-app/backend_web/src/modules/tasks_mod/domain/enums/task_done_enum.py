from enum import IntEnum


class TaskDoneEnum(IntEnum):
    """Los dos estados de una tarea, tal como se guardan en la base.

    SQLite no tiene tipo BOOLEAN: un booleano se guarda como 0 o 1. Este enum
    existe para que en el codigo no aparezcan 0 y 1 sueltos, que no dicen nada al
    leerlos:

        cursor.execute(sql, (1, task_id))                    # ¿1 es que si o el id?
        cursor.execute(sql, (TaskDoneEnum.DONE, task_id))    # esto se lee solo

    Es IntEnum para que se pueda pasar directamente como parametro de una consulta
    sin conversiones.
    """

    PENDING = 0
    DONE = 1
