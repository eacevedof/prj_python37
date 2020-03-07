sc("app/controlloers/base_controller.py")
from flask import (
    request, make_response, redirect, render_template, session, 
    redirect, url_for, flash)

class Session:
    def get_value(self,strkey=""):
        return session.get(strkey)
    
    def set_value(self,strkey="",mxvalue=None):
        session[strkey]=mxvalue

class BaseController:

    def __init__(self):
        self.session = Session()

    def get_get(self,strkey=""):
        return request.args[strkey]

    def get_post(self,strkey=""):
        return request.form[strkey]
    
    def get_session(self, strkey=""):
        return self.session.get_value(strkey)

    def set_session(self, strkey="",mxvalue=None):
        self.session.set_value(strkey=strkey,mxvalue=mxvalue)

    def get_user_id(self):
        from flask_login import login_required, current_user
        return current_user.id

    def render(self,strtpl,**kwargs):
        return render_template(strtpl,**kwargs)

    def redirect(self,strurl):
        return redirect(url_for(strurl))

    def set_msg_error(self,strmsg):
        flash(strmsg,"danger")

    def set_msg_succes(self,strmsg):
        flash(strmsg,"success")

    def set_warning(self,strmsg):
        flash(strmsg,"warning")        