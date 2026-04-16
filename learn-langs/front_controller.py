"""Learn Languages - Aplicacion de aprendizaje de idiomas con repeticion espaciada."""

import sys
import flet as ft

# Fix encoding for Windows console
if sys.platform == "win32":
    sys.stdout.reconfigure(encoding='utf-8', errors='replace')
    sys.stderr.reconfigure(encoding='utf-8', errors='replace')

from ddd.shared.infrastructure.repositories.sqlite_connection import SqliteConnection
from ddd.shared.domain.enums import ViewRouteEnum
from ddd.vocabulary.domain.enums import LanguageCodeEnum
from ddd.vocabulary.infrastructure.ui.views import (
    HomeView,
    StudyView,
    CreateWordView,
    UpdateWordView,
    ListWordsView,
)


# Constantes de la aplicacion
APP_TITLE = "Learn Languages"
WINDOW_WIDTH = 900
WINDOW_HEIGHT = 700
WINDOW_MIN_WIDTH = 600
WINDOW_MIN_HEIGHT = 500


async def main(page: ft.Page) -> None:
    """Entry point de la aplicacion Flet."""

    # Configuracion de la pagina
    page.title = APP_TITLE
    page.theme_mode = ft.ThemeMode.LIGHT
    page.window.width = WINDOW_WIDTH
    page.window.height = WINDOW_HEIGHT
    page.window.min_width = WINDOW_MIN_WIDTH
    page.window.min_height = WINDOW_MIN_HEIGHT
    page.padding = 0

    # Inicializar base de datos
    sqlite = SqliteConnection.get_instance()
    await sqlite.initialize_database()

    # Estado de navegacion
    current_view: ViewRouteEnum = ViewRouteEnum.HOME

    # Contenedor principal
    content_area = ft.Container(expand=True)

    def navigate_to(view_name: ViewRouteEnum | str, **kwargs) -> None:
        """Navega a una vista especifica."""
        nonlocal current_view

        # Convertir string a enum si es necesario
        if isinstance(view_name, str):
            view_name = ViewRouteEnum(view_name)

        current_view = view_name

        if view_name == ViewRouteEnum.HOME:
            content_area.content = HomeView(
                on_start_study=lambda lang, tags: navigate_to(ViewRouteEnum.STUDY, lang_code=lang, tags=tags),
                on_manage_words=lambda: navigate_to(ViewRouteEnum.WORDS),
            )
        elif view_name == ViewRouteEnum.STUDY:
            content_area.content = StudyView(
                lang_code=kwargs.get("lang_code", LanguageCodeEnum.default()),
                tags=kwargs.get("tags", []),
                on_back=lambda: navigate_to(ViewRouteEnum.HOME),
            )
        elif view_name == ViewRouteEnum.WORDS:
            content_area.content = ListWordsView(
                on_back=lambda: navigate_to(ViewRouteEnum.HOME),
                on_create=lambda: navigate_to(ViewRouteEnum.CREATE_WORD),
                on_edit=lambda word_id: navigate_to(ViewRouteEnum.UPDATE_WORD, word_id=word_id),
            )
        elif view_name == ViewRouteEnum.CREATE_WORD:
            content_area.content = CreateWordView(
                on_back=lambda: navigate_to(ViewRouteEnum.WORDS),
                on_word_created=lambda: None,  # Stay in create view for batch adding
            )
        elif view_name == ViewRouteEnum.UPDATE_WORD:
            content_area.content = UpdateWordView(
                word_id=kwargs.get("word_id", 0),
                on_back=lambda: navigate_to(ViewRouteEnum.WORDS),
                on_word_updated=lambda: None,
            )

        page.update()

    # Navegacion inicial
    navigate_to(ViewRouteEnum.HOME)

    # Layout principal
    page.add(
        ft.Column(
            controls=[
                # Header
                ft.Container(
                    content=ft.Row(
                        controls=[
                            ft.Icon(ft.Icons.SCHOOL, size=32, color=ft.Colors.WHITE),
                            ft.Text(
                                APP_TITLE,
                                size=24,
                                weight=ft.FontWeight.BOLD,
                                color=ft.Colors.WHITE,
                            ),
                        ],
                        alignment=ft.MainAxisAlignment.CENTER,
                    ),
                    bgcolor=ft.Colors.BLUE_700,
                    padding=16,
                ),
                # Content
                content_area,
            ],
            spacing=0,
            expand=True,
        )
    )


if __name__ == "__main__":
    ft.run(main)
