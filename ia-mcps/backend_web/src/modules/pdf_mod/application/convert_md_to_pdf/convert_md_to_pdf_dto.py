"""DTO for converting a Markdown file to PDF."""

import os
from dataclasses import dataclass
from typing import Self


@dataclass(frozen=True, slots=True)
class ConvertMdToPdfDto:
    """Input parameters for the convert_md_to_pdf use case."""

    md_file_path: str
    output_pdf_path: str

    @classmethod
    def from_primitives(cls, primitives: dict) -> Self:
        md_file_path = str(primitives.get("md_file_path", "")).strip()
        # "el PDF se deja al lado del .md y con su mismo nombre" es una regla del
        # dominio, no de la fachada MCP: antes la calculaba el servidor MCP y por
        # eso no valía para ningún otro consumidor.
        output_pdf_path = str(primitives.get("output_pdf_path", "")).strip()
        if not output_pdf_path and md_file_path:
            output_pdf_path = f"{os.path.splitext(md_file_path)[0]}.pdf"

        return cls(
            md_file_path=md_file_path,
            output_pdf_path=output_pdf_path,
        )

    def __post_init__(self) -> None:
        if not self.md_file_path:
            raise ValueError("ConvertMdToPdfDto: md_file_path cannot be empty")
        if not self.output_pdf_path:
            raise ValueError("ConvertMdToPdfDto: output_pdf_path cannot be empty")
