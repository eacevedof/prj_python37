"""Repository: reads a Markdown file and writes it as PDF via weasyprint."""

import os
from typing import Self, final

import markdown
from weasyprint import HTML

from ddd.to_pdf.application.convert_md_to_pdf.convert_md_to_pdf_dto import ConvertMdToPdfDto
from ddd.to_pdf.application.convert_md_to_pdf.convert_md_to_pdf_result_dto import ConvertMdToPdfResultDto
from ddd.to_pdf.domain.exceptions.to_pdf_exception import ToPdfException
from ddd.to_pdf.infrastructure.repositories.abstract_to_pdf_file_repository import AbstractToPdfFileRepository

_CSS = """
body {
    font-family: Arial, sans-serif;
    font-size: 12px;
    line-height: 1.6;
    margin: 40px;
    color: #222;
}
h1 { font-size: 22px; border-bottom: 2px solid #333; padding-bottom: 4px; }
h2 { font-size: 17px; border-bottom: 1px solid #aaa; padding-bottom: 2px; margin-top: 24px; }
h3 { font-size: 14px; margin-top: 18px; }
pre {
    background: #f5f5f5;
    border: 1px solid #ddd;
    border-radius: 4px;
    padding: 10px;
    font-size: 10px;
    overflow-wrap: break-word;
    white-space: pre-wrap;
}
code { background: #f5f5f5; padding: 1px 4px; font-size: 10px; }
table { border-collapse: collapse; width: 100%; margin: 12px 0; }
th, td { border: 1px solid #ccc; padding: 6px 10px; text-align: left; }
th { background: #eee; font-weight: bold; }
blockquote { border-left: 3px solid #aaa; margin: 8px 0; padding: 4px 12px; color: #555; }
hr { border: none; border-top: 1px solid #ccc; margin: 16px 0; }
"""


@final
class MdToPdfWriterFileRepository(AbstractToPdfFileRepository):
    _instance: "MdToPdfWriterFileRepository | None" = None

    @classmethod
    def get_instance(cls) -> Self:
        if cls._instance is None:
            cls._instance = cls()
        return cls._instance

    def __call__(self, convert_md_to_pdf_dto: ConvertMdToPdfDto) -> ConvertMdToPdfResultDto:
        self._logger.info(f"MdToPdfWriterFileRepository: converting {convert_md_to_pdf_dto.md_file_path}")

        md_content = self._read_md_file(convert_md_to_pdf_dto.md_file_path)
        html_body = markdown.markdown(
            md_content,
            extensions=["tables", "fenced_code", "codehilite"],
        )
        html_document = f"<html><head><style>{_CSS}</style></head><body>{html_body}</body></html>"

        output_directory = os.path.dirname(convert_md_to_pdf_dto.output_pdf_path)
        if output_directory:
            os.makedirs(output_directory, exist_ok=True)

        HTML(string=html_document).write_pdf(convert_md_to_pdf_dto.output_pdf_path)

        pdf_size_bytes = os.path.getsize(convert_md_to_pdf_dto.output_pdf_path)
        self._logger.info(
            f"MdToPdfWriterFileRepository: PDF written to {convert_md_to_pdf_dto.output_pdf_path} "
            f"({pdf_size_bytes} bytes)"
        )

        return ConvertMdToPdfResultDto.from_primitives({
            "pdf_file_path": convert_md_to_pdf_dto.output_pdf_path,
            "pdf_size_bytes": pdf_size_bytes,
        })

    def _read_md_file(self, md_file_path: str) -> str:
        try:
            with open(md_file_path, encoding="utf-8") as md_file:
                return md_file.read()
        except OSError as os_error:
            ToPdfException.unexpected_custom(f"Cannot read markdown file: {os_error}")
