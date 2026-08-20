from typing import Any, Callable, final

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


@final
class McpRoutes:
    """Tabla de endpoints MCP: "/mcp/xxx" -> factoría del controller."""

    BY_PATH: dict[str, Callable[[], Any]] = {
        "/mcp/emt": lambda: QueryEmtController.get_instance(),
        "/mcp/media": lambda: CreateMediaController.get_instance(),
        "/mcp/pdf": lambda: ConvertPdfController.get_instance(),
        "/mcp/file-checker": lambda: VerifyFileController.get_instance(),
        "/mcp/memory": lambda: ManageMemoryController.get_instance(),
    }
