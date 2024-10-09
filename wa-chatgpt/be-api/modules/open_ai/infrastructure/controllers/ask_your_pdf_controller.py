from flask import Response, request

from modules.shared.infrastructure.components.log import Log
from modules.shared.domain.enums.http_response_code_enum import HttpResponseCodeEnum
from modules.shared.infrastructure.components.http.response.http_json_response import HttpJsonResponse
from modules.open_ai.application.ask_your_pdf.ask_your_pdf_dto import TalkToGpt35DTO
from modules.open_ai.application.ask_your_pdf.ask_your_pdf_service import ask_your_pdf_service
from modules.open_ai.domain.exceptions.ask_your_pdf_exception import TalkToGpt35Exception


def invoke(http_request: request) -> Response:
    try:
        ask_your_pdf_dto = TalkToGpt35DTO(
            question=http_request.args["question"]
        )
        talked_to_gpt35_dto = ask_your_pdf_service(
            ask_your_pdf_dto
        )

        return HttpJsonResponse.from_primitives({
            "code": HttpResponseCodeEnum.OK.value,
            "message": "open-ai-tr.ask_your_pdf",
            "data": {"chat_response": talked_to_gpt35_dto.chat_response}
        }).get_as_json_response()

    except TalkToGpt35Exception as ex:
        return HttpJsonResponse.from_primitives({
            "code": ex.code,
            "message": ex.message,
        }).get_as_json_response()

    except Exception as ex:
        Log.log_exception(ex, "ask_your_pdf_controller.invoke")
        return HttpJsonResponse.from_primitives({
            "code": HttpResponseCodeEnum.INTERNAL_SERVER_ERROR.value,
            "message": "shared-tr.some-unexpected-error-occurred",
        }).get_as_json_response()

