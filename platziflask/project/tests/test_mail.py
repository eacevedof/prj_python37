# project/tests/test_mail.py
from flask_testing import TestCase
from flask import url_for
from bootstrap.main import flaskapp
from app.services.sendmail_service import SendmailService
sc("project/tests/test_mail.py")

class MailTest(TestCase):
    
    # metodo obligatorio que tiene que devolver la flaskapp
    def create_app(self):
        # bug(flaskapp.config,"flaskapp.config en test")
        # flaskapp.config["TESTING"] = True
        return flaskapp

    # def test_send(self):
    #     is_sentok = SendmailService(flaskapp).send()
    #     self.assertEqual(is_sentok,True)

    def test_send_params(self):
        objmail = SendmailService(flaskapp)
        objmail.set_sender("eaf@ya.com")
        objmail.set_body("some body to send")
        objmail.set_subject("un subject")
        objmail.add_recipient("hocet81487@remailsky.com")
        is_sentok = objmail.send()
        self.assertEqual(is_sentok,True)
