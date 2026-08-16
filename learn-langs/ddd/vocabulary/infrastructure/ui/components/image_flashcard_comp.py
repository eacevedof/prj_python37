"""Componente de flashcard con imagen para el examen.

Réplica visual de la tarjeta del Aprendizaje (SliderCardComp): tarjeta azul,
imagen a un lado (o arriba en retrato) y palabra ES en grande, con tamaños
escalados al tamaño real de la pantalla. La lógica de examen se mantiene:
la traducción queda oculta hasta reveal_translation() y el borde marca el
resultado (verde/rojo).
"""

from pathlib import Path

import flet as ft

from ddd.vocabulary.infrastructure.ui.enums.card_text_factor_enum import CardTextFactorEnum
from ddd.vocabulary.infrastructure.ui.enums.slider_card_size_enum import SliderCardSizeEnum


class ImageFlashcardComp(ft.Container):
    """Flashcard del examen: mismo look & feel que la tarjeta del Aprendizaje."""

    # La palabra/respuesta del examen conviven con timer+input: algo más
    # pequeñas que en el slider puro (factores sobre los tamaños kiosko)
    __WORD_FACTOR: float = CardTextFactorEnum.IMAGE_CARD_WORD.value
    __TRANSLATION_FACTOR: float = CardTextFactorEnum.IMAGE_CARD_TRANSLATION.value

    def __init__(
        self,
        image_file_path: str,
        image_caption: str = "",
        text_lang: str = "",
        pronunciation: str = "",
        show_translation: bool = False,
        word_id: int | str = "",
        ui_scale: float = 1.0,
        is_vertical: bool = False,
    ):
        super().__init__()
        self.image_file_path = image_file_path
        self.image_caption = image_caption
        self.text_lang = text_lang
        self.pronunciation = pronunciation
        self.show_translation = show_translation
        self.word_id = word_id
        # Escala/orientación las pasa la vista (ya montada); el comp se crea
        # ANTES de montarse y aquí self.page aún no es accesible (flet 0.86 lanza)
        self.__scale = ui_scale
        self.__is_vertical = is_vertical
        self._card_content: ft.Column | None = None
        # Nº de controles del prompt base (palabra ES): reveal trunca hasta aquí
        self.__base_control_count = 0

        self._build_ui()

    def _build_ui(self) -> None:
        """Construye la UI del componente (layout de la tarjeta del slider)."""
        scale = self.__scale

        full_image_path = self._get_full_image_path()
        has_image = bool(full_image_path) and Path(full_image_path).exists()

        # Palabra ES en grande: es el reto a traducir (con o sin imagen)
        word_text = ft.Text(
            self.image_caption or "—",
            size=round(SliderCardSizeEnum.WORD.value * scale * self.__WORD_FACTOR),
            weight=ft.FontWeight.BOLD,
            color=ft.Colors.BLUE_900,
            text_align=ft.TextAlign.CENTER,
            style=ft.TextStyle(height=1.0),  # interlineado mínimo al envolver
        )

        # Columna de texto: palabra + (tras reveal) respuesta correcta
        self._card_content = ft.Column(
            controls=[word_text],
            horizontal_alignment=ft.CrossAxisAlignment.CENTER,
            alignment=ft.MainAxisAlignment.CENTER,
            spacing=0,
        )
        self.__base_control_count = 1

        # Soporta traducción visible desde el inicio (no se usa en examen)
        if self.show_translation and self.text_lang:
            self._append_translation_controls()

        image_side = round(SliderCardSizeEnum.IMAGE.value * scale)
        image_container = ft.Container(
            content=ft.Image(
                src=full_image_path,
                width=image_side,
                height=image_side,
                fit=ft.BoxFit.CONTAIN,
                border_radius=12,
            ),
            alignment=ft.Alignment.CENTER,
            visible=has_image,
        )

        # Como en el slider: imagen | texto en apaisado, apilado en retrato
        if self.__is_vertical or not has_image:
            body: ft.Control = ft.Column(
                controls=[image_container, self._card_content],
                horizontal_alignment=ft.CrossAxisAlignment.CENTER,
                alignment=ft.MainAxisAlignment.CENTER,
                spacing=16,
            )
        else:
            body = ft.Row(
                controls=[image_container, self._card_content],
                alignment=ft.MainAxisAlignment.CENTER,
                vertical_alignment=ft.CrossAxisAlignment.CENTER,
                spacing=48,
            )

        # Id de la palabra como overlay (depuración de audios/imágenes)
        word_id_badge = ft.Container(
            content=ft.Text(
                f"#{self.word_id}" if self.word_id != "" else "",
                size=18,
                color=ft.Colors.GREY_600,
                weight=ft.FontWeight.BOLD,
            ),
            top=2,
            right=4,
        )

        # Padding superior para que el badge del id no pise la palabra
        body_with_margin = ft.Container(
            content=body,
            padding=ft.Padding(top=max(18, round(24 * scale)), left=0, right=0, bottom=0),
        )

        self.content = ft.Stack(controls=[body_with_margin, word_id_badge])
        self.bgcolor = ft.Colors.BLUE_50
        self.border_radius = 20
        # Vertical reducido: el alto es el recurso escaso (sobre todo en tablet)
        self.padding = ft.Padding(
            left=round(40 * scale),
            right=round(40 * scale),
            top=round(12 * scale),
            bottom=round(6 * scale),
        )
        self.alignment = ft.Alignment.CENTER

    def _get_full_image_path(self) -> str:
        """Construye la ruta completa de la imagen (base: data/images)."""
        if not self.image_file_path:
            return ""

        base_path = Path(__file__).parent.parent.parent.parent.parent.parent / "data" / "images"
        return str(base_path / self.image_file_path)

    def _append_translation_controls(self) -> None:
        """Añade la respuesta correcta (grande, verde) + pronunciación."""
        if not self._card_content or not self.text_lang:
            return

        scale = self.__scale
        self._card_content.controls.extend([
            ft.Container(height=4),
            ft.Divider(height=2, color=ft.Colors.BLUE_300),
            ft.Container(height=2),
            ft.Text(
                "Respuesta correcta:",
                size=max(11, round(14 * scale)),
                weight=ft.FontWeight.BOLD,
                color=ft.Colors.BLUE_700,
                text_align=ft.TextAlign.CENTER,
            ),
            ft.Text(
                self.text_lang,
                size=round(
                    SliderCardSizeEnum.TRANSLATION.value * scale * self.__TRANSLATION_FACTOR
                ),
                weight=ft.FontWeight.BOLD,
                color=ft.Colors.GREEN_700,
                text_align=ft.TextAlign.CENTER,
                style=ft.TextStyle(height=1.0),  # interlineado mínimo al envolver
            ),
        ])

        if self.pronunciation:
            self._card_content.controls.append(
                ft.Text(
                    f"/{self.pronunciation}/",
                    size=round(SliderCardSizeEnum.PRONUNCIATION.value * scale),
                    italic=True,
                    color=ft.Colors.GREY_600,
                    text_align=ft.TextAlign.CENTER,
                )
            )

    def reveal_translation(self) -> None:
        """Muestra la traducción (respuesta correcta del examen)."""
        self.show_translation = True
        if self._card_content and self.text_lang:
            # Limpiar controles de traducción previos (dejar solo el prompt base)
            while len(self._card_content.controls) > self.__base_control_count:
                self._card_content.controls.pop()
            self._append_translation_controls()
            self.update()

    def set_result_style(self, is_correct: bool) -> None:
        """Aplica estilo según resultado."""
        if is_correct:
            self.border = ft.Border.all(3, ft.Colors.GREEN_500)
        else:
            self.border = ft.Border.all(3, ft.Colors.RED_500)
        self.update()
