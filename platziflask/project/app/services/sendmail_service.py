# project/app/services/sendmail_service.py
from flask_mail import Mail, Message
from datetime import datetime

# https://pythonhosted.org/Flask-Mail/
# https://myaccount.google.com/lesssecureapps)
# https://accounts.google.com/DisplayUnlockCaptcha
# https://mail.google.com/mail/#settings/fwdandpop

class SendmailService():

    _recipients = []
    _subject = "no subject - "+datetime.today().strftime('%Y-%m-%d %H:%M:%S')
    _body = ""
    _html = ""
    _sender = ""

    def __init__(self, flaskapp):
        self.flaskapp = flaskapp

    def set_sender(self, strsender):
        self._sender = strsender

    def set_subject(self, strsubject):
        self._subject = strsubject

    def set_body(self, strbody):
        self._body = strbody

    def set_html(self, strhtml):
        self._html = strhtml

    def add_recipient(self, strmail):
        self._recipients.append(strmail)

    def send(self):
        #https://temp-mail.org/
        objmail = Mail(self.flaskapp)
        
        objmsg = Message(
            subject = self._subject,
            sender = self._sender,
            recipients = self._recipients
        )
        
        if self._body != "":
            objmsg.body = self._body

        if self._html != "":
            objmsg.html = self._html

        #bug(objmsg, "objmsg")

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
        
        



