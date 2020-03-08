# project/tests/test_mail.py
from flask_testing import TestCase
from bootstrap.main import flaskapp
from app.services.sendmail_service import SendmailService
sc("project/tests/test_mail.py")

class MailTest(TestCase):
    
    # metodo obligatorio que tiene que devolver la flaskapp
    def create_app(self):
        # bug(flaskapp.config,"flaskapp.config en test")
        # flaskapp.config["TESTING"] = True
        return flaskapp

    def test_raw(self):
        pr("test_raw")
        #flaskapp.config["MAIL_USERNAME"] = "xxx@gmail.com"
        #flaskapp.config["MAIL_PASSWORD"] = "yyy"

        flaskapp.config["DEBUG"] = True
        flaskapp.config["TESTING"] = False
        flaskapp.config["MAIL_SERVER"] = "smtp.gmail.com"
        flaskapp.config["MAIL_PORT"] = 465
        flaskapp.config["MAIL_USE_TLS"] = False
        flaskapp.config["MAIL_USE_SSL"] = True
        flaskapp.config["MAIL_DEFAULT_SENDER"] = "elsender@unmail.com"  
        flaskapp.config["MAIL_MAX_EMAILS"] = None 
        flaskapp.config["MAIL_ASCII_ATTACHMENTS"] = False 

        msg = Message("Hello", recipients=["eaf@example.com"])
        msg.body = "testing"
        msg.html = "<b>testing</b>"

        mail = Mail(flaskapp)
        mail.send(msg)
        pr("end test_raw")

    def test_send_params(self):
        pr("test_send_params")
        objmail = SendmailService(flaskapp)
        objmail.set_sender("wow@gmail.com")
        objmail.set_body("some body to send")
        objmail.set_subject("un subject")
        objmail.add_recipient("hocet81487@remailsky.com")
        is_sentok = objmail.send()
        self.assertEqual(is_sentok,True)
        pr("end test_send_params")