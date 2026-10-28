"""Result DTO for the convert_md_to_pdf use case."""

from dataclasses import dataclass
from typing import Any, Self

from src.modules.pdf_mod.domain.enums.pdf_result_key_enum import PdfResultKeyEnum


@dataclass(frozen=True, slots=True)
class ConvertMdToPdfResultDto:
    """Result of converting a Markdown file to PDF."""

    pdf_file_path: str
    pdf_size_bytes: int

    @classmethod
    def from_primitives(cls, primitives: dict) -> Self:
        pdf_file_path = str(primitives.get("pdf_file_path", ""))
        pdf_size_bytes = int(primitives.get("pdf_size_bytes", 0))

        return cls(
            pdf_file_path=pdf_file_path,
            pdf_size_bytes=pdf_size_bytes,
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            PdfResultKeyEnum.PDF_FILE_PATH: self.pdf_file_path,
            PdfResultKeyEnum.PDF_SIZE_BYTES: self.pdf_size_bytes,
        }
