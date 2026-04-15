"""Learn Languages - Aplicación de aprendizaje de idiomas con repetición espaciada."""

import sys
import flet as ft

# Fix encoding for Windows console
if sys.platform == "win32":
    sys.stdout.reconfigure(encoding='utf-8', errors='replace')
    sys.stderr.reconfigure(encoding='utf-8', errors='replace')

from ddd.shared.infrastructure.repositories.sqlite_connection import SqliteConnection
from ddd.vocabulary.infrastructure.ui.views.home_view import HomeView
from ddd.vocabulary.infrastructure.ui.views.study_view import StudyView
from ddd.vocabulary.infrastructure.ui.views.word_crud_view import WordCrudView
from ddd.vocabulary.infrastructure.ui.views.create_word_view import CreateWordView


async def main(page: ft.Page) -> None:
    """Entry point de la aplicación Flet."""

    # Configuración de la página
    page.title = "Learn Languages"
    page.theme_mode = ft.ThemeMode.LIGHT
    page.window.width = 900
    page.window.height = 700
    page.window.min_width = 600
    page.window.min_height = 500
    page.padding = 0

    # Inicializar base de datos
    sqlite = SqliteConnection.get_instance()
    await sqlite.initialize_database()

    # Estado de navegación
    current_view = "home"

    # Contenedor principal
    content_area = ft.Container(expand=True)

    def navigate_to(view_name: str, **kwargs) -> None:
        """Navega a una vista específica."""
        nonlocal current_view
        current_view = view_name

        if view_name == "home":
            content_area.content = HomeView(
                on_start_study=lambda lang, tags: navigate_to("study", lang_code=lang, tags=tags),
                on_manage_words=lambda: navigate_to("words"),
            )
        elif view_name == "study":
            content_area.content = StudyView(
                lang_code=kwargs.get("lang_code", "nl_NL"),
                tags=kwargs.get("tags", []),
                on_back=lambda: navigate_to("home"),
            )
        elif view_name == "words":
            content_area.content = WordCrudView(
                on_back=lambda: navigate_to("home"),
                on_create=lambda: navigate_to("create_word"),
            )
        elif view_name == "create_word":
            content_area.content = CreateWordView(
                on_back=lambda: navigate_to("words"),
                on_word_created=lambda: None,  # Stay in create view for batch adding
            )

        page.update()

    # Navegación inicial
    navigate_to("home")

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
                                "Learn Languages",
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
