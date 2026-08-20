from abc import ABC, abstractmethod
from contextlib import AbstractAsyncContextManager
from typing import Any

from mcp.server import Server, ServerRequestContext
from mcp.server.streamable_http_manager import StreamableHTTPSessionManager
from mcp.types import (
    CallToolRequestParams,
    CallToolResult,
    ListToolsResult,
    PaginatedRequestParams,
    TextContent,
    Tool,
)

from src.modules.shared.domain.enums.json_schema_key_enum import JsonSchemaKeyEnum
from src.modules.shared.domain.enums.mcp_method_enum import McpMethodEnum
from src.modules.shared.domain.enums.response_message_enum import ResponseMessageEnum
from src.modules.shared.infrastructure.components.logger.logger import Logger


class AbstractMcpController(ABC):
    """Base de los endpoints MCP: uno por módulo `xxx_mcp`.

    Centraliza lo que es idéntico en todos —montar el `Server` del SDK, registrar
    los handlers del protocolo, gestionar el ciclo de vida del transporte y
    traducir errores a texto— para que cada controller concreto solo aporte lo
    suyo: su catálogo de tools y a qué service enruta.

    Es un controller, así que es la ÚNICA capa que captura excepciones: el SDK
    nunca debe ver una excepción de dominio.

    Diferencia con ocr-documents: aquí `get_tool_text` es **async**, porque los
    casos de uso de este repo hablan por red (aiohttp) y nacieron asíncronos.
    Tampoco recibe `auth_user_id`: no hay usuarios, la apikey autoriza pero no
    identifica.
    """

    _logger: Logger
    _mcp_server: Server

    _streamable_http_session_manager: StreamableHTTPSessionManager | None

    def __init__(self, mcp_server_name: str) -> None:
        self._logger = Logger.get_instance()
        self._mcp_server = Server(mcp_server_name)
        self._streamable_http_session_manager = None
        self.__register_services_as_handlers()

    @abstractmethod
    def get_tool_schemas(self) -> list[dict[str, Any]]:
        """Catálogo de tools del módulo, tal cual lo publica su repo de schemas."""

    @abstractmethod
    async def get_tool_text(self, tool_name: str, payload_dict: dict[str, Any]) -> str:
        """Ejecuta la tool llamando al service del módulo y devuelve su texto."""

    @abstractmethod
    def get_domain_exception_types(self) -> tuple[type[Exception], ...]:
        """Excepciones controladas del módulo, que viajan al agente como texto.

        Cada bounded context tiene la suya (`EmtException`, `EmtMcpException`,
        ...) y no comparten jerarquía, así que el concreto las declara.
        """

    def get_asgi_app(self) -> Any:
        """ASGI app del endpoint, para montarla en el front-controller.

        Resuelve el session manager en cada petición, no al montar: el manager
        se renueva en cada ciclo de vida y capturarlo aquí dejaría clavado el de
        un arranque anterior.
        """

        async def asgi_app(scope: dict[str, Any], receive: Any, send: Any) -> None:
            if self._streamable_http_session_manager is None:
                raise RuntimeError(
                    "MCP session manager not started: get_session_runner() must be entered in the app lifespan"
                )
            await self._streamable_http_session_manager.handle_request(scope, receive, send)

        return asgi_app

    def get_session_runner(self) -> AbstractAsyncContextManager[None]:
        """Ciclo de vida del session manager: lo abre el lifespan de la app.

        Montar la app Starlette del SDK dentro de FastAPI NO propagaría su
        lifespan, y sin él el task group del manager queda sin inicializar y
        toda petición revienta. Por eso se monta el handler ASGI pelado y el
        arranque se hace desde el lifespan del front-controller.

        Crea un manager NUEVO en cada llamada porque el SDK solo admite un
        `run()` por instancia; reutilizarlo rompería un segundo arranque de la
        app en el mismo proceso. El `Server` y sus handlers sí se conservan.
        """
        self._streamable_http_session_manager = StreamableHTTPSessionManager(
            app=self._mcp_server,
            json_response=True,
            stateless=True,
        )
        return self._streamable_http_session_manager.run()

    def __register_services_as_handlers(self) -> None:
        self._mcp_server.add_request_handler(
            McpMethodEnum.LIST_TOOLS.value, PaginatedRequestParams, self.__get_list_tools_result
        )
        self._mcp_server.add_request_handler(
            McpMethodEnum.CALL_TOOL.value, CallToolRequestParams, self.__get_call_tool_result
        )

    async def __get_list_tools_result(
        self,
        server_request_context: ServerRequestContext,
        paginated_request_params: PaginatedRequestParams | None,
    ) -> ListToolsResult:
        try:
            return ListToolsResult(
                tools=[
                    Tool(
                        name=tool_schema[JsonSchemaKeyEnum.NAME],
                        description=tool_schema[JsonSchemaKeyEnum.DESCRIPTION],
                        inputSchema=tool_schema[JsonSchemaKeyEnum.INPUT_SCHEMA],
                    )
                    for tool_schema in self.get_tool_schemas()
                ]
            )
        except Exception as exc:
            self._logger.log_exception(exc, f"{type(self).__name__}.list_tools")
            return ListToolsResult(tools=[])

    async def __get_call_tool_result(
        self,
        server_request_context: ServerRequestContext,
        call_tool_request_params: CallToolRequestParams,
    ) -> CallToolResult:
        try:
            text = await self.get_tool_text(
                call_tool_request_params.name,
                call_tool_request_params.arguments or {},
            )
        except self.get_domain_exception_types() as domain_exception:
            # Error controlado: el agente lo lee y reacciona (corrige el id de
            # parada, cambia de tool...). No se loguea como incidencia. Va con
            # isError para que el cliente MCP lo distinga de una respuesta buena.
            return self.__get_error_result(domain_exception.message)
        except Exception as exc:
            self._logger.log_exception(
                exc, f"{type(self).__name__}.call_tool: {call_tool_request_params.name}"
            )
            self._logger.log_payload_error(
                call_tool_request_params.arguments,
                f"{type(self).__name__}.call_tool.payload: {call_tool_request_params.name}",
            )
            return self.__get_error_result(ResponseMessageEnum.UNEXPECTED_ERROR)

        return CallToolResult(content=[TextContent(type="text", text=text)], isError=False)

    def __get_error_result(self, message: str) -> CallToolResult:
        return CallToolResult(
            content=[TextContent(type="text", text=f"error: {message}")], isError=True
        )
