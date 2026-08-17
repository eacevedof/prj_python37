from typing import final


@final
class TaskLimitEnum:
    """Limites y formatos que definen que es una tarea VALIDA."""

    TITLE_MAX_LENGTH = 200
    DESCRIPTION_MAX_LENGTH = 2000
    # Se valida con datetime.strptime en el service. Guardar las fechas como texto
    # ISO ('2026-08-20') es lo que hace que ordenen bien alfabeticamente en SQLite,
    # que no tiene tipo DATE.
    DUE_DATE_FORMAT = "%Y-%m-%d"
    DUE_DATE_HINT = "YYYY-MM-DD"
    DEFAULT_POSITION = 0
