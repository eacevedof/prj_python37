# project/app/services/sendmail_service.py
from flask_mail import Mail, Message
from datetime import datetime

class SendmailService():

    _subject = ""
    _body = ""
    _html = ""

    def __init__(self, flaskapp):
        self.flaskapp = flaskapp

    def send(self):
        # self.flaskapp.config["DEBUG"] = True
        self.flaskapp.config["TESTING"] = False
        self.flaskapp.config["MAIL_SERVER"] = "smtp.gmail.com"
        self.flaskapp.config["MAIL_PORT"] = 465
        self.flaskapp.config["MAIL_USE_TLS"] = False
        self.flaskapp.config["MAIL_USE_SSL"] = True


        self.flaskapp.config["MAIL_DEFAULT_SENDER"] = "elsender@unmail.com"
        # self.flaskapp.config["MAIL_MAX_EMAILS"] = None
        # self.flaskapp.config["MAIL_ASCII_ATTACHMENTS"] = False

        #https://temp-mail.org/
        objmail = Mail(self.flaskapp)
        objmsg = Message(
            subject="Hey there "+datetime.today().strftime('%Y-%m-%d %H:%M:%S'), 
            recipients=["hocet81487@remailsky.com"]
        )
        
        objmsg.body = "testing "+datetime.today().strftime('%Y-%m-%d %H:%M:%S')
        # objmsg.html = "<p>some mail<p>"

        retcode = True
        try:
            objmail.send(objmsg)
        except SMTPAuthenticationError:
            retcode = 2
        except SMTPServerDisconnected:
            retcode = 3
        except SMTPException:
            retcode = 1
        
        return retcode
        
        



