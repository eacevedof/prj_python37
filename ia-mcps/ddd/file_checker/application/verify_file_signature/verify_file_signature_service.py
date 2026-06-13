import hashlib
from typing import Self, final

from ddd.file_checker.application.verify_file_signature.verify_file_signature_dto import VerifyFileSignatureDto
from ddd.file_checker.application.verify_file_signature.verify_file_signature_result_dto import VerifyFileSignatureResultDto
from ddd.file_checker.domain.enums import FileCheckerHashAlgorithmEnum
from ddd.file_checker.domain.exceptions.file_checker_exception import FileCheckerException
from ddd.file_checker.infrastructure.repositories.file_hash_reader_repository import FileHashReaderRepository


@final
class VerifyFileSignatureService:
    """Use case that verifies a downloaded file has not been tampered with."""

    _dto: VerifyFileSignatureDto
    _file_hash_reader: FileHashReaderRepository

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def __init__(self) -> None:
        self._file_hash_reader = FileHashReaderRepository.get_instance()

    def __call__(self, dto: VerifyFileSignatureDto) -> VerifyFileSignatureResultDto:
        """
        Computes the file hash and compares it against the expected value.

        Returns:
            VerifyFileSignatureResultDto: Result with is_valid flag and both hashes.

        Raises:
            FileCheckerException: If input is invalid or the file cannot be read.
        """
        self._dto = dto
        self._fail_if_wrong_input()

        actual_hash = self._file_hash_reader.get_hex_digest(
            file_path=self._dto.file_path,
            algorithm=self._dto.algorithm,
        )

        return VerifyFileSignatureResultDto.from_primitives({
            "is_valid": actual_hash == self._dto.expected_hash,
            "actual_hash": actual_hash,
            "expected_hash": self._dto.expected_hash,
            "algorithm": self._dto.algorithm,
            "file_path": self._dto.file_path,
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
