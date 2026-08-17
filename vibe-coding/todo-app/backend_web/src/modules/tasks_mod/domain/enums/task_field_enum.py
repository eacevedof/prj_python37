from typing import final


@final
class TaskFieldEnum:
    """Nombres de los campos de una tarea."""

    ID = "id"
    TASK_ID = "task_id"
    ID_LIST = "id_list"
    TITLE = "title"
    DESCRIPTION = "description"
    IS_DONE = "is_done"
    DUE_DATE = "due_date"
    POSITION = "position"
    INSERT_DATE = "insert_date"
    UPDATE_DATE = "update_date"
    IS_DELETED = "is_deleted"
    ITEMS = "items"
    TOTAL = "total"
