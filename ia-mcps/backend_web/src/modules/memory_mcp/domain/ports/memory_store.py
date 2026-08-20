from typing import Any, Protocol


# Puerto: lo declara la fachada MCP (quien lo necesita) y lo cumple, sin saberlo,
# el adaptador de memory_mod. No lleva @final por ser un port.
class MemoryStore(Protocol):
    """Puerto (dominio de memory_mcp): la memoria semántica de proyecto.

    La fachada sabe QUÉ se puede hacer con la memoria; ChromaDB, el modelo de
    embeddings, el troceado y el control de frescura son de `memory_mod`.
    """

    async def store_memory(self, primitives: dict[str, Any]) -> dict[str, Any]:
        ...

    async def search_memory(self, primitives: dict[str, Any]) -> dict[str, Any]:
        ...

    async def check_freshness(self, primitives: dict[str, Any]) -> dict[str, Any]:
        ...

    async def list_memories(self, primitives: dict[str, Any]) -> dict[str, Any]:
        ...

    async def delete_memory(self, primitives: dict[str, Any]) -> dict[str, Any]:
        ...

    async def update_memory(self, primitives: dict[str, Any]) -> dict[str, Any]:
        ...

    async def store_file(self, primitives: dict[str, Any]) -> dict[str, Any]:
        ...
