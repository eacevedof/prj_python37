from typing import Any, Self, final

from src.modules.shared.domain.enums.response_code_enum import ResponseCodeEnum
from src.modules.shared.domain.enums.response_key_enum import ResponseKeyEnum
from src.modules.shared.domain.enums.response_message_enum import ResponseMessageEnum
from src.modules.shared.infrastructure.components.logger.logger import Logger

from src.modules.{{modulo}}_mod.application.{{caso_de_uso}}.{{caso_de_uso}}_dto import {{CasoDeUso}}Dto
from src.modules.{{modulo}}_mod.application.{{caso_de_uso}}.{{caso_de_uso}}_service import {{CasoDeUso}}Service
from src.modules.{{modulo}}_mod.domain.exceptions.{{modulo}}_exception import {{Modulo}}Exception


@final
class {{CasoDeUso}}Controller:
    """Controller de <METODO /api/ruta>."""

    _logger: Logger
    _{{caso_de_uso}}_service: {{CasoDeUso}}Service

    def __init__(self) -> None:
        self._logger = Logger.get_instance()
        self._{{caso_de_uso}}_service = {{CasoDeUso}}Service.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def invoke(self, request_data: dict[str, Any]) -> dict[str, Any]:
        try:
            result_dto = self._{{caso_de_uso}}_service({{CasoDeUso}}Dto.from_primitives(request_data))
            return {
                ResponseKeyEnum.STATUS: ResponseCodeEnum.OK,
                ResponseKeyEnum.DATA: result_dto.to_dict(),
            }
        except {{Modulo}}Exception as {{modulo}}_exception:
            # Error ESPERADO: el service decidio que esto podia pasar. Su codigo y
            # su mensaje van tal cual al cliente.
            return {
                ResponseKeyEnum.STATUS: {{modulo}}_exception.code,
                ResponseKeyEnum.ERROR: {{modulo}}_exception.message,
            }
        except Exception as exception:
            # Error INESPERADO: al log con su traza, y al cliente un mensaje
            # generico. Nunca se devuelve el texto de la excepcion.
            self._logger.log_exception(exception, "{{CasoDeUso}}Controller.invoke")
            return {
                ResponseKeyEnum.STATUS: ResponseCodeEnum.INTERNAL_SERVER_ERROR,
                ResponseKeyEnum.ERROR: ResponseMessageEnum.UNEXPECTED_ERROR,
            }
