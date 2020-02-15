# project/app/auth/__init__.py
from flask import Blueprint

# todas las rutas que empiecen por /auth van a ser redirigidas a este blueprint
auth = Blueprint("auth",__name__,url_prefix="/auth")

from . import views