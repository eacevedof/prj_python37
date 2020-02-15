# project/main.py
from flask import Flask, request, make_response, redirect, render_template, session, redirect, url_for, flash
from flask_bootstrap import Bootstrap
from flask_wtf import FlaskForm
from wtforms.fields import StringField, PasswordField,SubmitField
from wtforms.validators import DataRequired
import unittest 

app = Flask(__name__)

bootstrap = Bootstrap(app)

# con esto se cifra la info de la cookie
# esto habria que cambiarlo a un hash más seguro, para el ejemplo nos vale
app.config["SECRET_KEY"] = "super secreto"

class LoginForm(FlaskForm):
    username = StringField("Nombre de usuario",validators=[DataRequired()])
    password = PasswordField("Password",validators=[DataRequired()])
    submit = SubmitField("Enviar")


@app.errorhandler(404)
def not_found(error):
    return render_template("404.html",error=error)

@app.errorhandler(500)
def not_found(error):
    return render_template("500.html",error=error)

@app.route("/")
def index():
    user_ip = request.remote_addr
    response = make_response(redirect("/hello"))
    # response.set_cookie("user_ip",user_ip+" :) ")
    session["user_ip"] = user_ip
    return response

todos = ["Comprar cafe","Enviar solicitud","Entregar video"]

@app.route("/hello",methods=["GET","POST"])
def hello():
    # userip = request.cookies.get("user_ip")
    user_ip = session.get("user_ip")
    loginform = LoginForm()
    username = session.get("username")

    context = {
        "user_ip":user_ip,
        "todos":todos,
        "loginform":loginform,
        "username":username
    }

    if loginform.validate_on_submit():
        username = loginform.username.data
        session["username"] = username
        flash("Nombre de usuario registrado con exito")
        password = loginform.password.data
        return redirect(url_for("index"))

    # spread operator
    return render_template("hello.html",**context)

# se llamara con: flask test
@app.cli.command()
def test():
    import werkzeug
    werkzeug.cached_property = werkzeug.utils.cached_property
    # todo lo que este en la carpeta de project/test se ejecutara
    tests = unittest.TestLoader().discover("tests")
    unittest.TextTestRunner().run(tests)

