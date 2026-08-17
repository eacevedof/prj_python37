import traceback
from datetime import datetime, timezone
from pathlib import Path
from typing import Any, Self, final

from src.core.boot import env


@final
class Logger:
    """Escritura de logs a fichero, en `storage/logs/YYYY-MM-DD-<tipo>.log`.

    Es un COMPONENTE, y eso impone tres reglas que se respetan aqui:

      1. Solo depende de la libreria estandar. Nada de repositorios, nada de enums
         de dominio, nada de otros componentes de la app.
      2. No captura excepciones. Si escribir el log falla, el fallo sube: un
         logger que se traga sus propios errores te deja sin log Y sin aviso.
      3. No tiene estado entre llamadas.

    Por eso sus constantes viven dentro de la clase: sacarlas a un enum de dominio
    obligaria al componente a importar dominio, que es justo lo que no puede hacer.
    """

    _DEFAULT_LOGS_PATH = "storage/logs"
    _ERROR_FILE = "error.log"
    _DEBUG_FILE = "debug.log"

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def log_debug(self, message: Any, title: str = "") -> None:
        self.__write(self._DEBUG_FILE, self.__get_formatted("DEBUG", message, title))

    def log_error(self, message: Any, title: str = "") -> None:
        self.__write(self._ERROR_FILE, self.__get_formatted("ERROR", message, title))

    def log_exception(self, throwable: BaseException, title: str = "ERROR") -> None:
        """Vuelca una excepcion con su traza completa.

        Lo llama el `except Exception` de cada controller. La traza va al fichero y
        NO al cliente: el cliente recibe ResponseMessageEnum.UNEXPECTED_ERROR.
        """
        content = "\n".join([
            title,
            f"tipo:    {type(throwable).__name__}",
            f"mensaje: {throwable}",
            f"traza:\n{''.join(traceback.format_exception(throwable))}",
        ])
        self.__write(self._ERROR_FILE, f"[ERROR] {content}")

    def __write(self, file_name: str, content: str) -> None:
        logs_path = env.get("APP_LOG_PATH", "") or self._DEFAULT_LOGS_PATH
        # parents[6]: logger -> components -> infrastructure -> shared -> modules
        #             -> src -> backend_web. APP_LOG_PATH es relativo a backend_web/.
        base_dir = Path(__file__).resolve().parents[6] / logs_path
        base_dir.mkdir(parents=True, exist_ok=True)

        today = datetime.now(timezone.utc).strftime("%Y-%m-%d")
        now = datetime.now(timezone.utc).strftime("%Y-%m-%d %H:%M:%S")
        with open(base_dir / f"{today}-{file_name}", "a", encoding="utf-8") as file_handle:
            file_handle.write(f"\n[{now}]\n{content.strip()}\n")

    def __get_formatted(self, level: str, message: Any, title: str) -> str:
        parts = [f"[{level}]"]
        if title:
            parts.append(title)
        parts.append(message if isinstance(message, str) else repr(message))
        return "\n".join(parts)
