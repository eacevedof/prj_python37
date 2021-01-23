from typing import Optional
from fastapi import FastAPI

from src.routes.routes import routes
from src.controllers.home_controller import HomeController

app = FastAPI()

@app.get("/")
def home():
    return {"routes": routes}
    return (HomeController()).index()

# para que llegue q hay que enviar todo con cabecer accpet application/json
@app.get("/prueba/{slug_x}")
def test_get(slug_x: str, perro: Optional[str] = None):
    #return {"slug_x": slug_x, "perro": perro}
    return (HomeController()).get_test(slug_x,perro=perro)