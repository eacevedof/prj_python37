from cProfile import label

import flet as ft
from flet import TextField

from modules.users.infrastructure.views.form_user_singnup_view import FormUserSignupView

def main(page: ft.Page):
    form = FormUserSignupView(page)

ft.app(main)