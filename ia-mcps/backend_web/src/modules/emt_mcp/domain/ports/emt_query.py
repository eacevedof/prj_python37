from typing import Any, Protocol


# Puerto: lo declara la fachada MCP (quien lo necesita) y lo cumple, sin saberlo,
# el adaptador de emt_mod. No lleva @final por ser un port.
class EmtQuery(Protocol):
    """Puerto (dominio de emt_mcp): las consultas a EMT Madrid que la fachada
    MCP expone como tools.

    La fachada sabe QUÉ se le puede preguntar a EMT y cómo contárselo al agente;
    la API de mobilitylabs, el login con passkey y el mapeo de su respuesta son
    de `emt_mod`, al otro lado de esta interfaz. Entra y sale en primitivos: es
    un borde.

    Async porque al otro lado hay red: el adaptador habla con la API de EMT.
    """

    async def get_stop_arrivals(self, primitives: dict[str, Any]) -> dict[str, Any]:
        ...

    async def get_lines_info(self, primitives: dict[str, Any]) -> dict[str, Any]:
        ...

    async def get_stops_around(self, primitives: dict[str, Any]) -> dict[str, Any]:
        ...

    async def get_stop_detail(self, primitives: dict[str, Any]) -> dict[str, Any]:
        ...
