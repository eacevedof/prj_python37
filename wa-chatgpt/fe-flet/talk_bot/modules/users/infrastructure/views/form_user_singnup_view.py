from dataclasses import dataclass
from typing import final
import flet as ft
from flet import TextField, Checkbox, ElevatedButton, Row, Text
from flet_core import Column


@final
# @dataclass(frozen=True)
class FormUserSignupView:
    def __init__(self, page: ft.Page) -> None:
        self.__page = page
        self.__page.title = "Signup"
        self.__page.vertical_alignment = ft.VerticalAlignment.CENTER
        self.__page.theme_mode = ft.ThemeMode.LIGHT
        self.__page.window_width = 400
        self.__page.window_height = 400
        self.__page.window_resizable = False

        self.__text_username = TextField(label="Username", text_align=ft.TextAlign.LEFT, width=300)
        self.__text_password = TextField(password=True, label="Password", text_align=ft.TextAlign.LEFT, width=300)
        self.__chk_agree = Checkbox(label="I agree to the terms and conditions", value=False)
        self.__btn_signup = ElevatedButton(text="Signup", disabled=True, width=300)

        self.__configure_input_events()

        page.add(Row(
            controls=[
                Column([
                        self.__text_username,
                        self.__text_password,
                        self.__chk_agree,
                        self.__btn_signup
                    ],
                    alignment=ft.MainAxisAlignment.CENTER
                )
            ],
            alignment=ft.MainAxisAlignment.CENTER
        ))

    def __configure_input_events(self) -> None:
        self.__text_username.on_change = self.__validate_input
        self.__text_password.on_change = self.__validate_input
        self.__chk_agree.on_change = self.__validate_input
        self.__btn_signup.on_click = self.__on_submit

    def __validate_input(self, event: ft.ControlEvent) -> None:
        self.__btn_signup.disabled = True
        if all([self.__text_username.value, self.__text_password.value, self.__chk_agree.value]):
            self.__btn_signup.disabled = False

        self.__page.update()

    def __on_submit(self, event: ft.ControlEvent) -> None:
        print("username:", self.__text_username.value)
        print("password:", self.__text_password.value)
        self.__page.clean()
        self.__page.add(Row(
            controls=[
                Text(value=f"User {self.__text_username.value} created successfully", text_align=ft.TextAlign.CENTER, size=20)
            ],
            alignment=ft.MainAxisAlignment.CENTER
        ))