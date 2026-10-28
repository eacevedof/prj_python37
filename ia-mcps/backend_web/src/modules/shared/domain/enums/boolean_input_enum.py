from typing import final


@final
class BooleanInputEnum:
    """Valores de un .env que cuentan como verdadero."""

    TRUTHY_VALUES = ("1", "true", "TRUE", "True", "yes", "on")
