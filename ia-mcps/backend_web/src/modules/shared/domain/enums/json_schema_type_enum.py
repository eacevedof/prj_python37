from typing import final


@final
class JsonSchemaTypeEnum:
    """Tipos JSON Schema usados en los esquemas de la app."""

    OBJECT = "object"
    STRING = "string"
    INTEGER = "integer"
    BOOLEAN = "boolean"
    NUMBER = "number"
    ARRAY = "array"
    NULL = "null"
