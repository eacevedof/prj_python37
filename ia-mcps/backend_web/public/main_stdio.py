"""Front controller de STDIO: sirve UN servidor MCP por stdin/stdout.

Hermano de `public/main.py` (HTTP). Los dos montan los mismos controllers de
`McpRoutes`; solo cambia el tubo por el que viajan los JSON-RPC:

    HTTP    un proceso sirve los CINCO servers en el puerto 8010, lo arrancas
            tú (`make dev`) y el borde de apikey protege el puerto.
    stdio   un proceso por server, lo arranca el CLIENTE (Claude Code) y muere
            con la sesión. Sin puerto y sin apikey: quien lanza el proceso ya
            está del lado de dentro.

Uso:

    python public/main_stdio.py <server>     # emt | media | pdf | file-checker | memory

Los nombres válidos son los de `McpRoutes.BY_NAME`, derivados de las rutas HTTP.
"""

import sys
from pathlib import Path

# El cliente MCP lanza este fichero como proceso suelto y con un cwd que no
# controlamos, así que `src.*` no estaría en el path (al ejecutar un fichero,
# Python mete en sys.path su carpeta —`public/`—, no la raíz del proyecto).
# Se resuelve antes de importar nada del proyecto; de ahí los E402 de abajo.
_BACKEND_WEB_PATH = str(Path(__file__).resolve().parents[1])
if _BACKEND_WEB_PATH not in sys.path:
    sys.path.insert(0, _BACKEND_WEB_PATH)

import anyio  # noqa: E402

from src.core.routes.mcp_routes import McpRoutes  # noqa: E402
from src.modules.shared.infrastructure.components.logger.logger import Logger  # noqa: E402

_EXIT_BAD_USAGE = 2


def _get_usage_text() -> str:
    return (
        f"usage: python {Path(__file__).name} <server>\n"
        f"servers: {' | '.join(McpRoutes.BY_NAME)}"
    )


def _write_stderr(message: str) -> None:
    """stdout es el protocolo: cualquier mensaje para un humano va por stderr."""
    print(message, file=sys.stderr)


def start_mcp_or_fail() -> None:
    """Arranca el server pedido por argumento y loguea a fichero si revienta.

    En stdio no hay a quién devolverle un 500: si el arranque falla, el proceso
    muere y el cliente solo ve que el server "no responde". El stderr se lo suele
    quedar el cliente, así que la traza a `storage/logs` es LA única pista que
    queda; por eso se captura aquí arriba del todo.
    """
    if len(sys.argv) != 2:
        _write_stderr(_get_usage_text())
        sys.exit(_EXIT_BAD_USAGE)

    mcp_server_name = sys.argv[1]
    mcp_controller_factory = McpRoutes.BY_NAME.get(mcp_server_name)
    if mcp_controller_factory is None:
        _write_stderr(f"unknown mcp server: {mcp_server_name}\n{_get_usage_text()}")
        sys.exit(_EXIT_BAD_USAGE)

    try:
        anyio.run(mcp_controller_factory().run_stdio)
    except KeyboardInterrupt:
        # Cierre normal: el cliente cerró la tubería. No es una incidencia.
        pass
    except BaseException as exc:
        Logger.get_instance().log_exception(exc, f"main_stdio.start_mcp: {mcp_server_name}")
        raise


if __name__ == "__main__":
    start_mcp_or_fail()
