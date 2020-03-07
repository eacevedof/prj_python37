# project/app/auth/__init__.py
sc("project/app/auth/__init__.py Blueprint")
from flask import Blueprint

# todas las rutas que empiecen por /auth van a ser redirigidas a este blueprint
#bpauth = Blueprint("auth",__name__,url_prefix="/auth")
blueprint_auth = Blueprint("auth",__name__,url_prefix="/auth")

# @auth.route("/login") importo funcion login()
# from . import views
from . import routes
