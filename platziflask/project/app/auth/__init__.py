# project/app/auth/__init__.py
from flask import Blueprint

# todas las rutas que empiecen por /auth van a ser redirigidas a este blueprint
auth = Blueprint("auth",__name__,url_prefix="/auth")

# @auth.route("/login") importo funcion login()
from . import views
