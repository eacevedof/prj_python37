from flask import jsonify, Response


def invoke() -> Response:
    response = {
        "status": "ok"
    }
    return jsonify(response)