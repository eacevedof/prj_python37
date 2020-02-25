from pprint import pprint
import sys

from flask import request, make_response, redirect, render_template, session, redirect, url_for, flash

class Session:
    def get_value(self,strkey=""):
        return session.get(strkey)
    
    def set_value(self,strkey="",mxvalue=None):
        session[strkey]=mxvalue

class Base:

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

    def render(self,strtpl):
        return render_template(strtpl)
