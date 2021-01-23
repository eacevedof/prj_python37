from typing import Optional
from fastapi import FastAPI
from src.controllers.home_controller import HomeController

app = FastAPI()

@app.get("/")
def read_root():
    ctrl = HomeController()
    return ctrl.index()

@app.get("/items/{item_id}")
def read_item(item_id: int, q: Optional[str] = None):
    return {"item_id": item_id, "q": q}