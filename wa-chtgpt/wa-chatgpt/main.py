from flask import Flask, request, jsonify
from asgiref.wsgi import WsgiToAsgi

app = Flask(__name__)

@app.route("/", methods=["GET"])
def index():
    response = {
        "message": "API documentation"
    }
    return jsonify(response)

if __name__ == "__main__":
    import uvicorn
    asgi_app = WsgiToAsgi(app)
    uvicorn.run(asgi_app, host="0.0.0.0", port=3000, log_level="info")