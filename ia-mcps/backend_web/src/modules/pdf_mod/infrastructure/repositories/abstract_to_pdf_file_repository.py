"""Abstract base repository for file-based PDF conversion."""

from abc import ABC, abstractmethod

from src.modules.shared.infrastructure.components.logger.logger import Logger
from src.modules.pdf_mod.application.convert_md_to_pdf.convert_md_to_pdf_dto import ConvertMdToPdfDto
from src.modules.pdf_mod.application.convert_md_to_pdf.convert_md_to_pdf_result_dto import ConvertMdToPdfResultDto


class AbstractToPdfFileRepository(ABC):
    """Abstract base for all file-based PDF conversion repositories."""

    def __init__(self) -> None:
        self._logger = Logger.get_instance()

    @abstractmethod
    def __call__(self, convert_md_to_pdf_dto: ConvertMdToPdfDto) -> ConvertMdToPdfResultDto:
        pass
