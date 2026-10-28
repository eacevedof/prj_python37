from typing import final


@final
class JsonSchemaKeyEnum:
    """Vocabulario JSON Schema con el que se declaran los esquemas de la app.

    Lo usan los `inputSchema` de las tools (contrato que el SDK de MCP publica en
    `list_tools` y que el modelo lee para saber qué argumentos puede mandar): una
    clave mal escrita no rompe nada al arrancar, simplemente deja de validar y el
    modelo empieza a inventarse campos.
    """

    NAME = "name"
    DESCRIPTION = "description"
    INPUT_SCHEMA = "inputSchema"
    TYPE = "type"
    PROPERTIES = "properties"
    REQUIRED = "required"
    ADDITIONAL_PROPERTIES = "additionalProperties"
    ENUM = "enum"
    DEFAULT = "default"
    ITEMS = "items"
