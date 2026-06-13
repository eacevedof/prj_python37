"""HTTP/MCP controller for file signature verification."""

from typing import final

from ddd.shared.domain.enums.response_code_enum import ResponseCodeEnum
from ddd.shared.infrastructure.components.logger import Logger

from ddd.file_checker.domain.enums import (
    FileCheckerHashAlgorithmEnum,
    FileCheckerRequestKeyEnum,
    FileCheckerHttpResponseKeyEnum,
)
from ddd.file_checker.application import VerifyFileSignatureDto, VerifyFileSignatureService
from ddd.file_checker.domain.exceptions.file_checker_exception import FileCheckerException


@final
class VerifyFileSignatureController:
    """Controller that exposes the VerifyFileSignature use case to MCP/HTTP."""

    _logger: Logger
    _verify_file_signature_service: VerifyFileSignatureService

    @classmethod
    def get_instance(cls) -> "VerifyFileSignatureController":
        return cls()

    def __init__(self) -> None:
        self._logger = Logger.get_instance()
        self._verify_file_signature_service = VerifyFileSignatureService.get_instance()

    def invoke(
        self,
        file_path: str,
        expected_hash: str,
        algorithm: str = FileCheckerHashAlgorithmEnum.SHA256,
    ) -> dict:
        """Handle file signature verification request.

        Args:
            file_path: Path to the file to verify.
            expected_hash: Known hash to compare against.
            algorithm: Hash algorithm (md5, sha1, sha256, sha512).

        Returns:
            dict with code and data/error keys.
        """
        try:
            verify_file_signature_result_dto = self._verify_file_signature_service(
                VerifyFileSignatureDto.from_primitives({
                    FileCheckerRequestKeyEnum.FILE_PATH: file_path,
                    FileCheckerRequestKeyEnum.EXPECTED_HASH: expected_hash,
                    FileCheckerRequestKeyEnum.ALGORITHM: algorithm,
                })
            )

            return {
                FileCheckerHttpResponseKeyEnum.CODE: ResponseCodeEnum.OK,
                FileCheckerHttpResponseKeyEnum.DATA: verify_file_signature_result_dto.to_dict(),
            }

        except FileCheckerException as e:
            self._logger.log_error(
                "VerifyFileSignatureController",
                f"Verification failed: {e.message}",
                {FileCheckerRequestKeyEnum.FILE_PATH: file_path}
            )
            return {
                FileCheckerHttpResponseKeyEnum.CODE: e.code,
                FileCheckerHttpResponseKeyEnum.ERROR: e.message,
            }

        except Exception as e:
            self._logger.log_exception(e, "VerifyFileSignatureController.invoke")
            return {
                FileCheckerHttpResponseKeyEnum.CODE: ResponseCodeEnum.INTERNAL_SERVER_ERROR,
                FileCheckerHttpResponseKeyEnum.ERROR: "Internal server error",
            }
