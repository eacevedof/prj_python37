from src.boot.fastapi import app, Request

from typing import Optional
from src.controllers.home_controller import HomeController


@app.get("/")
def home():
    return (HomeController()).index()

# para que llegue q hay que enviar todo con cabecer accpet application/json
@app.get("/prueba/{slug_x}")
def test_get(slug_x: str, request: Request):
    return {"slug_x": slug_x, "perro": request.client.host}
    return (HomeController()).get_test(slug_x, perro=perro)