"""Result DTO for the convert_md_to_pdf use case."""

from dataclasses import dataclass
from typing import Self


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
