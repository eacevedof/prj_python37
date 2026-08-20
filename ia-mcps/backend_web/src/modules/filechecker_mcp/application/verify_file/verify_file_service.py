from typing import Any, Self, final

from src.modules.shared.domain.enums.validation_message_enum import ValidationMessageEnum
from src.modules.shared.infrastructure.components.schema_validator.schema_validator import SchemaValidator

from src.modules.filechecker_mod.domain.enums.response.file_checker_response_key_enum import (
    FileCheckerResponseKeyEnum,
)
from src.modules.filechecker_mod.infrastructure.adapters.file_verification_adapter import (
    FileVerificationAdapter,
)

from src.modules.filechecker_mcp.domain.enums.tool_name_enum import ToolNameEnum
from src.modules.filechecker_mcp.domain.exceptions.filechecker_mcp_exception import (
    FilecheckerMcpException,
)
from src.modules.filechecker_mcp.domain.ports.file_verification import FileVerification
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
    _file_verification: FileVerification

    _verify_file_dto: VerifyFileDto

    def __init__(self) -> None:
        self._schema_validator = SchemaValidator.get_instance()
        self._tools_reader_in_memory_repository = ToolsReaderInMemoryRepository.get_instance()
        self._file_verification: FileVerification = FileVerificationAdapter.get_instance()

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
        result = await self._file_verification.verify_file_signature(
            self._verify_file_dto.payload_dict
        )
        return "\n".join([
            "=== informe de verificación ===",
            "",
            "fichero:",
            f"  ruta: {self.__get_value(result, FileCheckerResponseKeyEnum.FILE_PATH)}",
            f"  origen: {self.__get_value(result, FileCheckerResponseKeyEnum.SOURCE)}",
            f"  tamaño: {self.__get_value(result, FileCheckerResponseKeyEnum.FILE_SIZE)} bytes",
            f"  modificado: {self.__get_value(result, FileCheckerResponseKeyEnum.LAST_MODIFIED)}",
            "",
            "hash:",
            f"  algoritmo: {self.__get_value(result, FileCheckerResponseKeyEnum.ALGORITHM)}",
            f"  valor: {self.__get_value(result, FileCheckerResponseKeyEnum.HASH_VALUE)}",
            "",
            "ejecutable:",
            f"  formato: {self.__get_value(result, FileCheckerResponseKeyEnum.EXECUTABLE_FORMAT, 'no es un ejecutable')}",
            f"  versión: {self.__get_value(result, FileCheckerResponseKeyEnum.EXECUTABLE_VERSION)}",
            f"  descripción: {self.__get_value(result, FileCheckerResponseKeyEnum.EXECUTABLE_DESCRIPTION)}",
            f"  producto: {self.__get_value(result, FileCheckerResponseKeyEnum.EXECUTABLE_PRODUCT_NAME)}",
            f"  empresa: {self.__get_value(result, FileCheckerResponseKeyEnum.EXECUTABLE_COMPANY)}",
            "",
            "firma digital:",
            f"  método: {self.__get_value(result, FileCheckerResponseKeyEnum.SIGNATURE_METHOD, 'no verificada')}",
            f"  estado: {self.__get_value(result, FileCheckerResponseKeyEnum.SIGNATURE_STATUS)}",
            f"  firmante: {self.__get_value(result, FileCheckerResponseKeyEnum.SIGNATURE_SIGNER, 'no disponible')}",
        ])

    def __get_value(self, result: dict[str, Any], key: str, empty_text: str = _NOT_AVAILABLE) -> str:
        """Un campo vacío se cuenta con palabras: al agente le dice más "no es un
        ejecutable" que una cadena en blanco que parece un fallo."""
        return str(result.get(key) or empty_text)
