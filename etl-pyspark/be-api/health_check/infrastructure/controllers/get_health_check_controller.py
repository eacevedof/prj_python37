from typing import Any
from flask import jsonify, Response


def invoke(request: Any) -> Response:
    response = {
        "status": "ok"
    }
    return jsonify(response)