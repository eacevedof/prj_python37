"""Repositorio de escritura para traducciones."""

from datetime import datetime
from typing import final, Self

from ddd.shared.infrastructure.repositories import AbstractSqliteRepository
from ddd.vocabulary.domain.entities import WordLangEntity


@final
class WordsLangWriterSqliteRepository(AbstractSqliteRepository):
    """Repositorio de escritura para traducciones."""

    def __init__(self) -> None:
        super().__init__()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def create(self, word_lang_entity: WordLangEntity) -> int:
        """Crea una nueva traducción y retorna el ID generado."""
        now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

        return await self._insert_into("words_lang", {
            "word_es_id": word_lang_entity.word_es_id,
            "lang_code": word_lang_entity.lang_code,
            "text": word_lang_entity.text.strip(),
            "pronunciation": word_lang_entity.pronunciation,
            "audio_path": word_lang_entity.audio_path,
            "notes": word_lang_entity.notes,
            "created_at": now,
            "updated_at": now,
        })

    async def update(self, word_lang_entity: WordLangEntity) -> bool:
        """Actualiza una traducción existente."""
        now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

        rows_affected = await self._update_where(
            "words_lang",
            {
                "text": word_lang_entity.text.strip(),
                "pronunciation": word_lang_entity.pronunciation,
                "audio_path": word_lang_entity.audio_path,
                "notes": word_lang_entity.notes,
                "updated_at": now,
            },
            "id = ?",
            (word_lang_entity.id,),
        )

        return rows_affected > 0

    async def delete(self, word_lang_entity: WordLangEntity) -> bool:
        """Elimina una traducción."""
        rows_affected = await self._delete_where(
            "words_lang",
            "id = ?",
            (word_lang_entity.id,),
        )
        return rows_affected > 0

    async def delete_by_word_and_lang(self, word_es_id: int, lang_code: str) -> bool:
        """Elimina una traducción específica de una palabra."""
        rows_affected = await self._delete_where(
            "words_lang",
            "word_es_id = ? AND lang_code = ?",
            (word_es_id, lang_code),
        )
        return rows_affected > 0
