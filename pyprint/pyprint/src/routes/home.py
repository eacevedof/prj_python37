from src.boot.fastapi import app, Request

from typing import Optional
from src.controllers.home_controller import HomeController


@app.get("/")
def home():
    return (HomeController()).index()

# para que llegue q hay que enviar todo con cabecer accpet application/json
@app.get("/prueba/{slug}")
def test(slug: str, request: Request):
    #return {"x":"y"}
    return (HomeController()).test(slug=slug, request=request)