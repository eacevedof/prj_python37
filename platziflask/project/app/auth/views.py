# project/app/auth/views.py
from flask import render_template, session, redirect, flash, url_for
from flask_login import login_required, logout_user

from app.forms.forms import LoginForm

# importo: Blueprint("auth",__name__,url_prefix="/auth")
from . import bpauth
from app.services.firestore import get_user, user_put
from app.models.user import UserData, UserModel
from app.controllers.auth import Auth

from pprint import pprint

# blueprint.route("auth/<ruta>")
@bpauth.route("/login", methods=["GET","POST"])
def login():
    return Auth().login()

@bpauth.route("signup",methods=["GET","POST"])
def signup():
    return Auth().signup()

@bpauth.route("logout")
@login_required
def logout():
    return Auth().logout()

