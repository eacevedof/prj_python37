from typing import Optional
from fastapi import FastAPI
from src.controllers.home_controller import HomeController

app = FastAPI()

@app.get("/")
def read_root():
    return (HomeController()).index()

# para que llegue q hay que enviar todo con cabecer accpet application/json
@app.get("/prueba/{slug_x}")
def read_item(slug_x: str, perro: Optional[str] = None):
    return {"slug_x": slug_x, "perro": perro}