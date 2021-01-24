from src.boot.fastapi import app, Request

from src.controllers.debug_controller import DebugController

@app.get("/debug")
def index():
    return (DebugController()).index()