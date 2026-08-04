"""Componente: tarjeta animada del slider (imagen + palabra ES + traducción)."""

from pathlib import Path

import flet as ft

from ddd.vocabulary.infrastructure.ui.components.ui_scale import get_page_size
from ddd.vocabulary.infrastructure.ui.enums.slider_card_size_enum import SliderCardSizeEnum


class SliderCardComp(ft.Container):
    """
    Tarjeta del slider, pensada para verse a distancia (modo kiosko).

    Responsabilidades:
    - Mostrar la imagen de la palabra (si existe), a la izquierda
    - Mostrar la palabra en español en MUY grande, animada al cambiar de palabra
    - Revelar la traducción y pronunciación en la fase del idioma destino
    - Indicar visualmente la fase de reproducción actual (audio)
    - NO tiene lógica de negocio

    Layout horizontal (imagen | texto) para aprovechar el ancho de la ventana
    y evitar que el contenido se corte en alto.
    """

    def __init__(self) -> None:
        super().__init__()

        # Clave de la palabra actualmente mostrada (para no re-animar entre fases)
        self.__current_key: str = ""

        # Escala de tamaños según la página real (1.0 = escritorio/kiosko;
        # en tablet encoge para que quepa todo) y layout vertical en retrato
        self.__scale: float = 1.0
        self.__is_vertical_layout: bool = False

        # Etiqueta de fase (qué se está pronunciando)
        self._ft_phase_label = ft.Text(
            "",
            size=SliderCardSizeEnum.PHASE.value,
            weight=ft.FontWeight.W_500,
            color=ft.Colors.BLUE_700,
            text_align=ft.TextAlign.CENTER,
        )

        # Id de la palabra (pequeño, para depurar qué audio no se generó/suena)
        self._ft_word_id = ft.Text(
            "",
            size=16,
            color=ft.Colors.GREY_400,
            weight=ft.FontWeight.W_500,
        )

        # Imagen de la palabra (opcional) - a la izquierda
        self._ft_image = ft.Image(
            src="",
            width=SliderCardSizeEnum.IMAGE.value,
            height=SliderCardSizeEnum.IMAGE.value,
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
            size=SliderCardSizeEnum.TRANSLATION.value,
            weight=ft.FontWeight.W_400,
            color=ft.Colors.BLUE_100,  # muy tenue, casi del color de fondo (BLUE_50)
            text_align=ft.TextAlign.CENTER,
            visible=False,
        )
        self._ft_pronunciation = ft.Text(
            "",
            size=SliderCardSizeEnum.PRONUNCIATION.value,
            italic=True,
            color=ft.Colors.GREY_600,
            text_align=ft.TextAlign.CENTER,
            visible=False,
        )

        # Ejemplos de uso (se revelan en la fase final, antes de la siguiente
        # palabra): enumerados con tipo de frase, neerlandés en negrita y
        # traducción gris pegada debajo
        self._ft_examples_column = ft.Column(
            controls=[],
            spacing=6,
            horizontal_alignment=ft.CrossAxisAlignment.CENTER,
            visible=False,
        )

        # Columna de texto (palabra ES + traducción + pronunciación + ejemplos) - a la derecha
        self._ft_text_column = ft.Column(
            controls=[
                self._ft_word_switcher,
                ft.Container(height=12),
                self._ft_translation,
                self._ft_pronunciation,
                ft.Container(height=4),
                self._ft_examples_column,
            ],
            horizontal_alignment=ft.CrossAxisAlignment.CENTER,
            alignment=ft.MainAxisAlignment.CENTER,
            spacing=0,
            expand=True,
        )

        # Cuerpo horizontal: imagen | texto (aprovecha el ancho de la ventana).
        # En retrato (tablet) se apila en vertical vía _apply_responsive_layout.
        self._ft_body_row = ft.Row(
            controls=[
                self._ft_image_container,
                self._ft_text_column,
            ],
            alignment=ft.MainAxisAlignment.CENTER,
            vertical_alignment=ft.CrossAxisAlignment.CENTER,
            spacing=48,
        )
        self._ft_body_holder = ft.Container(content=self._ft_body_row)

        self.content = ft.Column(
            controls=[
                ft.Row(
                    controls=[ft.Container(expand=True), self._ft_word_id],
                    alignment=ft.MainAxisAlignment.END,
                ),
                self._ft_phase_label,
                ft.Container(height=16),
                self._ft_body_holder,
            ],
            horizontal_alignment=ft.CrossAxisAlignment.CENTER,
            alignment=ft.MainAxisAlignment.CENTER,
            spacing=0,
            scroll=ft.ScrollMode.AUTO,
        )
        self.alignment = ft.Alignment.CENTER
        self.padding = 40
        self.border_radius = 20
        self.bgcolor = ft.Colors.BLUE_50
        self.expand = True

    def render(
        self,
        text_es: str,
        text_lang: str,
        pronunciation: str,
        show_translation: bool,
        phase_label: str,
        word_key: str,
        image_file_path: str = "",
        word_id: int | str = "",
        examples: str = "",
        show_examples: bool = False,
    ) -> None:
        """Actualiza la tarjeta. Anima/actualiza la imagen solo al cambiar de palabra."""
        self._apply_responsive_sizes()
        self._apply_responsive_layout()

        self._ft_phase_label.value = phase_label
        self._ft_word_id.value = f"#{word_id}" if word_id != "" else ""

        # Animar la palabra ES y refrescar imagen solo cuando cambia la palabra
        if word_key != self.__current_key:
            self.__current_key = word_key
            self._ft_word_switcher.content = ft.Text(
                text_es,
                key=word_key,
                size=round(SliderCardSizeEnum.WORD.value * self.__scale),
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

        self._render_examples(examples, show_examples)

    def _apply_responsive_sizes(self) -> None:
        """Recalcula la escala según el tamaño real de la página y la aplica.

        1.0 en escritorio (los tamaños del enum son para kiosko); en pantallas
        pequeñas (tablet) encoge proporcionalmente para que el contenido quepa.
        """
        page_width, page_height = get_page_size(self)
        if not page_width or not page_height:
            return

        scale = max(0.4, min(1.0, page_width / 1280, page_height / 900))
        if abs(scale - self.__scale) < 0.05:
            return
        self.__scale = scale

        self._ft_phase_label.size = round(SliderCardSizeEnum.PHASE.value * scale)
        self._ft_translation.size = round(SliderCardSizeEnum.TRANSLATION.value * scale)
        self._ft_pronunciation.size = round(SliderCardSizeEnum.PRONUNCIATION.value * scale)
        self._ft_image.width = round(SliderCardSizeEnum.IMAGE.value * scale)
        self._ft_image.height = round(SliderCardSizeEnum.IMAGE.value * scale)
        self.padding = round(40 * scale)
        # La palabra ES se re-crea al cambiar de palabra; refrescar la actual
        if isinstance(self._ft_word_switcher.content, ft.Text):
            self._ft_word_switcher.content.size = round(SliderCardSizeEnum.WORD.value * scale)

    def _apply_responsive_layout(self) -> None:
        """En retrato (ancho < alto) apila imagen y texto en vertical; en
        apaisado/escritorio mantiene el layout horizontal imagen | texto."""
        page_width, page_height = get_page_size(self)
        if not page_width or not page_height:
            return

        vertical = page_width < page_height
        if vertical == self.__is_vertical_layout:
            return
        self.__is_vertical_layout = vertical

        # Re-parentar imagen/texto: vaciar SIEMPRE el contenedor anterior
        if vertical:
            self._ft_body_row.controls = []
            self._ft_text_column.expand = False  # en columna, alto intrínseco
            self._ft_body_holder.content = ft.Column(
                controls=[self._ft_image_container, self._ft_text_column],
                horizontal_alignment=ft.CrossAxisAlignment.CENTER,
                spacing=16,
            )
        else:
            self._ft_text_column.expand = True
            self._ft_body_row.controls = [self._ft_image_container, self._ft_text_column]
            self._ft_body_holder.content = self._ft_body_row

    def _render_examples(self, examples: str, show_examples: bool) -> None:
        """Renderiza los ejemplos: número + tipo en pequeño, ESPAÑOL en negrita
        (el reto a traducir) y la solución en neerlandés en gris pegada debajo."""
        self._ft_examples_column.controls.clear()
        example_items = self._get_example_items(examples) if show_examples else []
        self._ft_examples_column.visible = bool(example_items)

        for example_number, (type_tag, text_lang, text_es) in enumerate(example_items, start=1):
            number_and_tag = f"{example_number}. {type_tag}" if type_tag else f"{example_number}."
            # El español manda (negrita); si la línea no trae traducción, se
            # muestra el neerlandés como texto principal
            main_text = text_es or text_lang
            solution_text = text_lang if text_es else ""

            # Los ejemplos ya son pequeños: se encogen menos (suelo de legibilidad)
            header_row = ft.Row(
                controls=[
                    ft.Text(
                        number_and_tag,
                        size=max(10, round(SliderCardSizeEnum.EXAMPLES_TAG.value * self.__scale)),
                        italic=True,
                        color=ft.Colors.GREY_500,
                    ),
                    ft.Text(
                        main_text,
                        size=max(14, round(SliderCardSizeEnum.EXAMPLES.value * self.__scale)),
                        weight=ft.FontWeight.BOLD,
                        color=ft.Colors.BLUE_GREY_900,
                    ),
                ],
                spacing=6,
                alignment=ft.MainAxisAlignment.CENTER,
                vertical_alignment=ft.CrossAxisAlignment.CENTER,
            )

            pair_controls: list[ft.Control] = [header_row]
            if solution_text:
                pair_controls.append(
                    ft.Text(
                        solution_text,
                        size=max(11, round(SliderCardSizeEnum.EXAMPLES_TRANSLATION.value * self.__scale)),
                        color=ft.Colors.GREY_600,
                        text_align=ft.TextAlign.CENTER,
                    )
                )
            self._ft_examples_column.controls.append(
                ft.Column(
                    controls=pair_controls,
                    spacing=0,
                    horizontal_alignment=ft.CrossAxisAlignment.CENTER,
                )
            )

    @staticmethod
    def _get_example_items(examples: str) -> list[tuple[str, str, str]]:
        """Parsea '• [tipo] zin — traducción' en (tipo, nl, es); tipo opcional."""
        example_items: list[tuple[str, str, str]] = []
        for raw_line in examples.splitlines():
            line = raw_line.strip()
            while line and line[0] in "•-*":
                line = line[1:].strip()
            if not line:
                continue
            type_tag = ""
            if line.startswith("[") and "]" in line:
                type_tag, line = line[1:].split("]", 1)
                type_tag = type_tag.strip()
                line = line.strip()
            if "—" in line:
                text_lang, text_es = line.split("—", 1)
                example_items.append((type_tag, text_lang.strip(), text_es.strip()))
            else:
                example_items.append((type_tag, line, ""))
        return example_items

    def _get_full_image_path(self, image_file_path: str) -> str:
        """Construye la ruta completa de la imagen (base: data/images)."""
        if not image_file_path:
            return ""

        base_path = Path(__file__).parent.parent.parent.parent.parent.parent / "data" / "images"
        return str(base_path / image_file_path)
