# project/tests/test_base.py
print("test_base.py")
from flask_testing import TestCase
from flask import current_app, url_for

from main import app

class MainTest(TestCase):
    
    # metodo obligatorio que tiene que devolver la app
    def create_app(self):
        app.config["TESTING"] = True
        app.config["WTF_CSRF_ENABLED"] = False
        return app

    def test_app_exists(self):        
        # self.assertIsNone(current_app)
        self.assertIsNotNone(current_app)

    def test_app_in_test_mode(self):
        self.assertTrue(current_app.config["TESTING"])
    
    def test_index_redirect(self):
        response = self.client.get(url_for("index"))
        # self.assertTrue(response.status_code)
        self.assertRedirects(response, url_for("hello"))

    def test_hello_get(self):
        response = self.client.get(url_for("hello"))
        self.assert200(response)

    # prueba de post
    def test_hello_post(self):
        response = self.client.post(url_for("hello"))
        # espero un Not Allowed
        self.assertTrue(response.status_code,405)

    def test_auth_blueprint_exists(self):
        self.assertIn("auth",self.app.blueprints)

    def test_auth_login_get(self):
        # auth.login: blueprint de auth, ruta login
        response = self.client.get(url_for("auth.login"))
        self.assert200(response)

    def test_auth_login_template(self):
        # aqui no se usa response, la comunicacion entre client.get y el assertemplate
        # se hace con signals
        self.client.get(url_for("auth.login"))
        self.assertTemplateUsed("login.html")

    def test_auth_login_post(self):
        dicformdata = {
            "username":"fake",
            "password":"fake-passs"
        }
        response = self.client.post(url_for("auth.login"),data=dicformdata)
        self.assertRedirects(response,url_for("index"))