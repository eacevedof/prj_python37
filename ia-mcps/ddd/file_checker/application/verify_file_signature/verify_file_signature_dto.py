from dataclasses import dataclass
from typing import Any, Self

from ddd.file_checker.domain.enums import (
    FileCheckerHashAlgorithmEnum,
    FileCheckerRequestKeyEnum,
)


@dataclass(frozen=True, slots=True)
class VerifyFileSignatureDto:
    """Input DTO for file signature verification.

    Immutable container for request data. Access fields directly.

    Attributes:
        file_path_or_url: Path to local file or URL to download.
        algorithm: Hash algorithm name (default: sha256).
    """

    file_path_or_url: str
    algorithm: str = FileCheckerHashAlgorithmEnum.SHA256

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        """Construct from external data (request, user input, etc).

        Responsibility: Type casting and basic cleaning (trim, lowercase).
        NOT: Business validation (VerifyFileSignatureService handles that).

        Args:
            primitives: Dict with file_path_or_url, algorithm keys.

        Returns:
            VerifyFileSignatureDto instance.
        """
        return cls(
            file_path_or_url=str(
                primitives.get(FileCheckerRequestKeyEnum.FILE_PATH_OR_URL, "")
            ).strip(),
            algorithm=str(primitives.get(
                FileCheckerRequestKeyEnum.ALGORITHM,
                FileCheckerHashAlgorithmEnum.SHA256.value)
            ).strip().lower(),
        )
