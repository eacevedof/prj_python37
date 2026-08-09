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
        self._route_on_submit = on_submit
        self._route_on_skip = on_skip
        self.disabled = disabled
        self._text_field: ft.TextField | None = None
        self._submit_btn: ft.ElevatedButton | None = None
        # Área de corrección (al fallar): cómo se escribe + lo que escribió el usuario en rojo
        self._result_area: ft.Column | None = None

        self._build_ui()

    def _build_ui(self) -> None:
        self._text_field = ft.TextField(
            hint_text=self.placeholder,
            width=350,
            text_size=18,
            border_radius=8,
            focused_border_color=ft.Colors.BLUE_700,
            on_submit=self._on_submit_btn_click,
            disabled=self.disabled,
            autofocus=True,
        )

        self._submit_btn = ft.ElevatedButton(
            content=ft.Row(
                [ft.Icon(ft.Icons.CHECK), ft.Text("Verificar")],
                alignment=ft.MainAxisAlignment.CENTER,
            ),
            on_click=self._on_submit_btn_click,
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

        # Al fallar: se muestra lo que escribió el usuario en ROJO ENCIMA del campo.
        # Ancho fijo para que las frases largas ajusten línea en la tablet.
        self._result_area = ft.Column(
            controls=[],
            horizontal_alignment=ft.CrossAxisAlignment.CENTER,
            spacing=2,
        )

        self.content = ft.Column(
            controls=[
                ft.Container(
                    content=self._result_area,
                    width=360,
                    alignment=ft.Alignment.CENTER,
                ),
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

    def _on_submit_btn_click(self, e) -> None:
        """Maneja el envio de respuesta."""
        if self._text_field and self._route_on_submit:
            value = self._text_field.value or ""
            if value.strip():
                self._route_on_submit(value.strip())
            elif self._route_on_skip:
                self._route_on_skip()

    def _handle_skip(self, e) -> None:
        """Maneja el salto de pregunta."""
        if self._route_on_skip:
            self._route_on_skip()

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

    def show_result(
        self, is_correct: bool, correct_answer: str, user_input: str = ""
    ) -> None:
        """Muestra el resultado de la respuesta.

        Al fallar: borde rojo y, ENCIMA del campo, lo que escribió el usuario en
        ROJO (la traducción correcta ya se revela en la flashcard).
        """
        if not self._text_field:
            return

        if self._result_area is not None:
            self._result_area.controls.clear()

        if is_correct:
            self._text_field.border_color = ft.Colors.GREEN_500
            self._text_field.focused_border_color = ft.Colors.GREEN_500
        else:
            self._text_field.border_color = ft.Colors.RED_500
            self._text_field.focused_border_color = ft.Colors.RED_500
            if self._result_area is not None:
                self._result_area.controls.append(
                    ft.Text(
                        user_input or "(vacío)",
                        size=18,
                        weight=ft.FontWeight.BOLD,
                        color=ft.Colors.RED_600,
                        text_align=ft.TextAlign.CENTER,
                        selectable=True,
                    )
                )
        self.update()

    def reset_style(self) -> None:
        """Resetea el estilo del campo."""
        if self._result_area is not None:
            self._result_area.controls.clear()
        if self._text_field:
            self._text_field.border_color = None
            self._text_field.focused_border_color = ft.Colors.BLUE_700
            self.clear()
