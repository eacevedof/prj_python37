from typing import final

from ddd.shared.domain.enums.response_code_enum import ResponseCodeEnum


@final
class VocabularyException(Exception):
    """Excepciones del dominio Vocabulary."""

    _code: int
    _message: str

    def __init__(self, message: str, code: int = ResponseCodeEnum.BAD_REQUEST) -> None:
        self._message = message
        self._code = code
        super().__init__(self._message)

    @property
    def code(self) -> int:
        return self._code

    @property
    def message(self) -> str:
        return self._message

    # Word errors
    @classmethod
    def word_not_found(cls, word_id: int) -> "VocabularyException":
        return cls(f"Word #{word_id} not found", ResponseCodeEnum.NOT_FOUND)

    @classmethod
    def word_already_exists(cls, text: str) -> "VocabularyException":
        return cls(f"Word '{text}' already exists", ResponseCodeEnum.CONFLICT)

    @classmethod
    def word_creation_failed(cls, error: str) -> "VocabularyException":
        return cls(f"Word creation failed: {error}", ResponseCodeEnum.BAD_REQUEST)

    # Translation errors
    @classmethod
    def translation_not_found(cls, word_id: int, lang_code: str) -> "VocabularyException":
        return cls(f"Translation {lang_code} not found for word #{word_id}", ResponseCodeEnum.NOT_FOUND)

    @classmethod
    def translation_already_exists(cls, word_id: int, lang_code: str) -> "VocabularyException":
        return cls(f"Translation {lang_code} already exists for word #{word_id}", ResponseCodeEnum.CONFLICT)

    # Language errors
    @classmethod
    def language_not_found(cls, lang_code: str) -> "VocabularyException":
        return cls(f"Language '{lang_code}' not found", ResponseCodeEnum.NOT_FOUND)

    @classmethod
    def language_not_active(cls, lang_code: str) -> "VocabularyException":
        return cls(f"Language '{lang_code}' is not active", ResponseCodeEnum.BAD_REQUEST)

    # Tag errors
    @classmethod
    def tag_not_found(cls, tag_id: int) -> "VocabularyException":
        return cls(f"Tag #{tag_id} not found", ResponseCodeEnum.NOT_FOUND)

    @classmethod
    def tag_already_exists(cls, name: str) -> "VocabularyException":
        return cls(f"Tag '{name}' already exists", ResponseCodeEnum.CONFLICT)

    # Session errors
    @classmethod
    def session_not_found(cls, session_id: int) -> "VocabularyException":
        return cls(f"Session #{session_id} not found", ResponseCodeEnum.NOT_FOUND)

    @classmethod
    def session_already_finished(cls, session_id: int) -> "VocabularyException":
        return cls(f"Session #{session_id} is already finished", ResponseCodeEnum.BAD_REQUEST)

    @classmethod
    def no_words_for_study(cls, lang_code: str) -> "VocabularyException":
        return cls(f"No words available for study in {lang_code}", ResponseCodeEnum.NOT_FOUND)

    # Validation errors
    @classmethod
    def invalid_word_type(cls, word_type: str) -> "VocabularyException":
        return cls(f"Invalid word type: '{word_type}'", ResponseCodeEnum.BAD_REQUEST)

    @classmethod
    def invalid_study_mode(cls, mode: str) -> "VocabularyException":
        return cls(f"Invalid study mode: '{mode}'", ResponseCodeEnum.BAD_REQUEST)

    @classmethod
    def empty_text(cls, field: str) -> "VocabularyException":
        return cls(f"'{field}' cannot be empty", ResponseCodeEnum.BAD_REQUEST)
