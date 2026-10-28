"""Servicio para iniciar sesión de slider (presentación auto-reproducida)."""

import random
from typing import final, Self

from ddd.vocabulary.application.start_word_slider_session.start_word_slider_session_dto import (
    StartWordSliderSessionDto,
)
from ddd.vocabulary.application.start_word_slider_session.start_word_slider_session_result_dto import (
    StartWordSliderSessionResultDto,
)
from ddd.vocabulary.domain.entities import StudySessionEntity
from ddd.vocabulary.domain.enums import StudyModeEnum
from ddd.vocabulary.domain.exceptions import VocabularyException
from ddd.vocabulary.infrastructure.repositories import (
    MetricsReaderSqliteRepository,
    SessionsWriterSqliteRepository,
)


@final
class StartWordSliderSessionService:
    """Servicio para iniciar una sesión de slider."""

    __start_word_slider_session_dto: StartWordSliderSessionDto
    _metrics_reader_sqlite_repository: MetricsReaderSqliteRepository
    _sessions_writer_sqlite_repository: SessionsWriterSqliteRepository

    def __init__(self) -> None:
        self._metrics_reader_sqlite_repository = (
            MetricsReaderSqliteRepository.get_instance()
        )
        self._sessions_writer_sqlite_repository = (
            SessionsWriterSqliteRepository.get_instance()
        )

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(
        self, start_word_slider_session_dto: StartWordSliderSessionDto
    ) -> StartWordSliderSessionResultDto:
        """
        Inicia una nueva sesión de slider.

        Args:
            start_word_slider_session_dto: Configuración de la sesión.

        Returns:
            StartWordSliderSessionResultDto con la sesión y palabras a presentar.

        Raises:
            VocabularyException: Si no hay palabras disponibles.
        """
        self.__start_word_slider_session_dto = start_word_slider_session_dto

        # Validar
        errors = start_word_slider_session_dto.validate()
        if errors:
            VocabularyException.word_creation_failed(", ".join(errors))

        # Obtener palabras para repaso (SM-2): prioriza palabras/frases complicadas.
        # Incluye imagen principal (opcional) para mostrarla en el slider.
        words_data = await self._metrics_reader_sqlite_repository.get_words_for_slider(
            lang_code=start_word_slider_session_dto.lang_code,
            tag_names=start_word_slider_session_dto.tags
            if start_word_slider_session_dto.tags
            else None,
            group_id=start_word_slider_session_dto.group_id,
            limit=start_word_slider_session_dto.limit,
        )

        if not words_data:
            VocabularyException.no_words_for_slider(
                start_word_slider_session_dto.lang_code
            )

        # Bloques palabra madre + sus frases de ejemplo (relación EXAMPLE):
        # cada frase va justo detrás de su palabra madre.
        word_blocks = self._build_word_blocks(words_data)

        # El Aprendizaje reproduce SIEMPRE el grupo entero (limit alto), así que
        # la priorización SM-2 de la consulta solo decidía el orden, y su último
        # criterio de desempate es RANDOM(): el diálogo salía descolocado. Aquí
        # se fija el orden de presentación, y el azar queda donde se pide:
        # - switch «Orden aleatorio»: baraja bloques enteros
        # - por defecto: secuencial por id, el orden lógico con el que se creó
        #   el grupo (el diálogo del pasaporte va del 716 al 739)
        if start_word_slider_session_dto.is_random_order:
            random.shuffle(word_blocks)
        else:
            word_blocks.sort(key=lambda word_block: int(word_block[0]["word_es_id"]))

        words_data = [word for block in word_blocks for word in block]

        # Crear sesión
        session_id = await self._sessions_writer_sqlite_repository.create_study_session(
            StudySessionEntity.from_primitives(
                {
                    "id": 0,
                    "lang_code": start_word_slider_session_dto.lang_code,
                    "study_mode": StudyModeEnum.SLIDER.value,
                    "tags_filter": start_word_slider_session_dto.tags
                    if start_word_slider_session_dto.tags
                    else [],
                }
            )
        )

        # Construir resultado
        return StartWordSliderSessionResultDto.from_primitives(
            {
                "session_id": session_id,
                "lang_code": start_word_slider_session_dto.lang_code,
                "study_mode": StudyModeEnum.SLIDER.value,
                "started_at": "",
                "words": words_data,
                "tags_filter": start_word_slider_session_dto.tags,
            }
        )

    @staticmethod
    def _build_word_blocks(words_data: list[dict]) -> list[list[dict]]:
        """
        Agrupa las palabras en bloques [madre, frase1, frase2, ...].

        Una fila con parent_word_es_id es una frase de ejemplo: se cuelga de su
        palabra madre si está en el resultado; si no (filtro de tags, límite),
        forma bloque propio en su posición. Las frases se ordenan por id
        (orden de creación en la migración), igual que los bloques entre sí
        cuando no se pide orden aleatorio.
        """
        fetched_ids = {word["word_es_id"] for word in words_data}
        sentences_by_parent: dict[int, list[dict]] = {}
        blocks: list[list[dict]] = []

        for word in words_data:
            parent_id = word.get("parent_word_es_id")
            if parent_id is not None and parent_id in fetched_ids:
                sentences_by_parent.setdefault(parent_id, []).append(word)

        for word in words_data:
            parent_id = word.get("parent_word_es_id")
            if parent_id is not None and parent_id in fetched_ids:
                continue
            sentences = sorted(
                sentences_by_parent.get(word["word_es_id"], []),
                key=lambda sentence: sentence["word_es_id"],
            )
            blocks.append([word, *sentences])

        return blocks
