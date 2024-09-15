from shared.domain.enums.http_response_code_enum import HttpResponseCodeEnum
from shared.domain.exceptions.abstract_domain_exception import AbstractDomainException

class TalkToGpt35Exception(AbstractDomainException):

    @staticmethod
    def ticket_not_found():
        raise GetTicketByTicketNumberException(
            "tickets-tr.ticket-not-found",
            HttpResponseCodeEnum.NOT_FOUND.value
        )