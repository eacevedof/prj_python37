
import flet as ft
from anyio.abc import value
from flet import TextField, Checkbox, ElevatedButton, Row, Text


class FormUserSignupView:
    __page: ft.Page
    __text_username: TextField
    __text_password: TextField
    __chk_agree: Checkbox
    __btn_signup: ElevatedButton

    def __init__(self, page: ft.Page) -> None:
        self.__page = page
        self.__page.title = "Singup"
        self.__page.vertical_alignment = ft.VerticalAlignment.CENTER
        self.__page.theme_mode = ft.ThemeMode.LIGHT
        self.__page.window_width = 400
        self.__page.window_height = 400
        self.__page.window_resizable = False


        self.__text_username = TextField(label="Username", text_align=ft.TextAlign.LEFT, width=300)
        self.__text_password = TextField(password=True, label="Password", text_align=ft.TextAlign.LEFT, width=300)
        self.__chk_agree = Checkbox(label="I agree to the terms and conditions", value=False)
        self.__btn_signup = ElevatedButton(text="Singup", disabled=False, width=300)

        self.__configure_input_events()

        page.add(self.__text_username)
        page.add(self.__text_password)
        page.add(self.__chk_agree)
        page.add(self.__btn_signup)


    def __configure_input_events(self) -> None:
        self.__text_username.on_change = self.__validate_input
        self.__text_password.on_change = self.__validate_input
        self.__chk_agree.on_change = self.__validate_input
        self.__btn_signup.on_click = self.__on_submit


    def __validate_input(self, event: ft.ControlEvent) -> None:
        self.__btn_signup.disabled = True
        if all([self.__text_username, self.__text_password, self.__chk_agree]):
            self.__btn_signup.disabled = False

        self.__page.update()

    def __on_submit(self, event: ft.ControlEvent) -> None:
        print("username:", self.__text_username.value)
        print("password:", self.__text_password.value)
        self.__page.clean()
        self.__page.add(Row(
            controls=[Text(value=f"User {self.__text_username} created successfully", text_align=ft.TextAlign.CENTER, size=20)],
            alignment=ft.MainAxisAlignment.CENTER
        ))