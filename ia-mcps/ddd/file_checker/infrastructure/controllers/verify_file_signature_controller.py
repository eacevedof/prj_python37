"""HTTP/MCP controller for file signature verification."""

from typing import final

from ddd.file_checker.application import VerifyFileSignatureDto, VerifyFileSignatureService
from ddd.file_checker.domain.enums import (
    FileCheckerHashAlgorithmEnum,
    FileCheckerRequestKeyEnum,
    FileCheckerHttpResponseKeyEnum,
)
from ddd.file_checker.domain.exceptions.file_checker_exception import FileCheckerException
from ddd.shared.domain.enums.response_code_enum import ResponseCodeEnum
from ddd.shared.infrastructure.components.logger import Logger


@final
class VerifyFileSignatureController:
    """Controller that exposes the VerifyFileSignature use case to MCP/HTTP.

    Instance variables use full semantic names for clarity and maintainability.
    Declared in order: shared components first, then module-specific services.
    """

    _logger: Logger
    _verify_file_signature_service: VerifyFileSignatureService

    @classmethod
    def get_instance(cls) -> "VerifyFileSignatureController":
        return cls()

    def __init__(self) -> None:
        """Wire dependencies with full semantic names."""
        self._logger = Logger.get_instance()
        self._verify_file_signature_service = VerifyFileSignatureService.get_instance()

    def invoke(
        self,
        file_path: str,
        expected_hash: str,
        algorithm: str = FileCheckerHashAlgorithmEnum.SHA256,
    ) -> dict:
        """Handle file signature verification request.

        Builds DTO → calls service → serializes result.
        Uses semantic names for all variables (not generic 'dto' or 'result').

        Args:
            file_path: Path to the file to verify.
            expected_hash: Known hash to compare against.
            algorithm: Hash algorithm (md5, sha1, sha256, sha512).

        Returns:
            dict: Response with is_valid, actual_hash, expected_hash, algorithm, file_path.
                  On success: HTTP 200 with full result.
                  On client error: HTTP 4xx with error message.
                  On server error: HTTP 5xx with error message.

        Example (console usage):
            ```python
            # Import the controller
            from ddd.file_checker.infrastructure.controllers import VerifyFileSignatureController

            # Create instance
            controller = VerifyFileSignatureController.get_instance()

            # Verify a downloaded file against its known SHA256 hash
            response = controller.invoke(
                file_path="/path/to/downloaded/file.zip",
                expected_hash="e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
                algorithm="sha256"
            )

            # Response on success:
            # {
            #     "code": 200,
            #     "data": {
            #         "is_valid": True,
            #         "actual_hash": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
            #         "expected_hash": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
            #         "algorithm": "sha256",
            #         "file_path": "/path/to/downloaded/file.zip"
            #     }
            # }

            # Response on tampering detection:
            # {
            #     "code": 200,
            #     "data": {
            #         "is_valid": False,  # ← File was modified!
            #         "actual_hash": "different_hash_value...",
            #         "expected_hash": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
            #         "algorithm": "sha256",
            #         "file_path": "/path/to/downloaded/file.zip"
            #     }
            # }
            ```
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
