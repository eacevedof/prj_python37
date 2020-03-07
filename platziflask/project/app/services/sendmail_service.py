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

        self.flaskapp.config["MAIL_DEFAULT_SENDER"] = "elsender@unmail.com"
        self.flaskapp.config["MAIL_MAX_EMAILS"] = None
        self.flaskapp.config["MAIL_ASCII_ATTACHMENTS"] = False

        #https://temp-mail.org/
        objmail = Mail(self.flaskapp)
        objmsg = Message(
            subject="Hey there x", 
            recipients=["hocet81487@remailsky.com"]
        )
        
        objmsg.body = "testing 2"+datetime.today().strftime('%Y-%m-%d-%H:%M:%S')
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
        
        



