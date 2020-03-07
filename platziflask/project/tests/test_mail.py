# project/tests/test_base.py
from flask_testing import TestCase
from flask import url_for
from main import flaskapp
from app.services.sendmail_service import SendmailService

pr("","project/tests/test_base.py")

class MailTest(TestCase):
    
    # metodo obligatorio que tiene que devolver la flaskapp
    def create_app(self):
        flaskapp.config["TESTING"] = True
        return flaskapp

    def test_send(self):
        is_sentok = SendmailService(flaskapp).send()
        self.assertEqual(is_sentok,True)


