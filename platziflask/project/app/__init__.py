# project/app/__init__.py
from flask import Flask
from flask_bootstrap import Bootstrap
from flask_login import LoginManager

from .config import Config

# importo el blueprint: auth = Blueprint("auth",__name__,url_prefix="/auth")
from .auth import auth
from app.models.user import UserModel


login_manager = LoginManager()
# print(login_manager)
login_manager.login_view = "auth.login"

@login_manager.user_loader
def load_user(username):
    return UserModel.query(username)


def create_app():
    app = Flask(__name__)
    bootstrap = Bootstrap(app)
    # se pasa a una clase de configuracion (config.py)
    # app.config["SECRET_KEY"] = "SUPER SECRET KEY"
    # con esto se cifra la info de la cookie
    # esto habria que cambiarlo a un hash más seguro, para el ejemplo nos vale    
    app.config.from_object(Config)
    login_manager.init_app(app)
    app.register_blueprint(auth)

    return app