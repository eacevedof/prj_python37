from flask import Response, request

from shared.domain.enums import HttpResponseCodeEnum
from open_ai.application.talk_to_gpt35.talk_to_gpt35_dto import TalkToGpt35DTO
from open_ai.application.talk_to_gpt35.talk_to_gpt35_service import talk_to_gpt35_service
from shared.infrastructure.components.http_json_response import HttpJsonResponse

def invoke(http_request: request) -> Response:
    try:
        talk_to_gpt35_dto = TalkToGpt35DTO(
            question=http_request.args["question"]
        )
        talked_to_gpt35_dto = talk_to_gpt35_service(
            talk_to_gpt35_dto
        )

        return HttpJsonResponse.from_primitives({
            "code": HttpResponseCodeEnum.OK.value,
            "message": "open-ai-tr.talk_to_gpt35",
            "data": {"chat_response": talked_to_gpt35_dto.chat_response}
        }).get_as_json_response()

    except (GetTicketByTicketNumberException, GetUserIdByAuthTokenException) as ex:
        return HttpJsonResponse.from_primitives({
            "code": ex.code,
            "message": ex.message,
        }).get_as_json_response()

    except Exception as ex:
        return HttpJsonResponse.from_primitives({
            "code": ex.code,
            "message": "shared-tr.some-unexpected-error-occurred",
        }).get_as_json_response()

