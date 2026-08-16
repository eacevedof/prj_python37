from flask import Request, jsonify, Response


def invoke(http_request: Request) -> Response:
    response = {
        "status": "ok"
    }
    return jsonify(response)