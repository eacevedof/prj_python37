"""Componente de campo de entrada para respuestas."""

import flet as ft
from typing import Callable


class InputFieldComp(ft.Container):
    """Componente de entrada de texto para respuestas."""

    def __init__(
        self,
        placeholder: str = "Escribe la traduccion...",
        on_submit: Callable[[str], None] | None = None,
        on_skip: Callable[[], None] | None = None,
        disabled: bool = False,
    ):
        super().__init__()
        self.placeholder = placeholder
        self.on_submit = on_submit
        self.on_skip = on_skip
        self.disabled = disabled
        self._text_field: ft.TextField | None = None
        self._submit_btn: ft.ElevatedButton | None = None

        self._build_ui()

    def _build_ui(self) -> None:
        self._text_field = ft.TextField(
            hint_text=self.placeholder,
            width=350,
            text_size=18,
            border_radius=8,
            focused_border_color=ft.Colors.BLUE_700,
            on_submit=self._handle_submit,
            disabled=self.disabled,
            autofocus=True,
        )

        self._submit_btn = ft.ElevatedButton(
            content=ft.Row(
                [ft.Icon(ft.Icons.CHECK), ft.Text("Verificar")],
                alignment=ft.MainAxisAlignment.CENTER,
            ),
            on_click=self._handle_submit,
            disabled=self.disabled,
            style=ft.ButtonStyle(
                bgcolor=ft.Colors.BLUE_700,
                color=ft.Colors.WHITE,
            ),
        )

        skip_btn = ft.TextButton(
            content=ft.Text("Saltar (Enter vacio)"),
            on_click=self._handle_skip,
            disabled=self.disabled,
        )

        self.content = ft.Column(
            controls=[
                ft.Row(
                    controls=[
                        self._text_field,
                        self._submit_btn,
                    ],
                    alignment=ft.MainAxisAlignment.CENTER,
                    spacing=12,
                ),
                ft.Container(
                    content=skip_btn,
                    alignment=ft.Alignment.CENTER,
                ),
            ],
            horizontal_alignment=ft.CrossAxisAlignment.CENTER,
            spacing=8,
        )

    def _handle_submit(self, e) -> None:
        """Maneja el envio de respuesta."""
        if self._text_field and self.on_submit:
            value = self._text_field.value or ""
            if value.strip():
                self.on_submit(value.strip())
            elif self.on_skip:
                self.on_skip()

    def _handle_skip(self, e) -> None:
        """Maneja el salto de pregunta."""
        if self.on_skip:
            self.on_skip()

    def clear(self) -> None:
        """Limpia el campo de texto."""
        if self._text_field:
            self._text_field.value = ""
            self.update()

    def focus(self) -> None:
        """Pone el foco en el campo de texto."""
        if self._text_field:
            self._text_field.focus()

    def set_disabled(self, disabled: bool) -> None:
        """Habilita o deshabilita el componente."""
        self.disabled = disabled
        if self._text_field:
            self._text_field.disabled = disabled
        if self._submit_btn:
            self._submit_btn.disabled = disabled
        self.update()

    def show_result(self, is_correct: bool, correct_answer: str) -> None:
        """Muestra el resultado de la respuesta."""
        if self._text_field:
            if is_correct:
                self._text_field.border_color = ft.Colors.GREEN_500
                self._text_field.focused_border_color = ft.Colors.GREEN_500
            else:
                self._text_field.border_color = ft.Colors.RED_500
                self._text_field.focused_border_color = ft.Colors.RED_500
                self._text_field.helper_text = f"Correcto: {correct_answer}"
                self._text_field.helper_style = ft.TextStyle(
                    color=ft.Colors.RED_700,
                    weight=ft.FontWeight.BOLD,
                )
            self.update()

    def reset_style(self) -> None:
        """Resetea el estilo del campo."""
        if self._text_field:
            self._text_field.border_color = None
            self._text_field.focused_border_color = ft.Colors.BLUE_700
            self._text_field.helper_text = None
            self.clear()
