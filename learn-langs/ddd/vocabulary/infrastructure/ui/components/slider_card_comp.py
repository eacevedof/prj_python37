"""Componente: tarjeta animada del slider (imagen + palabra ES + traducción)."""

from pathlib import Path

import flet as ft


class SliderCardComp(ft.Container):
    """
    Tarjeta del slider, pensada para verse a distancia (modo kiosko).

    Responsabilidades:
    - Mostrar la imagen de la palabra (si existe)
    - Mostrar la palabra en español en MUY grande, animada al cambiar de palabra
    - Revelar la traducción y pronunciación en la fase del idioma destino
    - Indicar visualmente la fase de reproducción actual (audio)
    - NO tiene lógica de negocio
    """

    # Tamaños grandes para lectura a ~5 metros
    _PHASE_SIZE = 30
    _WORD_SIZE = 120
    _TRANSLATION_SIZE = 96
    _PRONUNCIATION_SIZE = 36
    _IMAGE_WIDTH = 380
    _IMAGE_HEIGHT = 320

    def __init__(self) -> None:
        super().__init__()

        # Clave de la palabra actualmente mostrada (para no re-animar entre fases)
        self._current_key: str = ""

        # Etiqueta de fase (qué se está pronunciando)
        self._ft_phase_label = ft.Text(
            "",
            size=self._PHASE_SIZE,
            weight=ft.FontWeight.W_500,
            color=ft.Colors.BLUE_700,
            text_align=ft.TextAlign.CENTER,
        )

        # Imagen de la palabra (opcional)
        self._ft_image = ft.Image(
            src="",
            width=self._IMAGE_WIDTH,
            height=self._IMAGE_HEIGHT,
            fit=ft.BoxFit.CONTAIN,
            border_radius=12,
        )
        self._ft_image_container = ft.Container(
            content=self._ft_image,
            alignment=ft.Alignment.CENTER,
            visible=False,
        )

        # Palabra en español (animada vía AnimatedSwitcher)
        self._ft_word_switcher = ft.AnimatedSwitcher(
            content=ft.Text("", key="__empty__"),
            transition=ft.AnimatedSwitcherTransition.SCALE,
            duration=400,
            reverse_duration=200,
            switch_in_curve=ft.AnimationCurve.EASE_OUT,
            switch_out_curve=ft.AnimationCurve.EASE_IN,
        )

        # Traducción y pronunciación (se revelan en la fase del idioma destino)
        self._ft_translation = ft.Text(
            "",
            size=self._TRANSLATION_SIZE,
            weight=ft.FontWeight.BOLD,
            color=ft.Colors.GREEN_700,
            text_align=ft.TextAlign.CENTER,
            visible=False,
        )
        self._ft_pronunciation = ft.Text(
            "",
            size=self._PRONUNCIATION_SIZE,
            italic=True,
            color=ft.Colors.GREY_600,
            text_align=ft.TextAlign.CENTER,
            visible=False,
        )

        self.content = ft.Column(
            controls=[
                self._ft_phase_label,
                ft.Container(height=16),
                self._ft_image_container,
                ft.Container(height=16),
                self._ft_word_switcher,
                ft.Container(height=18),
                self._ft_translation,
                self._ft_pronunciation,
            ],
            horizontal_alignment=ft.CrossAxisAlignment.CENTER,
            alignment=ft.MainAxisAlignment.CENTER,
            spacing=0,
        )
        self.alignment = ft.Alignment.CENTER
        self.padding = 40
        self.border_radius = 20
        self.bgcolor = ft.Colors.BLUE_50
        self.width = 820

    def render(
        self,
        text_es: str,
        text_lang: str,
        pronunciation: str,
        show_translation: bool,
        phase_label: str,
        word_key: str,
        image_file_path: str = "",
    ) -> None:
        """Actualiza la tarjeta. Anima/actualiza la imagen solo al cambiar de palabra."""
        self._ft_phase_label.value = phase_label

        # Animar la palabra ES y refrescar imagen solo cuando cambia la palabra
        if word_key != self._current_key:
            self._current_key = word_key
            self._ft_word_switcher.content = ft.Text(
                text_es,
                key=word_key,
                size=self._WORD_SIZE,
                weight=ft.FontWeight.BOLD,
                color=ft.Colors.BLUE_900,
                text_align=ft.TextAlign.CENTER,
            )
            full_image_path = self._get_full_image_path(image_file_path)
            self._ft_image.src = full_image_path
            self._ft_image_container.visible = bool(full_image_path)

        self._ft_translation.value = text_lang
        self._ft_translation.visible = show_translation

        self._ft_pronunciation.value = f"/{pronunciation}/" if pronunciation else ""
        self._ft_pronunciation.visible = show_translation and bool(pronunciation)

    def _get_full_image_path(self, image_file_path: str) -> str:
        """Construye la ruta completa de la imagen (base: data/images)."""
        if not image_file_path:
            return ""

        base_path = Path(__file__).parent.parent.parent.parent.parent.parent / "data" / "images"
        return str(base_path / image_file_path)
