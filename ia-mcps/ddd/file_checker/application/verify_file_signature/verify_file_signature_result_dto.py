from dataclasses import dataclass
from typing import Any, Self

from ddd.file_checker.domain.enums import (
    FileCheckerResponseKeyEnum,
)


@dataclass(frozen=True, slots=True)
class VerifyFileSignatureResultDto:
    """Result DTO returned by VerifyFileSignatureService.

    Immutable container for file verification results. Access fields directly.

    Attributes:
        file_path: Local path to the file (may be temp if sourced from URL).
        file_size: File size in bytes.
        last_modified: ISO 8601 datetime string.
        source: "local" or "url".
        hash_value: Computed hash in lowercase hex.
        algorithm: Hash algorithm used.
        executable_format: "pe" | "elf" | "macho" | None.
        executable_version: Version string | None.
        executable_description: File description | None.
        executable_product_name: Product name | None.
        executable_company: Company name | None.
        signature_status: "valid" | "unsigned" | "bad_signature" | "no_key" | "unknown" | None.
        signature_method: "authenticode" | "gpg" | "codesign" | None.
        signature_signer: Signer name | None.
    """

    file_path: str
    file_size: int
    last_modified: str
    source: str
    hash_value: str
    algorithm: str
    executable_format: str | None
    executable_version: str | None
    executable_description: str | None
    executable_product_name: str | None
    executable_company: str | None
    signature_status: str | None
    signature_method: str | None
    signature_signer: str | None

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        """Construct from service computation result."""
        return cls(
            file_path=str(primitives.get(FileCheckerResponseKeyEnum.FILE_PATH, "")),
            file_size=int(primitives.get(FileCheckerResponseKeyEnum.FILE_SIZE, 0)),
            last_modified=str(primitives.get(FileCheckerResponseKeyEnum.LAST_MODIFIED, "")),
            source=str(primitives.get(FileCheckerResponseKeyEnum.SOURCE, "")),
            hash_value=str(primitives.get(FileCheckerResponseKeyEnum.HASH_VALUE, "")),
            algorithm=str(primitives.get(FileCheckerResponseKeyEnum.ALGORITHM, "")),
            executable_format=primitives.get(FileCheckerResponseKeyEnum.EXECUTABLE_FORMAT),
            executable_version=primitives.get(FileCheckerResponseKeyEnum.EXECUTABLE_VERSION),
            executable_description=primitives.get(FileCheckerResponseKeyEnum.EXECUTABLE_DESCRIPTION),
            executable_product_name=primitives.get(FileCheckerResponseKeyEnum.EXECUTABLE_PRODUCT_NAME),
            executable_company=primitives.get(FileCheckerResponseKeyEnum.EXECUTABLE_COMPANY),
            signature_status=primitives.get(FileCheckerResponseKeyEnum.SIGNATURE_STATUS),
            signature_method=primitives.get(FileCheckerResponseKeyEnum.SIGNATURE_METHOD),
            signature_signer=primitives.get(FileCheckerResponseKeyEnum.SIGNATURE_SIGNER),
        )

    def to_dict(self) -> dict[str, Any]:
        """Serialize to dict for JSON response or template rendering."""
        return {
            FileCheckerResponseKeyEnum.FILE_PATH: self.file_path,
            FileCheckerResponseKeyEnum.FILE_SIZE: self.file_size,
            FileCheckerResponseKeyEnum.LAST_MODIFIED: self.last_modified,
            FileCheckerResponseKeyEnum.SOURCE: self.source,
            FileCheckerResponseKeyEnum.HASH_VALUE: self.hash_value,
            FileCheckerResponseKeyEnum.ALGORITHM: self.algorithm,
            FileCheckerResponseKeyEnum.EXECUTABLE_FORMAT: self.executable_format,
            FileCheckerResponseKeyEnum.EXECUTABLE_VERSION: self.executable_version,
            FileCheckerResponseKeyEnum.EXECUTABLE_DESCRIPTION: self.executable_description,
            FileCheckerResponseKeyEnum.EXECUTABLE_PRODUCT_NAME: self.executable_product_name,
            FileCheckerResponseKeyEnum.EXECUTABLE_COMPANY: self.executable_company,
            FileCheckerResponseKeyEnum.SIGNATURE_STATUS: self.signature_status,
            FileCheckerResponseKeyEnum.SIGNATURE_METHOD: self.signature_method,
            FileCheckerResponseKeyEnum.SIGNATURE_SIGNER: self.signature_signer,
        }

    def to_primitives(self) -> dict[str, Any]:
        """Alias for to_dict() — serialize to primitives dict."""
        return self.to_dict()
