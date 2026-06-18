"""Use case: convert a Markdown file to PDF."""

import os
from typing import Self, final

from ddd.to_pdf.application.convert_md_to_pdf.convert_md_to_pdf_dto import ConvertMdToPdfDto
from ddd.to_pdf.application.convert_md_to_pdf.convert_md_to_pdf_result_dto import ConvertMdToPdfResultDto
from ddd.to_pdf.domain.exceptions.to_pdf_exception import ToPdfException
from ddd.to_pdf.infrastructure.repositories.md_to_pdf_writer_file_repository import MdToPdfWriterFileRepository


@final
class ConvertMdToPdfService:
    _convert_md_to_pdf_dto: ConvertMdToPdfDto
    _md_to_pdf_repository: MdToPdfWriterFileRepository

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def __init__(self) -> None:
        self._md_to_pdf_repository = MdToPdfWriterFileRepository.get_instance()

    def __call__(self, convert_md_to_pdf_dto: ConvertMdToPdfDto) -> ConvertMdToPdfResultDto:
        self._convert_md_to_pdf_dto = convert_md_to_pdf_dto
        self._fail_if_wrong_input()
        return self._md_to_pdf_repository(self._convert_md_to_pdf_dto)

    def _fail_if_wrong_input(self) -> None:
        if not os.path.isfile(self._convert_md_to_pdf_dto.md_file_path):
            ToPdfException.bad_request_custom(
                f"Markdown file not found: {self._convert_md_to_pdf_dto.md_file_path}"
            )
