from typing import Any, Protocol


# Puerto: lo declara la fachada MCP (quien lo necesita) y lo cumple, sin saberlo,
# el adaptador de media_mod. No lleva @final por ser un port.
class MediaGeneration(Protocol):
    """Puerto (dominio de media_mcp): generar imagen o audio y dejarlo en disco.

    La fachada sabe QUÉ se puede generar y cómo contárselo al agente; el cliente
    de OpenAI, la validación de modelos/tamaños/voces y la escritura del fichero
    son de `media_mod`, al otro lado de esta interfaz.
    """

    async def generate_image(self, primitives: dict[str, Any]) -> dict[str, Any]:
        ...

    async def generate_audio(self, primitives: dict[str, Any]) -> dict[str, Any]:
        ...
