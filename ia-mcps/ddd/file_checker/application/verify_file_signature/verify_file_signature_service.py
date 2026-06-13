import os
from typing import Self, final

from ddd.file_checker.application.verify_file_signature.verify_file_signature_dto import VerifyFileSignatureDto
from ddd.file_checker.application.verify_file_signature.verify_file_signature_result_dto import VerifyFileSignatureResultDto
from ddd.file_checker.domain.enums import (
    FileCheckerHashAlgorithmEnum,
    FileCheckerResponseKeyEnum,
)
from ddd.file_checker.infrastructure.repositories.file_downloader_reader_url_repository import FileDownloaderReaderUrlRepository
from ddd.file_checker.infrastructure.repositories.file_metadata_reader_file_repository import FileMetadataReaderFileRepository
from ddd.file_checker.infrastructure.repositories.file_hash_reader_file_repository import FileHashReaderFileRepository
from ddd.file_checker.infrastructure.repositories.file_executable_reader_file_repository import FileExecutableReaderFileRepository
from ddd.file_checker.infrastructure.repositories.file_signature_reader_file_repository import FileSignatureReaderFileRepository
from ddd.file_checker.domain.exceptions.file_checker_exception import FileCheckerException


@final
class VerifyFileSignatureService:
    """Use case that verifies file integrity, extracts metadata, and checks signatures."""

    _verify_file_signature_dto: VerifyFileSignatureDto
    _file_downloader_reader_url_repository: FileDownloaderReaderUrlRepository
    _file_metadata_reader_file_repository: FileMetadataReaderFileRepository
    _file_hash_reader_file_repository: FileHashReaderFileRepository
    _file_executable_reader_file_repository: FileExecutableReaderFileRepository
    _file_signature_reader_file_repository: FileSignatureReaderFileRepository

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def __init__(self) -> None:
        self._file_downloader_reader_url_repository = FileDownloaderReaderUrlRepository.get_instance()
        self._file_metadata_reader_file_repository = FileMetadataReaderFileRepository.get_instance()
        self._file_hash_reader_file_repository = FileHashReaderFileRepository.get_instance()
        self._file_executable_reader_file_repository = FileExecutableReaderFileRepository.get_instance()
        self._file_signature_reader_file_repository = FileSignatureReaderFileRepository.get_instance()

    def __call__(
        self,
        verify_file_signature_dto: VerifyFileSignatureDto
    ) -> VerifyFileSignatureResultDto:
        """Verify file: download if URL, extract metadata, hash, executable info, signature.

        Args:
            verify_file_signature_dto: Input DTO with file_path_or_url and algorithm.

        Returns:
            VerifyFileSignatureResultDto with all verification data.

        Raises:
            FileCheckerException: On invalid algorithm or empty input (4xx).
            OSError, urllib.error: On I/O or download failures (propagates to controller → 5xx).
        """
        self._verify_file_signature_dto = verify_file_signature_dto
        self._fail_if_wrong_input()

        file_path_or_url = verify_file_signature_dto.file_path_or_url
        is_url = file_path_or_url.startswith("http://") or file_path_or_url.startswith("https://")

        if is_url:
            local_path = self._file_downloader_reader_url_repository.download(
                file_path_or_url
            )
            source = "url"
        else:
            local_path = file_path_or_url
            source = "local"
            if not os.path.exists(local_path):
                FileCheckerException.bad_request_custom(
                    f"VerifyFileSignatureService: file not found: {local_path}"
                )
            if not os.path.isfile(local_path):
                FileCheckerException.bad_request_custom(
                    f"VerifyFileSignatureService: path is not a file: {local_path}"
                )

        metadata = self._file_metadata_reader_file_repository.get_metadata(local_path)
        hash_value = self._file_hash_reader_file_repository.get_hex_digest(
            file_path=local_path,
            algorithm=verify_file_signature_dto.algorithm,
        )
        executable_info = self._file_executable_reader_file_repository.get_executable_info(local_path)
        signature_info = self._file_signature_reader_file_repository.get_signature_info(local_path)

        return VerifyFileSignatureResultDto.from_primitives({
            FileCheckerResponseKeyEnum.FILE_PATH: local_path,
            FileCheckerResponseKeyEnum.FILE_SIZE: metadata[FileCheckerResponseKeyEnum.FILE_SIZE],
            FileCheckerResponseKeyEnum.LAST_MODIFIED: metadata[FileCheckerResponseKeyEnum.LAST_MODIFIED],
            FileCheckerResponseKeyEnum.SOURCE: source,
            FileCheckerResponseKeyEnum.HASH_VALUE: hash_value,
            FileCheckerResponseKeyEnum.ALGORITHM: verify_file_signature_dto.algorithm,
            FileCheckerResponseKeyEnum.EXECUTABLE_FORMAT: executable_info[FileCheckerResponseKeyEnum.EXECUTABLE_FORMAT],
            FileCheckerResponseKeyEnum.EXECUTABLE_VERSION: executable_info[FileCheckerResponseKeyEnum.EXECUTABLE_VERSION],
            FileCheckerResponseKeyEnum.EXECUTABLE_DESCRIPTION: executable_info[FileCheckerResponseKeyEnum.EXECUTABLE_DESCRIPTION],
            FileCheckerResponseKeyEnum.EXECUTABLE_PRODUCT_NAME: executable_info[FileCheckerResponseKeyEnum.EXECUTABLE_PRODUCT_NAME],
            FileCheckerResponseKeyEnum.EXECUTABLE_COMPANY: executable_info[FileCheckerResponseKeyEnum.EXECUTABLE_COMPANY],
            FileCheckerResponseKeyEnum.SIGNATURE_STATUS: signature_info[FileCheckerResponseKeyEnum.SIGNATURE_STATUS],
            FileCheckerResponseKeyEnum.SIGNATURE_METHOD: signature_info[FileCheckerResponseKeyEnum.SIGNATURE_METHOD],
            FileCheckerResponseKeyEnum.SIGNATURE_SIGNER: signature_info[FileCheckerResponseKeyEnum.SIGNATURE_SIGNER],
        })

    def _fail_if_wrong_input(self) -> None:
        if not self._verify_file_signature_dto.file_path_or_url.strip():
            FileCheckerException.bad_request_custom(
                "file_path_or_url cannot be empty"
            )

        valid_algorithms = list(FileCheckerHashAlgorithmEnum)
        if self._verify_file_signature_dto.algorithm not in valid_algorithms:
            FileCheckerException.bad_request_custom(
                f"Invalid algorithm: '{self._verify_file_signature_dto.algorithm}'. "
                f"Allowed values: {', '.join(valid_algorithms)}"
            )
