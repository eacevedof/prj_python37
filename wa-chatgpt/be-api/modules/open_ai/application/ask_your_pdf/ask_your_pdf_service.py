from typing import final
from dataclasses import dataclass

from application.ask_your_pdf.asked_to_pdf_dto import AskedYourPdfDto
from modules.shared.infrastructure.components.log import Log
from modules.shared.domain.enums.http_response_code_enum import HttpResponseCodeEnum

from modules.open_ai.domain.exceptions.ask_your_pdf_exception import AskYourPdfException
from modules.open_ai.application.ask_your_pdf.ask_your_pdf_dto import AskYourPdfDto
from modules.open_ai.application.ask_your_pdf.asked_to_pdf_dto import AskedYourPdfDto



@final
#@dataclass(frozen=True)
class AskYourPdfService:

    _ask_your_pdf_dto: AskYourPdfDto

    def invoke(self, ask_your_pdf_dto: AskYourPdfDto) -> AskedYourPdfDto:

        self._ask_your_pdf_dto = ask_your_pdf_dto
        self.__fail_if_wrong_input()

        message = ask_your_pdf_dto.question

        Log.log_debug(message, "ask_your_pdf_service.ask_your_pdf")
        return AskedYourPdfDto("ok")


    def __fail_if_wrong_input(self):
        if not self._ask_your_pdf_dto.question:
            raise AskYourPdfException(
                code=HttpResponseCodeEnum.BAD_REQUEST.value,
                message="ask_your_pdf_service.question-is-mandatory"
            )