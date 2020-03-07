# project/app/services/sendmail_service.py
from flask_mail import Mail, Message
from datetime import datetime

class SendmailService():

    _recipients = []
    _subject = "no subject - "+datetime.today().strftime('%Y-%m-%d %H:%M:%S')
    _body = ""
    _html = ""

    def __init__(self, flaskapp):
        self.flaskapp = flaskapp

    def _apply_config(self):
        # self.flaskapp.config["DEBUG"] = True
        self.flaskapp.config["TESTING"] = False
        self.flaskapp.config["MAIL_SERVER"] = "smtp.gmail.com"
        self.flaskapp.config["MAIL_PORT"] = 465
        self.flaskapp.config["MAIL_USE_TLS"] = False
        self.flaskapp.config["MAIL_USE_SSL"] = True
 
        self.flaskapp.config["MAIL_DEFAULT_SENDER"] = "elsender@unmail.com"
        # self.flaskapp.config["MAIL_MAX_EMAILS"] = None
        # self.flaskapp.config["MAIL_ASCII_ATTACHMENTS"] = False

    def set_subject(self,strsubject):
        self._subject = strsubject

    def set_body(self, strbody):
        self._body = strbody

    def set_html(self, strhtml):
        self._html = strhtml

    def add_recipient(self,strmail):
        self._recipients.append(strmail)

    def send(self):
        self._apply_config()
        
        #https://temp-mail.org/
        objmail = Mail(self.flaskapp)
        objmsg = Message(
            subject= self._subject,
            recipients=self._recipients
        )
        
        if self._body:
            objmsg.body = self._body

        if self._html:
            objmsg.html = self._html


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
        
        



