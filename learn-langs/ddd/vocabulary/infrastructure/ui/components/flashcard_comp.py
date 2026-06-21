"""Componente de flashcard para mostrar palabras."""

import flet as ft

from ddd.vocabulary.domain.enums import WordTypeEnum


class FlashcardComp(ft.Container):
    """Componente que muestra una palabra como flashcard."""

    def __init__(
        self,
        text_es: str,
        text_lang: str = "",
        word_type: str = WordTypeEnum.WORD.value,
        show_translation: bool = False,
        pronunciation: str = "",
        word_id: int | str = "",
    ):
        super().__init__()
        self.text_es = text_es
        self.text_lang = text_lang
        self.word_type = word_type
        self.show_translation = show_translation
        self.pronunciation = pronunciation
        self.word_id = word_id
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
            padding=ft.Padding(left=8, right=8, top=2, bottom=2),
        )

        # Id de la palabra (pequeño, para depurar audios que no suenan)
        word_id_text = ft.Text(
            f"#{self.word_id}" if self.word_id != "" else "",
            size=14,
            color=ft.Colors.GREY_400,
            weight=ft.FontWeight.W_500,
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
            ft.Row(
                controls=[type_badge, ft.Container(expand=True), word_id_text],
                vertical_alignment=ft.CrossAxisAlignment.CENTER,
            ),
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
            WordTypeEnum.WORD.value: ft.Colors.BLUE_600,
            WordTypeEnum.PHRASE.value: ft.Colors.PURPLE_600,
            WordTypeEnum.SENTENCE.value: ft.Colors.TEAL_600,
        }
        return colors.get(self.word_type, ft.Colors.GREY_600)

    def reveal_translation(self) -> None:
        """Muestra la traduccion con pronunciacion."""
        self.show_translation = True
        # Rebuild the component
        if self._card_content and self.text_lang:
            controls_to_add = [
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
            ]

            # Agregar pronunciacion si existe
            if self.pronunciation:
                controls_to_add.extend([
                    ft.Container(height=8),
                    ft.Text(
                        f"/{self.pronunciation}/",
                        size=16,
                        italic=True,
                        color=ft.Colors.GREY_600,
                        text_align=ft.TextAlign.CENTER,
                    ),
                ])

            self._card_content.controls.extend(controls_to_add)
            self.update()

    def set_result_style(self, is_correct: bool) -> None:
        """Aplica estilo segun resultado."""
        if is_correct:
            self.border = ft.Border.all(3, ft.Colors.GREEN_500)
        else:
            self.border = ft.Border.all(3, ft.Colors.RED_500)
        self.update()
