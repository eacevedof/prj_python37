from shared.domain.enums import HttpResponseCodeEnum

class AbstractDomainException(Exception):
    pass

class GetTicketByTicketNumberException(AbstractDomainException):

    @staticmethod
    def ticket_not_found():
        raise GetTicketByTicketNumberException(
            "tickets-tr.ticket-not-found",
            HttpResponseCodeEnum.NOT_FOUND.value
        )