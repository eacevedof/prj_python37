from typing import final
from shared.domain.enums.http_response_code_enum import HttpResponseCodeEnum
from shared.domain.exceptions.abstract_domain_exception import AbstractDomainException


@final
class TalkToGpt35Exception(AbstractDomainException):

    def __init__(self, message: str, code: int) -> None:
        self.message = message
        self.code = code
        super().__init__(self.message)


    @staticmethod
    def empty_question() -> None:
        raise TalkToGpt35Exception(
            "open-ai-tr.ticket-not-found",
            HttpResponseCodeEnum.NOT_FOUND.value
        )