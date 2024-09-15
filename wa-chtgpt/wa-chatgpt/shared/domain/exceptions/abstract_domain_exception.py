from shared.domain.enums.http_response_code_enum import HttpResponseCodeEnum

from abc import ABC

class AbstractDomainException(Exception, ABC):
    pass

class GetTicketByTicketNumberException(AbstractDomainException):

    @staticmethod
    def ticket_not_found():
        raise GetTicketByTicketNumberException(
            "tickets-tr.ticket-not-found",
            HttpResponseCodeEnum.NOT_FOUND.value
        )