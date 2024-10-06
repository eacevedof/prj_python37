from shared.domain.enums.http_response_code_enum import HttpResponseCodeEnum
from shared.domain.exceptions.abstract_domain_exception import AbstractDomainException

class TalkToGpt35Exception(AbstractDomainException):

    def __init__(self, message, code):
        self.message = message
        self.code = code
        super().__init__(self.message)

    @staticmethod
    def empty_question():
        raise TalkToGpt35Exception(
            "open-ai-tr.ticket-not-found",
            HttpResponseCodeEnum.NOT_FOUND.value
        )