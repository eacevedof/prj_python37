# project/app/__init__.py
from flask_login import LoginManager
login_manager = LoginManager()

@login_manager.user_loader
def load_user(username):
    from app.models.user import UserModel
    return UserModel.query(username)

def create_app():
    from flask_bootstrap import Bootstrap
    from flask import Flask
    from .config import Config
    # importo el blueprint: auth = Blueprint("auth",__name__,url_prefix="/auth")
    from .auth import bpauth
    
    login_manager.login_view = "auth.login"
    app = Flask(__name__)
    
    # se pasa a una clase de configuracion (config.py)
    # app.config["SECRET_KEY"] = "SUPER SECRET KEY"
    # con esto se cifra la info de la cookie
    # esto habria que cambiarlo a un hash más seguro, para el ejemplo nos vale    
    app.config.from_object(Config)
    login_manager.init_app(app)
    app.register_blueprint(bpauth)
    Bootstrap(app)
    return app