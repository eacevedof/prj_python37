from typing import Any, Protocol


# Puerto: lo declara la fachada MCP (quien lo necesita) y lo cumple, sin saberlo,
# el adaptador de users_mod. No lleva @final por ser un port.
class UserDirectoryPort(Protocol):
    """Puerto (dominio de emt_mcp): el listado de usuarios, para el admin.

    Lo cumple `users_mod`, que es quien decide si el que pregunta tiene derecho
    a ver esa lista. La fachada no comprueba el rol: si no puede, lo que recibe
    es una excepción y no una lista recortada.
    """

    async def get_users(self, primitives: dict[str, Any]) -> dict[str, Any]:
        ...
