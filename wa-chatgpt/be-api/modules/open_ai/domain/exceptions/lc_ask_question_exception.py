from typing import final
from modules.shared.domain.enums.http_response_code_enum import HttpResponseCodeEnum
from modules.shared.domain.exceptions.abstract_domain_exception import AbstractDomainException


@final
class LcAskQuestionException(AbstractDomainException):

    def __init__(self, message: str, code: int) -> None:
        self._message = message
        self._code = code
        super().__init__(self._message)


    @staticmethod
    def empty_question() -> None:
        raise LcAskQuestionException(
            "open-ai-tr.resource-not-found",
            HttpResponseCodeEnum.NOT_FOUND.value
        )