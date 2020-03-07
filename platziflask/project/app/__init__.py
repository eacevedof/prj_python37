# project/app/__init__.py
sc("project/app/__init__.py")
from flask_login import LoginManager
login_manager = LoginManager()

@login_manager.user_loader
def load_user(username):
    from app.models.user_model import UserModel
    return UserModel.query(username)

def get_flaskapp():
    sc("... creando flaskapp")
    from flask_bootstrap import Bootstrap
    from flask import Flask
    from .config import Config
    #from auth.init import blueprint_auth
    from .auth import blueprint_auth
    
    login_manager.login_view = "auth.login"
    flaskapp = Flask(__name__)
    
    # se pasa a una clase de configuracion (config.py)
    # flaskapp.config["SECRET_KEY"] = "SUPER SECRET KEY"
    # con esto se cifra la info de la cookie
    # esto habria que cambiarlo a un hash más seguro, para el ejemplo nos vale    
    flaskapp.config.from_object(Config)
    login_manager.init_app(flaskapp)
    flaskapp.register_blueprint(blueprint_auth)
    Bootstrap(flaskapp)
    return flaskapp