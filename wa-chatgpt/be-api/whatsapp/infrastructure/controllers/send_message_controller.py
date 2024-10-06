from flask import Response, request

from shared.infrastructure.log import Log
from shared.domain.enums.http_response_code_enum import HttpResponseCodeEnum
from shared.infrastructure.http.response.http_json_response import HttpJsonResponse
from whatsapp.domain.exceptions.send_message_exception import SendMessageException
from whatsapp.application.send_message.send_message_dto import SendMessageDto
from whatsapp.application.send_message.send_message_service import SendMessageService


def invoke(http_request: request) -> Response:
    try:
        send_message_dto = SendMessageDto.get_instance(
            phone_number=http_request.get_json().get("phone_number", ""),
            message=http_request.get_json().get("message", "")
        )

        sent_message_dto = SendMessageService().invoke(send_message_dto)

        return HttpJsonResponse.from_primitives({
            "code": HttpResponseCodeEnum.OK.value,
            "message": "open-ai-tr.talk_to_gpt35",
            "data": {"message_result": sent_message_dto.result}
        }).get_as_json_response()

    except SendMessageException as ex:
        return HttpJsonResponse.from_primitives({
            "code": ex.code,
            "message": ex.message,
        }).get_as_json_response()

    except Exception as ex:
        Log.log_exception(ex, "talk_to_gpt35_controller.invoke")
        return HttpJsonResponse.from_primitives({
            "code": HttpResponseCodeEnum.INTERNAL_SERVER_ERROR.value,
            "message": "shared-tr.some-unexpected-error-occurred",
        }).get_as_json_response()

