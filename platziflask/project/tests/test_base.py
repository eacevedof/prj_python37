# project/tests/test_base.py
import sys
from flask_testing import TestCase
from flask import current_app, url_for
from bootstrap.main import flaskapp
sc("project/tests/test_base.py")

class MainTest(TestCase):
    
    # metodo obligatorio que tiene que devolver la flaskapp
    def create_app(self):
        flaskapp.config["TESTING"] = True
        flaskapp.config["WTF_CSRF_ENABLED"] = False
        return flaskapp

    def test_app_exists(self):        
        # self.assertIsNone(current_app)
        self.assertIsNotNone(current_app)

    def test_app_in_test_mode(self):
        self.assertTrue(current_app.config["TESTING"])
    
    def test_auth_login_template(self):
        # aqui no se usa response, la comunicacion entre client.get y el assertemplate
        # se hace con signals
        urlresolved = url_for("auth.login")
        self.client.get(urlresolved)
        self.assertTemplateUsed("login.html")

    def test_auth_login_get(self):
        urlresolved = url_for("auth.login")
        # auth.login: blueprint de auth, ruta login
        response = self.client.get(urlresolved)
        self.assert200(response)

    def test_auth_login_post(self):
        urlresolved = url_for("auth.login")
        dicformdata = {
            "username":"fake",
            "password":"fake-passs"
        }
        response = self.client.post(urlresolved,data=dicformdata)
        self.assertRedirects(response,url_for("todo_list"))

    # si no se está logado debe hacer un 302
    def test_todo_list(self):
        urlresolved = url_for("todo_list")
        response = self.client.get(urlresolved)
        self.assertRedirects(response,url_for("auth.login")+"?next=%2Ftodo-list")

    # prueba de post
    def test_todo_list_post_post(self):
        urlresolved = url_for("todo_list")
        response = self.client.post(urlresolved)
        # espero un Not Allowed
        self.assertTrue(response.status_code,405)

    def test_auth_blueprint_exists(self):
        self.assertIn("auth",self.app.blueprints)

