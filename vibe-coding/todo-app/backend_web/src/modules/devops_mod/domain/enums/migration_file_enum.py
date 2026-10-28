from typing import final


@final
class MigrationFileEnum:
    """Reglas de los ficheros de migracion.

    El nombre de un fichero de migracion es:

        YYYYMMDDHHMMSS-descripcion-en-kebab.sql
        20260818091000-create-app-tasks.sql

    La marca de tiempo del principio no es decorativa: es lo que ORDENA las
    migraciones. Se aplican en orden alfabetico de nombre, y como la fecha va en
    formato ano-mes-dia-hora, el orden alfabetico coincide con el cronologico.

    Si dos personas crean una migracion el mismo dia, la hora las desempata. Si
    aun asi coinciden, cambia un minuto: nunca dos ficheros con el mismo prefijo.
    """

    EXTENSION = ".sql"
    VERSION_LENGTH = 14
    NAME_SEPARATOR = "-"
    FORMAT_HINT = "YYYYMMDDHHMMSS-descripcion.sql"
