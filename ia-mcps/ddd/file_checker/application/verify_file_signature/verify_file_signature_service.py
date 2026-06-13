import hashlib
from typing import Self, final

from ddd.file_checker.application.verify_file_signature.verify_file_signature_dto import VerifyFileSignatureDto
from ddd.file_checker.application.verify_file_signature.verify_file_signature_result_dto import VerifyFileSignatureResultDto
from ddd.file_checker.domain.enums import (
    FileCheckerHashAlgorithmEnum,
    FileCheckerResponseKeyEnum,
)
from ddd.file_checker.domain.exceptions.file_checker_exception import FileCheckerException
from ddd.file_checker.infrastructure.repositories.file_hash_reader_file_repository import FileHashReaderFileRepository


@final
class VerifyFileSignatureService:
    """Use case that verifies a downloaded file has not been tampered with."""

    _dto: VerifyFileSignatureDto
    _file_hash_reader_file_repository: FileHashReaderFileRepository

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def __init__(self) -> None:
        self._file_hash_reader_file_repository = FileHashReaderFileRepository.get_instance()

    def __call__(self, dto: VerifyFileSignatureDto) -> VerifyFileSignatureResultDto:
        """Verify that a downloaded file has not been tampered with.

        Args:
            dto: Input DTO with file_path, expected_hash, and algorithm.

        Returns:
            VerifyFileSignatureResultDto: Contains is_valid flag and computed hash.

        Raises:
            FileCheckerException: On invalid algorithm, malformed hash, file not found, or I/O error.
        """
        self._dto = dto
        self._fail_if_wrong_input()

        actual_hash = self._file_hash_reader_file_repository.get_hex_digest(
            file_path=self._dto.file_path,
            algorithm=self._dto.algorithm,
        )

        return VerifyFileSignatureResultDto.from_primitives({
            FileCheckerResponseKeyEnum.IS_VALID: actual_hash == self._dto.expected_hash,
            FileCheckerResponseKeyEnum.ACTUAL_HASH: actual_hash,
            FileCheckerResponseKeyEnum.EXPECTED_HASH: self._dto.expected_hash,
            FileCheckerResponseKeyEnum.ALGORITHM: self._dto.algorithm,
            FileCheckerResponseKeyEnum.FILE_PATH: self._dto.file_path,
        })

    def _fail_if_wrong_input(self) -> None:
        valid_algorithms = list(FileCheckerHashAlgorithmEnum)
        if self._dto.algorithm not in valid_algorithms:
            FileCheckerException.bad_request_custom(
                f"Invalid algorithm: '{self._dto.algorithm}'. "
                f"Allowed values: {', '.join(valid_algorithms)}"
            )

        expected_length = self._expected_hex_length(self._dto.algorithm)
        if len(self._dto.expected_hash) != expected_length:
            FileCheckerException.bad_request_custom(
                f"expected_hash has wrong length for {self._dto.algorithm}: "
                f"got {len(self._dto.expected_hash)}, expected {expected_length} hex chars"
            )

        if not all(c in "0123456789abcdef" for c in self._dto.expected_hash):
            FileCheckerException.bad_request_custom(
                "expected_hash must contain only lowercase hexadecimal characters (0-9, a-f)"
            )

    @staticmethod
    def _expected_hex_length(algorithm: str) -> int:
        # digest_size is in bytes; hex encoding doubles it
        return hashlib.new(algorithm).digest_size * 2
