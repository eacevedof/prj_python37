from dataclasses import dataclass, field
from typing import final
import flet as ft
from flet import TextField, Checkbox, ElevatedButton, Row, Text
from flet_core import Column

@final
@dataclass
class FormUserSignupView:
    page: ft.Page
    __text_username: TextField = field(init=False)
    __text_password: TextField = field(init=False)
    __chk_agree: Checkbox = field(init=False)
    __btn_signup: ElevatedButton = field(init=False)

    def __post_init__(self):
        self.page.title = "Signup"
        self.page.vertical_alignment = ft.VerticalAlignment.CENTER
        self.page.theme_mode = ft.ThemeMode.LIGHT
        self.page.window_width = 400
        self.page.window_height = 400
        self.page.window_resizable = False

        self.__text_username = TextField(label="Username", text_align=ft.TextAlign.LEFT, width=300)
        self.__text_password = TextField(password=True, label="Password", text_align=ft.TextAlign.LEFT, width=300)
        self.__chk_agree = Checkbox(label="I agree to the terms and conditions", value=False)
        self.__btn_signup = ElevatedButton(text="Signup", disabled=True, width=300)

        self.__configure_input_events()

        self.page.add(
            Row(
                controls=[
                    Column([
                            self.__text_username,
                            self.__text_password,
                            self.__chk_agree,
                            self.__btn_signup
                        ],
                    )
                ],
                alignment=ft.MainAxisAlignment.CENTER
            )
        )

    def __configure_input_events(self) -> None:
        self.__text_username.on_change = self.__validate_input
        self.__text_password.on_change = self.__validate_input
        self.__chk_agree.on_change = self.__validate_input
        self.__btn_signup.on_click = self.__on_submit

    def __validate_input(self, event: ft.ControlEvent) -> None:
        self.__btn_signup.disabled = True
        if all([self.__text_username.value, self.__text_password.value, self.__chk_agree.value]):
            self.__btn_signup.disabled = False

        self.page.update()

    def __on_submit(self, event: ft.ControlEvent) -> None:
        print("username:", self.__text_username.value)
        print("password:", self.__text_password.value)
        self.page.clean()
        self.page.add(Row(
            controls=[
                Text(value=f"User {self.__text_username.value} created successfully", text_align=ft.TextAlign.CENTER, size=20)
            ],
            alignment=ft.MainAxisAlignment.CENTER
        ))