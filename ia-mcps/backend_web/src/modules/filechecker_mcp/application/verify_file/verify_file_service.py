import asyncio
from typing import Any, Self, final

from src.modules.shared.domain.enums.validation_message_enum import ValidationMessageEnum
from src.modules.shared.infrastructure.components.schema_validator.schema_validator import SchemaValidator

from src.modules.filechecker_mod.application.verify_file_signature.verify_file_signature_dto import (
    VerifyFileSignatureDto,
)
from src.modules.filechecker_mod.application.verify_file_signature.verify_file_signature_service import (
    VerifyFileSignatureService,
)

from src.modules.filechecker_mcp.domain.enums.tool_name_enum import ToolNameEnum
from src.modules.filechecker_mcp.domain.exceptions.filechecker_mcp_exception import (
    FilecheckerMcpException,
)
from src.modules.filechecker_mcp.infrastructure.repositories.tools_reader_in_memory_repository import (
    ToolsReaderInMemoryRepository,
)
from src.modules.filechecker_mcp.application.verify_file.verify_file_dto import VerifyFileDto
from src.modules.filechecker_mcp.application.verify_file.verify_file_result_dto import (
    VerifyFileResultDto,
)

_NOT_AVAILABLE = "n/d"


@final
class VerifyFileService:
    """Caso de uso de la fachada MCP: ejecutar una tool del servidor de file_checker.

    NO tiene lógica de negocio: valida el payload contra el schema publicado,
    enruta al caso de uso de `filechecker_mod` a través del puerto y redacta el
    informe como texto para el agente.
    """

    _schema_validator: SchemaValidator
    _tools_reader_in_memory_repository: ToolsReaderInMemoryRepository
    _verify_file_signature_service: VerifyFileSignatureService

    _verify_file_dto: VerifyFileDto

    def __init__(self) -> None:
        self._schema_validator = SchemaValidator.get_instance()
        self._tools_reader_in_memory_repository = ToolsReaderInMemoryRepository.get_instance()
        self._verify_file_signature_service = VerifyFileSignatureService.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, verify_file_dto: VerifyFileDto) -> VerifyFileResultDto:
        """Caso de uso: VerifyFile.

        Returns:
            VerifyFileResultDto: texto de respuesta para el agente.

        Raises:
            FilecheckerMcpException: si la tool no existe o el payload no cumple
                el inputSchema publicado.
            FileCheckerException: la que propague el caso de uso de filechecker_mod.
        """
        self._verify_file_dto = verify_file_dto
        self._fail_if_wrong_input()

        if self._verify_file_dto.tool_name == ToolNameEnum.VERIFY_FILE_SIGNATURE.value:
            text = await self.__get_verified_file_text()
        else:
            FilecheckerMcpException.bad_request(f"unknown tool: {self._verify_file_dto.tool_name}")

        return VerifyFileResultDto.from_primitives({
            "tool_name": self._verify_file_dto.tool_name,
            "text": text,
        })

    def _fail_if_wrong_input(self) -> None:
        if not self._verify_file_dto.tool_name:
            FilecheckerMcpException.bad_request(ValidationMessageEnum.TOOL_NAME_REQUIRED)
        self.__fail_if_payload_breaks_the_published_schema()

    def __fail_if_payload_breaks_the_published_schema(self) -> None:
        input_schema = self._tools_reader_in_memory_repository.get_input_schema_by_tool_name(
            self._verify_file_dto.tool_name
        )
        if not input_schema:
            return
        first_error_message = self._schema_validator.get_first_error_message(
            self._verify_file_dto.payload_dict, input_schema
        )
        if first_error_message:
            FilecheckerMcpException.bad_request(first_error_message)

    async def __get_verified_file_text(self) -> str:
        # `to_thread` porque el caso de uso lee disco (y puede descargar una URL)
        # de forma síncrona: en el bucle de eventos bloquearía a los demás
        # endpoints. Lo hacía el adaptador; al quitarlo se queda aquí.
        verify_file_signature_result_dto = await asyncio.to_thread(
            self._verify_file_signature_service,
            VerifyFileSignatureDto.from_primitives(self._verify_file_dto.payload_dict),
        )
        return "\n".join([
            "=== informe de verificación ===",
            "",
            "fichero:",
            f"  ruta: {self.__get_text(verify_file_signature_result_dto.file_path)}",
            f"  origen: {self.__get_text(verify_file_signature_result_dto.source)}",
            f"  tamaño: {self.__get_text(verify_file_signature_result_dto.file_size)} bytes",
            f"  modificado: {self.__get_text(verify_file_signature_result_dto.last_modified)}",
            "",
            "hash:",
            f"  algoritmo: {self.__get_text(verify_file_signature_result_dto.algorithm)}",
            f"  valor: {self.__get_text(verify_file_signature_result_dto.hash_value)}",
            "",
            "ejecutable:",
            f"  formato: {self.__get_text(verify_file_signature_result_dto.executable_format, 'no es un ejecutable')}",
            f"  versión: {self.__get_text(verify_file_signature_result_dto.executable_version)}",
            f"  descripción: {self.__get_text(verify_file_signature_result_dto.executable_description)}",
            f"  producto: {self.__get_text(verify_file_signature_result_dto.executable_product_name)}",
            f"  empresa: {self.__get_text(verify_file_signature_result_dto.executable_company)}",
            "",
            "firma digital:",
            f"  método: {self.__get_text(verify_file_signature_result_dto.signature_method, 'no verificada')}",
            f"  estado: {self.__get_text(verify_file_signature_result_dto.signature_status)}",
            f"  firmante: {self.__get_text(verify_file_signature_result_dto.signature_signer, 'no disponible')}",
        ])

    def __get_text(self, value: Any, empty_text: str = _NOT_AVAILABLE) -> str:
        """Un campo vacío se cuenta con palabras: al agente le dice más "no es un
        ejecutable" que una cadena en blanco que parece un fallo."""
        return str(value or empty_text)
