from pprint import pprint

from flask_login import login_user,login_required
from .base_controller import BaseController
from app.models.user_model import UserData, UserModel
from app.services.firestore_service import FirestoreService
from app.forms.forms import LoginForm

class AuthController(BaseController):
    def __init__(self):
        super().__init__()
        
    # no va!
    ##@login_required
    def login(self):
        pprint("Auth.login()")
        frmLogin = LoginForm()

        if frmLogin.validate_on_submit():
            from werkzeug.security import check_password_hash,generate_password_hash
            username = frmLogin.username.data
            passreq = frmLogin.password.data
            passhash = generate_password_hash(passreq)
            pr("username:{},password:{}".format(username,passreq),"los passwords")
            pr(passhash,"pass-hash")

            userdoc = FirestoreService().get_user(username)
            userdict = userdoc.to_dict()
            
            if userdict is not None:
                passdb = userdict["password"]
                is_passwok = check_password_hash(passdb, passreq)
                pr(passreq,"pass db")
                pr(is_passwok,"is_passok")
                # bug aqui
                if is_passwok or passdb==passreq:
                    userdata = UserData(username, passreq)
                    user = UserModel(userdata)
                    login_user(user)
                    self.set_msg_succes("Bienvenido de nuevo")
                    self.redirect("todo_list")
                else:
                    bug("La informacion no coincide")
                    self.set_msg_error("La informacion no coincide")
            else:
                bug("El usuario no existe")
                self.set_msg_error("El usuario no existe")

            return self.redirect("todo_list")
        
        context = {
            "loginform": frmLogin
        }        
        return self.render("login.html",**context)


    def signup(self):
        from werkzeug.security import generate_password_hash

        pprint("Auth.singup()")
        signupform = LoginForm()
        context = {
            "signupform":signupform
        }

        if signupform.validate_on_submit():
            username = signupform.username.data
            password = signupform.password.data

            userdoc = FirestoreService().get_user(username)

            if userdoc.to_dict() is None:
                passwordhash = generate_password_hash(password)
                userdata = UserData(username, passwordhash)
                FirestoreService().user_put(userdata)
                user = UserModel(userdata)
                login_user(user)
                self.set_msg_succes("Bienvenido")
                return self.redirect("todo_list")
            else:
                self.set_msg_error("El usuario ya existe")

        return self.render("signup.html",**context)

    def logout(self):
        from flask_login import logout_user
        logout_user()
        self.set_msg_succes("Regresa pronto")
        return self.redirect("auth.login")