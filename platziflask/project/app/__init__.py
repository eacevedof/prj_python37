# project/app/__init__.py
from flask import Flask
from flask_bootstrap import Bootstrap
from .config import Config
from .auth import auth

def create_app():
    app = Flask(__name__)
    bootstrap = Bootstrap(app)
    # se pasa a una clase de configuracion (config.py)
    # app.config["SECRET_KEY"] = "SUPER SECRET KEY"
    # con esto se cifra la info de la cookie
    # esto habria que cambiarlo a un hash más seguro, para el ejemplo nos vale    
    app.config.from_object(Config)
    app.register_blueprint(auth)

    return app