import flet as ft
from flet import TextField


class FormUserSignupView:
    def __init__(self, page: ft.Page) -> None:
        page.title = "Login"
        page.vertical_alignment = ft.VerticalAlignment.CENTER
        page.theme_mode = ft.ThemeMode.LIGHT
        page.window_width = 400
        page.window_height = 400
        page.window_resizable = False

        text_username = TextField(label="Username", text_align=ft.TextAlign.LEFT, width=300)
        page.add(text_username)
