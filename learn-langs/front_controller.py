"""Learn Languages - Aplicacion de aprendizaje de idiomas con repeticion espaciada."""

import sys
import traceback

import flet as ft
from flet import app_async

# fix encoding for windows console
if sys.platform == "win32":
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    sys.stderr.reconfigure(encoding="utf-8", errors="replace")

from ddd.shared.domain.enums import ControllerRouteEnum
from ddd.shared.infrastructure.components.logger import Logger
from ddd.shared.infrastructure.components import AppRouter

from ddd.devops.application.run_migrations import RunMigrationsDto, RunMigrationsService

from ddd.vocabulary.application.get_app_config import GetAppConfigService


async def fn_render(
    ft_page: ft.Page
) -> None:
    """Entry point de la aplicacion Flet."""

    get_app_config_result_dto = GetAppConfigService.get_instance()()

    ft_page.title = get_app_config_result_dto.app_title
    ft_page.theme_mode = ft.ThemeMode.LIGHT
    ft_page.window.width = get_app_config_result_dto.window_width
    ft_page.window.height = get_app_config_result_dto.window_height
    ft_page.window.min_width = get_app_config_result_dto.window_min_width
    ft_page.window.min_height = get_app_config_result_dto.window_min_height

    await RunMigrationsService.get_instance()(
        RunMigrationsDto.from_primitives({
            "migrations_path": get_app_config_result_dto.migrations_path,
            "force": False,
        })
    )

    ft_container = ft.Container(expand=True)
    app_router = AppRouter(ft_page, ft_container)
    app_router.navigate_to(ControllerRouteEnum.HOME)

    ft_page.add(
        ft.Column(
            controls=[
                ft.Container(
                    content=ft.Row(
                        controls=[
                            ft.Icon(ft.Icons.SCHOOL, size=32, color=ft.Colors.WHITE),
                            ft.Text(
                                get_app_config_result_dto.app_title,
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
    try:
        ft.run(fn_render)
    except Exception as e:
        Logger.get_instance().write_error(
            module="front_controller.fn_render",
            message=str(e),
            context={"traceback": traceback.format_exc()},
        )
        raise
