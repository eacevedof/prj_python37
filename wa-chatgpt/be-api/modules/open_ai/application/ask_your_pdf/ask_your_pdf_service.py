from typing import final
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
from modules.lang_chain.infrastructure.repositories.embeddings_repository import EmbeddingsRepository
from modules.pine_cone.infrastructure.repositories.pinecone_repository import PineconeRepository

@final
class AskYourPdfService:

    _ask_your_pdf_dto: AskYourPdfDto
    __fb_ai_search: FAISS
    __pdf_chunks: list[str]

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

        #
        # pdf_text = get_text_from_pdf_file(path_pdf_file)
        # pdf_chunks_documents = EmbeddingsRepository.get_instance().get_chunks_as_documents(pdf_text)
        # cardinality = len(pdf_chunks_documents)
        # Log.log_debug(f"pdf_embeddings cardinality: {cardinality}", "__load_knowledge_database")
        # hf_embeddings = EmbeddingsRepository.get_instance().get_embeddings_obj_by_mpnet_base_v2()
        # EmbeddingsRepository.get_instance().insert_chunks_in_pinecone(pdf_chunks_documents, hf_embeddings)


    def __get_response_from_chatgpt(self) -> str:
        hf_embeddings = EmbeddingsRepository.get_instance().get_embeddings_obj_by_mpnet_base_v2()

        vstorage = EmbeddingsRepository.get_instance().get_vector_storage_from_pdf_index(
            hf_embeddings=hf_embeddings
        )
        number_of_paragraphs = 20
        search_result = vstorage.similarity_search(
            query=self._ask_your_pdf_dto.question,
            k=number_of_paragraphs
        )


        #prompt_vectors = KnowledgeRepository.get_instance().get_prompt_as_vectors(
        #    self._ask_your_pdf_dto.question
        #)
        #prompt_size = len(prompt_vectors)
        #Log.log_debug(f"prompt_size: {prompt_size}", "__get_response_from_chatgpt")

        # number_of_paragraphs = 50
        # documents = self.__fb_ai_search.similarity_search(
        #     query = self._ask_your_pdf_dto.question,
        #     k = number_of_paragraphs
        # )
        # documents = EmbeddingsRepository.get_instance().get_documents_by_user_question(
        #     user_question = self._ask_your_pdf_dto.question
        # )

        # para las respuestas raras hay q revisar:
        # https://api.python.langchain.com/en/latest/chains/langchain.chains.combine_documents.stuff.create_stuff_documents_chain.html
        return LangchainRepository.get_instance().get_response_using_chain(
            docs_context = search_result,
            question = self._ask_your_pdf_dto.question
        )
