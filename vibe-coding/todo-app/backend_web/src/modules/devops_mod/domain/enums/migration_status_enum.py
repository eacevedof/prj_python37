from enum import Enum


class MigrationStatusEnum(str, Enum):
    """En que acabo cada fichero de migracion durante el arranque.

    APPLIED  se ejecuto ahora y quedo registrado en la tabla `migrations`.
    SKIPPED  ya estaba aplicado de un arranque anterior. Es lo normal.
    FAILED   reviento. El error se guarda junto al nombre del fichero.
    """

    APPLIED = "applied"
    SKIPPED = "skipped"
    FAILED = "failed"
