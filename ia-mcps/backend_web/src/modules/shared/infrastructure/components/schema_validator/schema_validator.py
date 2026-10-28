from typing import Any, Self, final

from jsonschema import Draft7Validator


@final
class SchemaValidator:
    """Contrasta un payload contra un JSON Schema y describe el primer fallo.

    Envuelve `jsonschema` — nada más: ni logger, ni repos, ni try/except
    (contrato de componente). Usa `iter_errors`, que DEVUELVE los errores en vez
    de lanzarlos, así que no hay nada que capturar: quien decide si eso es un
    fallo, y con qué excepción, es el service que lo llama.
    """

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def get_first_error_message(
        self, payload_dict: dict[str, Any], json_schema: dict[str, Any]
    ) -> str:
        """Primer incumplimiento del payload, o "" si el payload cumple.

        Se ordena por ruta para que el mensaje sea estable entre ejecuciones
        (`iter_errors` no garantiza orden) y el agente reciba siempre el mismo
        texto ante el mismo error.
        """
        validation_errors = sorted(
            Draft7Validator(json_schema).iter_errors(payload_dict),
            key=lambda validation_error: list(validation_error.absolute_path),
        )
        if not validation_errors:
            return ""
        return validation_errors[0].message
