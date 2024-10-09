from config.paths import PATH_UPLOAD_FOLDER

from typing import final
from dataclasses import dataclass

from modules.shared.infrastructure.components.log import Log
from modules.shared.domain.enums.http_response_code_enum import HttpResponseCodeEnum

from modules.open_ai.domain.exceptions.ask_your_pdf_exception import AskYourPdfException
from modules.open_ai.application.ask_your_pdf.ask_your_pdf_dto import AskYourPdfDto
from modules.open_ai.application.ask_your_pdf.asked_to_pdf_dto import AskedYourPdfDto

from modules.shared.infrastructure.components.files.pdf_reader import get_text_from_pdf_file
from modules.shared.infrastructure.components.ia.text.language import get_knowledge_base_from_text


@final
#@dataclass(frozen=True)
class AskYourPdfService:

    _ask_your_pdf_dto: AskYourPdfDto
    __knowledge_base: object

    def invoke(self, ask_your_pdf_dto: AskYourPdfDto) -> AskedYourPdfDto:

        self._ask_your_pdf_dto = ask_your_pdf_dto
        self.__fail_if_wrong_input()

        self.__load_knowledge_database()

        message = ask_your_pdf_dto.question

        Log.log_debug(message, "ask_your_pdf_service.ask_your_pdf")
        return AskedYourPdfDto("ok")


    def __fail_if_wrong_input(self) -> None:
        if not self._ask_your_pdf_dto.question:
            raise AskYourPdfException(
                code = HttpResponseCodeEnum.BAD_REQUEST.value,
                message = "ask_your_pdf_service.question-is-mandatory"
            )


    def __load_knowledge_database(self) -> None:
        pdf_file_name = "boe-constitucion-espanola.pdf"
        path_pdf_file = f"{PATH_UPLOAD_FOLDER}.{pdf_file_name}"

        pdf_text = get_text_from_pdf_file(path_pdf_file)
        self.__knowledge_base = get_knowledge_base_from_text(pdf_text)

    def __cal_open_ai(self) -> str:
        docs = self.__knowledge_base.similarity_search(self._ask_your_pdf_dto.question, 3)

