from typing import final

from config.paths import PATH_UPLOAD_FOLDER
from modules.shared.infrastructure.components.log import Log
from modules.shared.infrastructure.components.files.filer import get_absolute_path, is_file
from modules.shared.domain.enums.http_response_code_enum import HttpResponseCodeEnum

from modules.open_ai.domain.exceptions.ask_your_pdf_exception import AskYourPdfException
from modules.open_ai.application.ask_your_pdf.ask_your_pdf_dto import AskYourPdfDto
from modules.open_ai.application.ask_your_pdf.asked_to_pdf_dto import AskedYourPdfDto

from modules.shared.infrastructure.components.files.pdf_reader import get_text_from_pdf_file
from modules.rag.infrastructure.repositories.rag_repository import RagRepository
from modules.rag.infrastructure.repositories.embeddings_repository import EmbeddingsRepository
from modules.pine_cone.infrastructure.repositories.pinecone_repository import PineconeRepository

@final
class AskYourPdfService:

    _ask_your_pdf_dto: AskYourPdfDto

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

        # Reindexar el PDF (se deja comentado: solo hace falta al cambiar de documento)
        # pdf_text = get_text_from_pdf_file(path_pdf_file)
        # chunks = EmbeddingsRepository.get_instance().get_chunks_from_text(pdf_text)
        # Log.log_debug(f"pdf chunks: {len(chunks)}", "__load_knowledge_database")
        # vectors = EmbeddingsRepository.get_instance().get_chunks_as_pinecone_vectors(chunks)
        # PineconeRepository.get_instance().upsert_pdf_index(vectors)


    def __get_response_from_chatgpt(self) -> str:
        question = self._ask_your_pdf_dto.question
        question_vector = EmbeddingsRepository.get_instance().embed_query(question)

        number_of_paragraphs = 20
        context_chunks = PineconeRepository.get_instance().search_by_vector(
            vector=question_vector,
            top_k=number_of_paragraphs
        )

        return RagRepository.get_instance().get_response_from_context(
            context_chunks=context_chunks,
            question=question
        )
