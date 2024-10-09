from config.paths import PATH_UPLOAD_FOLDER

from typing import final
from dataclasses import dataclass

from langchain.vectorstores import FAISS
from modules.shared.infrastructure.components.log import Log
from modules.shared.infrastructure.components.files.filer import get_absolute_path, is_file
from modules.shared.domain.enums.http_response_code_enum import HttpResponseCodeEnum

from modules.open_ai.domain.exceptions.ask_your_pdf_exception import AskYourPdfException
from modules.open_ai.application.ask_your_pdf.ask_your_pdf_dto import AskYourPdfDto
from modules.open_ai.application.ask_your_pdf.asked_to_pdf_dto import AskedYourPdfDto

from modules.shared.infrastructure.components.files.pdf_reader import get_text_from_pdf_file
from modules.shared.infrastructure.components.ia.text.language import get_knowledge_base_from_text
from modules.open_ai.infrastructure.repositories.openai_repository import get_response_using_chain

@final
#@dataclass(frozen=True)
class AskYourPdfService:

    _ask_your_pdf_dto: AskYourPdfDto
    __knowledge_base: FAISS

    @staticmethod
    def get_instance() -> "AskYourPdfService":
        return AskYourPdfService()

    def invoke(self, ask_your_pdf_dto: AskYourPdfDto) -> AskedYourPdfDto:

        self._ask_your_pdf_dto = ask_your_pdf_dto
        self.__fail_if_wrong_input()

        self.__load_knowledge_database()

        message = self.__get_response_from_chatgpt()

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
        path_pdf_file = get_absolute_path(f"{PATH_UPLOAD_FOLDER}/{pdf_file_name}")
        if not is_file(path_pdf_file):
            raise FileNotFoundError(f"the file {path_pdf_file} does not exist.")

        pdf_text = get_text_from_pdf_file(path_pdf_file)
        self.__knowledge_base = get_knowledge_base_from_text(pdf_text)


    def __get_response_from_chatgpt(self) -> str:
        number_of_paragraphs = 3
        docs = self.__knowledge_base.similarity_search(
            self._ask_your_pdf_dto.question,
            number_of_paragraphs
        )
        return get_response_using_chain(docs, self._ask_your_pdf_dto.question)

