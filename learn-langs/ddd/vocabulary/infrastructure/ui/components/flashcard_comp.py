"""Componente de flashcard para mostrar palabras."""

import flet as ft


class FlashcardComp(ft.Container):
    """Componente que muestra una palabra como flashcard."""

    def __init__(
        self,
        text_es: str,
        text_lang: str = "",
        word_type: str = "WORD",
        show_translation: bool = False,
        pronunciation: str = "",
    ):
        super().__init__()
        self.text_es = text_es
        self.text_lang = text_lang
        self.word_type = word_type
        self.show_translation = show_translation
        self.pronunciation = pronunciation
        self._card_content: ft.Column | None = None

        self._build_ui()

    def _build_ui(self) -> None:
        # Tipo de palabra badge
        type_badge = ft.Container(
            content=ft.Text(
                self.word_type,
                size=10,
                color=ft.Colors.WHITE,
            ),
            bgcolor=self._get_type_color(),
            border_radius=4,
            padding=ft.padding.symmetric(horizontal=8, vertical=2),
        )

        # Texto principal (espanol)
        main_text = ft.Text(
            self.text_es,
            size=32,
            weight=ft.FontWeight.BOLD,
            text_align=ft.TextAlign.CENTER,
        )

        # Contenido de la tarjeta
        card_controls = [
            type_badge,
            ft.Container(height=16),
            main_text,
        ]

        # Mostrar traduccion si esta habilitado
        if self.show_translation and self.text_lang:
            card_controls.extend([
                ft.Container(height=24),
                ft.Divider(height=1, color=ft.Colors.GREY_300),
                ft.Container(height=16),
                ft.Text(
                    self.text_lang,
                    size=28,
                    weight=ft.FontWeight.W_500,
                    color=ft.Colors.GREEN_700,
                    text_align=ft.TextAlign.CENTER,
                ),
            ])

            if self.pronunciation:
                card_controls.append(
                    ft.Text(
                        f"/{self.pronunciation}/",
                        size=16,
                        italic=True,
                        color=ft.Colors.GREY_600,
                        text_align=ft.TextAlign.CENTER,
                    )
                )

        self._card_content = ft.Column(
            controls=card_controls,
            horizontal_alignment=ft.CrossAxisAlignment.CENTER,
            alignment=ft.MainAxisAlignment.CENTER,
        )

        self.content = self._card_content
        self.width = 400
        self.height = 300
        self.bgcolor = ft.Colors.WHITE
        self.border_radius = 16
        self.padding = 32
        self.shadow = ft.BoxShadow(
            spread_radius=1,
            blur_radius=15,
            color=ft.Colors.with_opacity(0.2, ft.Colors.BLACK),
            offset=ft.Offset(0, 4),
        )
        self.alignment = ft.Alignment.CENTER

    def _get_type_color(self) -> str:
        """Retorna color segun tipo de palabra."""
        colors = {
            "WORD": ft.Colors.BLUE_600,
            "PHRASE": ft.Colors.PURPLE_600,
            "SENTENCE": ft.Colors.TEAL_600,
        }
        return colors.get(self.word_type, ft.Colors.GREY_600)

    def reveal_translation(self) -> None:
        """Muestra la traduccion."""
        self.show_translation = True
        # Rebuild the component
        if self._card_content and self.text_lang:
            self._card_content.controls.extend([
                ft.Container(height=24),
                ft.Divider(height=1, color=ft.Colors.GREY_300),
                ft.Container(height=16),
                ft.Text(
                    self.text_lang,
                    size=28,
                    weight=ft.FontWeight.W_500,
                    color=ft.Colors.GREEN_700,
                    text_align=ft.TextAlign.CENTER,
                ),
            ])
            self.update()

    def set_result_style(self, is_correct: bool) -> None:
        """Aplica estilo segun resultado."""
        if is_correct:
            self.border = ft.border.all(3, ft.Colors.GREEN_500)
        else:
            self.border = ft.border.all(3, ft.Colors.RED_500)
        self.update()
