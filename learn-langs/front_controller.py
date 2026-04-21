"""Learn Languages - Aplicacion de aprendizaje de idiomas con repeticion espaciada."""

import sys
import flet as ft

# Fix encoding for Windows console
if sys.platform == "win32":
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    sys.stderr.reconfigure(encoding="utf-8", errors="replace")

from ddd.shared.domain.enums import ControllerRouteEnum
from ddd.devops.application.run_migrations import RunMigrationsDto, RunMigrationsService

from ddd.vocabulary.domain.enums import LanguageCodeEnum
from ddd.vocabulary.application.get_app_config import GetAppConfigService
from ddd.vocabulary.infrastructure.ui.views import (
    HomeController,
    StudyView,
    CreateWordView,
    UpdateWordView,
    ListWordsView,
)


async def fn_render(ft_page: ft.Page) -> None:
    """Entry point de la aplicacion Flet."""

    app_config = GetAppConfigService.get_instance()()

    ft_page.title = app_config.app_title
    ft_page.theme_mode = ft.ThemeMode.LIGHT
    ft_page.window.width = app_config.window_width
    ft_page.window.height = app_config.window_height
    ft_page.window.min_width = app_config.window_min_width
    ft_page.window.min_height = app_config.window_min_height
    ft_page.padding = 0

    # Inicializar base de datos (force=True para reset completo)
    await RunMigrationsService.get_instance()(
        RunMigrationsDto.from_primitives({
            "migrations_path": app_config.migrations_path,
            "force": False,
        })
    )

    # Estado de navegacion
    current_view: ControllerRouteEnum = ControllerRouteEnum.HOME
    ft_container = ft.Container(expand=True)

    def navigate_to(
        route_name: ControllerRouteEnum | str,
        **kwargs
    ) -> None:
        """Navega a una vista especifica."""
        nonlocal current_view

        # Convertir string a enum si es necesario
        if isinstance(route_name, str):
            route_name = ControllerRouteEnum(route_name)

        current_view = route_name

        if route_name == ControllerRouteEnum.HOME:
            ft_container.content = HomeController(
                on_start_study=lambda lang, tags: navigate_to(
                    ControllerRouteEnum.STUDY,
                    lang_code=lang,
                    tags=tags
                ),
                on_manage_words=lambda: navigate_to(
                    ControllerRouteEnum.WORDS
                ),
            )
        elif route_name == ControllerRouteEnum.STUDY:
            ft_container.content = StudyView(
                lang_code=kwargs.get("lang_code", LanguageCodeEnum.default()),
                tags=kwargs.get("tags", []),
                on_back=lambda: navigate_to(ControllerRouteEnum.HOME),
            )
        elif route_name == ControllerRouteEnum.WORDS:
            ft_container.content = ListWordsView(
                on_back=lambda: navigate_to(ControllerRouteEnum.HOME),
                on_create=lambda: navigate_to(ControllerRouteEnum.CREATE_WORD),
                on_edit=lambda word_id: navigate_to(ControllerRouteEnum.UPDATE_WORD, word_id=word_id),
            )
        elif route_name == ControllerRouteEnum.CREATE_WORD:
            ft_container.content = CreateWordView(
                on_back=lambda: navigate_to(ControllerRouteEnum.WORDS),
                on_word_created=lambda: None,  # Stay in create view for batch adding
            )
        elif route_name == ControllerRouteEnum.UPDATE_WORD:
            ft_container.content = UpdateWordView(
                word_id=kwargs.get("word_id", 0),
                on_back=lambda: navigate_to(ControllerRouteEnum.WORDS),
                on_word_updated=lambda: None,
            )

        ft_page.update()

    # Navegacion inicial
    navigate_to(ControllerRouteEnum.HOME)

    ft_page.add(
        ft.Column(
            controls=[
                # Header
                ft.Container(
                    content=ft.Row(
                        controls=[
                            ft.Icon(ft.Icons.SCHOOL, size=32, color=ft.Colors.WHITE),
                            ft.Text(
                                app_config.app_title,
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
                ft_container,
            ],
            spacing=0,
            expand=True,
        )
    )


if __name__ == "__main__":
    ft.run(fn_render)
