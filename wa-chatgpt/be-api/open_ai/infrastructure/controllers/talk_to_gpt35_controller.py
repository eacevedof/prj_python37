from flask import Response, request

from shared.infrastructure.log import Log
from shared.domain.enums.http_response_code_enum import HttpResponseCodeEnum
from shared.infrastructure.http.response.http_json_response import HttpJsonResponse
from open_ai.application.talk_to_gpt35.talk_to_gpt35_dto import TalkToGpt35DTO
from open_ai.application.talk_to_gpt35.talk_to_gpt35_service import talk_to_gpt35_service
from open_ai.domain.exceptions.talk_to_gpt35_exception import TalkToGpt35Exception


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

    except TalkToGpt35Exception as ex:
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

