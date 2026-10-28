from typing import Any, Callable, final

from src.modules.shared.domain.enums.auth_enum import AuthEnum
from src.modules.emt_mcp.infrastructure.controllers.query_emt_controller import QueryEmtController
from src.modules.media_mcp.infrastructure.controllers.create_media_controller import CreateMediaController
from src.modules.filechecker_mcp.infrastructure.controllers.verify_file_controller import VerifyFileController
from src.modules.memory_mcp.infrastructure.controllers.manage_memory_controller import ManageMemoryController
from src.modules.pdf_mcp.infrastructure.controllers.convert_pdf_controller import ConvertPdfController

# Endpoints MCP: un módulo `xxx_mcp` = un servidor MCP = un endpoint; el
# catálogo de tools de cada uno lo publica su repo de schemas.
#
# Todos exigen X-Api-Key: el borde de auth del front-controller la valida antes
# de entregar la petición al servidor MCP.
#
# El valor es una FACTORÍA, no el controller ya construido: construirlo aquí
# cablearía en tiempo de import toda la cadena de services (incluido el cliente
# HTTP de EMT), y entonces importar la app exigiría tener el .env completo. El
# controller se materializa en el lifespan y queda cacheado.


_MCP_PATH_PREFIX: str = AuthEnum.MCP_PREFIX.value


@final
class McpRoutes:
    """Tabla de servidores MCP, indexada por sus dos vocabularios.

    `BY_PATH` la usa el front-controller HTTP (`public/main.py`) y `BY_NAME` el
    de stdio (`public/main_stdio.py`), que recibe el nombre por argumento en vez
    de por URL. `BY_NAME` se DERIVA de `BY_PATH` para que dar de alta un módulo
    siga siendo una sola línea y los dos transportes no puedan desincronizarse.
    """

    BY_PATH: dict[str, Callable[[], Any]] = {
        "/mcp/emt": lambda: QueryEmtController.get_instance(),
        "/mcp/media": lambda: CreateMediaController.get_instance(),
        "/mcp/pdf": lambda: ConvertPdfController.get_instance(),
        "/mcp/file-checker": lambda: VerifyFileController.get_instance(),
        "/mcp/memory": lambda: ManageMemoryController.get_instance(),
    }

    # "/mcp/file-checker" -> "file-checker": el nombre del server en stdio es su
    # ruta HTTP sin el prefijo, así que se nombra igual en los dos transportes.
    BY_NAME: dict[str, Callable[[], Any]] = {
        path.removeprefix(_MCP_PATH_PREFIX): mcp_controller_factory
        for path, mcp_controller_factory in BY_PATH.items()
    }
