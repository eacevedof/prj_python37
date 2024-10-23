from cProfile import label

import flet as ft
from flet import TextField

from modules.users.infrastructure.views.form_user_singnup_view import FormUserSignupView

def main(page: ft.Page):
    frm = FormUserSignupView(page)


if __name__ == "__main__":
    ft.app(target=main)