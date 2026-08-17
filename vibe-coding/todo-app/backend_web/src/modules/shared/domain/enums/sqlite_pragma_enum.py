from enum import Enum


class SqlitePragmaEnum(str, Enum):
    """Ajustes que se aplican a CADA conexion SQLite nada mas abrirla.

    Un PRAGMA no es SQL normal: configura el motor. Estos cuatro no son opcionales
    ni cosmeticos, y conviene saber que hace cada uno porque el primero es una
    trampa clasica.

    FOREIGN_KEYS_ON
        SQLite trae las claves ajenas **desactivadas por defecto**, y la opcion es
        por conexion (no se guarda en el fichero). Sin esta linea, el
        `REFERENCES app_lists(id)` de la tabla de tareas es decoracion: puedes
        insertar una tarea apuntando a una lista que no existe y SQLite lo acepta
        sin rechistar. Es el fallo mas comun al usar SQLite.

    JOURNAL_MODE_WAL
        Write-Ahead Logging: los lectores dejan de bloquear al escritor. Importa
        porque `uvicorn --reload` mantiene dos procesos vivos un instante al
        recargar, y porque quieres poder abrir el .db con la CLI de sqlite3 para
        mirar datos sin tumbar la app. Al activarlo aparecen dos ficheros al lado
        del .db (`-wal` y `-shm`): son normales.

    BUSY_TIMEOUT_5000
        Si la base esta ocupada, espera hasta 5 segundos en vez de fallar al
        instante con "database is locked". Convierte un error 500 esporadico en
        una espera que nadie nota.

    SYNCHRONOUS_NORMAL
        Con WAL es el ajuste recomendado: quita un fsync por commit. Se arriesga a
        perder la ultima transaccion ante un corte de corriente, cosa que para un
        PoC es un trato perfectamente razonable.
    """

    FOREIGN_KEYS_ON = "PRAGMA foreign_keys = ON"
    JOURNAL_MODE_WAL = "PRAGMA journal_mode = WAL"
    BUSY_TIMEOUT_5000 = "PRAGMA busy_timeout = 5000"
    SYNCHRONOUS_NORMAL = "PRAGMA synchronous = NORMAL"
