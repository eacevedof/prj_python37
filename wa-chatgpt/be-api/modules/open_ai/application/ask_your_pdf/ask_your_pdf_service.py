from typing import final
from dataclasses import dataclass
from langchain_community.vectorstores import FAISS

from config.paths import PATH_UPLOAD_FOLDER
from modules.shared.infrastructure.components.log import Log
from modules.shared.infrastructure.components.files.filer import get_absolute_path, is_file
from modules.shared.domain.enums.http_response_code_enum import HttpResponseCodeEnum

from modules.open_ai.domain.exceptions.ask_your_pdf_exception import AskYourPdfException
from modules.open_ai.application.ask_your_pdf.ask_your_pdf_dto import AskYourPdfDto
from modules.open_ai.application.ask_your_pdf.asked_to_pdf_dto import AskedYourPdfDto

from modules.shared.infrastructure.components.files.pdf_reader import get_text_from_pdf_file
from modules.lang_chain.infrastructure.repositories.langchain_repository import LangchainRepository
from modules.lang_chain.infrastructure.repositories.knowledge_repository import KnowledgeRepository

@final
#@dataclass(frozen=True)
class AskYourPdfService:

    _ask_your_pdf_dto: AskYourPdfDto
    __fb_ai_search: FAISS

    @staticmethod
    def get_instance() -> "AskYourPdfService":
        return AskYourPdfService()

    def invoke(self, ask_your_pdf_dto: AskYourPdfDto) -> AskedYourPdfDto:
        self._ask_your_pdf_dto = ask_your_pdf_dto
        self.__fail_if_wrong_input()
        self.__load_knowledge_database()

        message = self.__get_response_from_chatgpt()
        Log.log_debug(message, "ask_your_pdf_service.ask_your_pdf")
        return AskedYourPdfDto.from_primitives(message)

    def __fail_if_wrong_input(self) -> None:
        if not self._ask_your_pdf_dto.question:
            raise AskYourPdfException(
                code=HttpResponseCodeEnum.BAD_REQUEST.value,
                message="ask_your_pdf_service.question-is-mandatory"
            )

    def __load_knowledge_database(self) -> None:
        pdf_file_name = "boe-constitucion-espanola.pdf"
        path_pdf_file = get_absolute_path(f"{PATH_UPLOAD_FOLDER}/{pdf_file_name}")
        if not is_file(path_pdf_file):
            raise FileNotFoundError(f"the file {path_pdf_file} does not exist.")

        pdf_text = get_text_from_pdf_file(path_pdf_file)
        self.__fb_ai_search = KnowledgeRepository.get_instance().get_faiss_obj_from_text(pdf_text)

    def __get_response_from_chatgpt(self) -> str:
        number_of_paragraphs = 50
        document_list = self.__fb_ai_search.similarity_search(
            self._ask_your_pdf_dto.question,
            number_of_paragraphs
        )
        return LangchainRepository.get_instance().get_response_using_chain(
            langchain_documents = document_list,
            question = self._ask_your_pdf_dto.question
        )
