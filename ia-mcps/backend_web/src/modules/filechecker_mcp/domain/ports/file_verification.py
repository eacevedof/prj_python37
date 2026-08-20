from typing import Any, Protocol


# Puerto: lo declara la fachada MCP (quien lo necesita) y lo cumple, sin saberlo,
# el adaptador de filechecker_mod. No lleva @final por ser un port.
class FileVerification(Protocol):
    """Puerto (dominio de filechecker_mcp): verificar la integridad de un fichero.

    La fachada sabe QUÉ se puede preguntar de un fichero y cómo redactarlo; el
    hash, los metadatos, el formato ejecutable y la firma digital son de
    `filechecker_mod`.
    """

    async def verify_file_signature(self, primitives: dict[str, Any]) -> dict[str, Any]:
        ...
