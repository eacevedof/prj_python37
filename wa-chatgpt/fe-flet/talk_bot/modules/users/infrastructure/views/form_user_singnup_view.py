
import flet as ft
from flet import TextField, Checkbox, ElevatedButton
from flet_core import ElevatedButton


class FormUserSignupView:
    def __init__(self, page: ft.Page) -> None:
        page.title = "Singup"
        page.vertical_alignment = ft.VerticalAlignment.CENTER
        page.theme_mode = ft.ThemeMode.LIGHT
        page.window_width = 400
        page.window_height = 400
        page.window_resizable = False

        inputs = []
        tmp = TextField(label="Username", text_align=ft.TextAlign.LEFT, width=300)
        inputs.append(tmp)
        tmp = TextField(label="Password", text_align=ft.TextAlign.LEFT, width=300, password=True)
        inputs.append(tmp)
        tmp = Checkbox(label="I agree to the terms and conditions", value=False)
        inputs.append(tmp)
        tmp = ElevatedButton(text="Singup", width=300)
        inputs.append(tmp)

        for input in inputs:
            page.add(input)
