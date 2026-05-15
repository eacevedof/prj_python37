"""Componente de flashcard con imagen para mostrar palabras."""

from pathlib import Path
import flet as ft


class ImageFlashcardComp(ft.Container):
    """Componente que muestra una imagen de palabra como flashcard."""

    def __init__(
        self,
        image_file_path: str,
        image_caption: str = "",
        text_lang: str = "",
        pronunciation: str = "",
        show_translation: bool = False,
    ):
        super().__init__()
        self.image_file_path = image_file_path
        self.image_caption = image_caption
        self.text_lang = text_lang
        self.pronunciation = pronunciation
        self.show_translation = show_translation
        self._card_content: ft.Column | None = None

        self._build_ui()

    def _build_ui(self) -> None:
        """Construye la UI del componente."""
        # Construir ruta completa de imagen
        full_image_path = self._get_full_image_path()

        # Imagen principal
        image_widget = ft.Image(
            src=full_image_path,
            width=250,
            height=250,
            fit=ft.BoxFit.CONTAIN,
            border_radius=8,
        )

        # Contenido de la tarjeta
        card_controls = [
            ft.Container(
                content=image_widget,
                alignment=ft.Alignment.CENTER,
            ),
        ]

        # Caption si existe
        if self.image_caption:
            card_controls.append(
                ft.Text(
                    self.image_caption,
                    size=12,
                    italic=True,
                    color=ft.Colors.GREY_600,
                    text_align=ft.TextAlign.CENTER,
                )
            )

        # Mostrar traducción si está habilitado
        if self.show_translation and self.text_lang:
            card_controls.extend([
                ft.Container(height=16),
                ft.Divider(height=1, color=ft.Colors.GREY_300),
                ft.Container(height=12),
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
        self.width = 350
        self.height = 380
        self.bgcolor = ft.Colors.WHITE
        self.border_radius = 16
        self.padding = 16
        self.shadow = ft.BoxShadow(
            spread_radius=1,
            blur_radius=15,
            color=ft.Colors.with_opacity(0.2, ft.Colors.BLACK),
            offset=ft.Offset(0, 4),
        )
        self.alignment = ft.Alignment.CENTER

    def _get_full_image_path(self) -> str:
        """Construye la ruta completa de la imagen."""
        if not self.image_file_path:
            return ""

        # Ruta base: C:\projects\prj_python37\learn-langs\data\images
        base_path = Path(__file__).parent.parent.parent.parent.parent.parent / "data" / "images"
        full_path = base_path / self.image_file_path
        return str(full_path)

    def reveal_translation(self) -> None:
        """Muestra la traducción."""
        self.show_translation = True
        if self._card_content and self.text_lang:
            self._card_content.controls.extend([
                ft.Container(height=16),
                ft.Divider(height=1, color=ft.Colors.GREY_300),
                ft.Container(height=12),
                ft.Text(
                    self.text_lang,
                    size=28,
                    weight=ft.FontWeight.W_500,
                    color=ft.Colors.GREEN_700,
                    text_align=ft.TextAlign.CENTER,
                ),
            ])

            if self.pronunciation:
                self._card_content.controls.append(
                    ft.Text(
                        f"/{self.pronunciation}/",
                        size=16,
                        italic=True,
                        color=ft.Colors.GREY_600,
                        text_align=ft.TextAlign.CENTER,
                    )
                )

            self.update()

    def set_result_style(self, is_correct: bool) -> None:
        """Aplica estilo según resultado."""
        if is_correct:
            self.border = ft.border.all(3, ft.Colors.GREEN_500)
        else:
            self.border = ft.border.all(3, ft.Colors.RED_500)
        self.update()
