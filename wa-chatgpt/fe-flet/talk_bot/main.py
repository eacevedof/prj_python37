from cProfile import label

import flet as ft
from flet import TextField

from modules.users.infrastructure.views.form_user_singnup_view import FormUserSignupView

def main(page: ft.Page):
    frm = FormUserSignupView(page)

    def validate(event: ft.ControlEvent) -> None:
        frm.validate_input(event)

    def submit(event: ft.ControlEvent) -> None:
        frm.on_submit(event)

ft.app(main)