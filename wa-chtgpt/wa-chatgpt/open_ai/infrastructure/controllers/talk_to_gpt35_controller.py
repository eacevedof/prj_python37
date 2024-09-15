from flask import jsonify, Response, request
from open_ai.application.talk_to_gpt35.talk_to_gpt35_dto import TalkToGpt35DTO
from open_ai.application.talk_to_gpt35.talk_to_gpt35_service import talk_to_gpt35_service

def invoke(http_request: request) -> Response:
    talk_to_gpt35_dto = TalkToGpt35DTO(
        question=http_request.json["question"]
    )
    talked_to_gpt35_dto = talk_to_gpt35_service(
        talk_to_gpt35_dto
    )
    return jsonify(talked_to_gpt35_dto.__dict__)