# project/app/auth/views.py
from flask import render_template
from app.forms import LoginForm
from . import auth

@auth.route("/login")
def login():
    context = {
        "loginform": LoginForm()
    }
    return render_template("login.html",**context)
