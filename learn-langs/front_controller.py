"""Learn Languages - Aplicacion de aprendizaje de idiomas con repeticion espaciada."""

import sys
import traceback

import flet as ft

# fix encoding for windows console
if sys.platform == "win32":
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    sys.stderr.reconfigure(encoding="utf-8", errors="replace")

# Los imports de la app pueden fallar en el APK (deps/plataforma). Se capturan para
# poder pintarlos en pantalla: en el APK no hay consola ni logs legibles (no debuggable).
_import_error: str | None = None
try:
    from ddd.shared.domain.enums import ControllerRouteEnum  # noqa: E402
    from ddd.shared.infrastructure.components.logger import Logger  # noqa: E402
    from ddd.shared.infrastructure.components.app_router import AppRouter  # noqa: E402
    from ddd.shared.infrastructure.components.system.awaker import Awaker  # noqa: E402
    from ddd.devops.application.run_migrations import (  # noqa: E402
        RunMigrationsDto,
        RunMigrationsService,
    )
    from ddd.vocabulary.application.get_app_config import GetAppConfigService  # noqa: E402
except Exception:
    _import_error = traceback.format_exc()


def _render_startup_error(ft_page: ft.Page, detail: str) -> None:
    """Pinta un error de arranque en pantalla (evita la pantalla en blanco muda)."""
    ft_page.controls.clear()
    ft_page.add(
        ft.Column(
            controls=[
                ft.Text(
                    "ERROR DE ARRANQUE",
                    color=ft.Colors.RED,
                    weight=ft.FontWeight.BOLD,
                    size=16,
                ),
                ft.Text(detail, selectable=True, size=10),
            ],
            scroll=ft.ScrollMode.AUTO,
            expand=True,
        )
    )
    ft_page.update()


async def _fn_run_migrations() -> None:
    get_app_config_result_dto = GetAppConfigService.get_instance()()
    await RunMigrationsService.get_instance()(
        RunMigrationsDto.from_primitives({
            "migrations_path": get_app_config_result_dto.migrations_path,
            "force": False,
        })
    )


async def fn_render(ft_page: ft.Page) -> None:
    """Entry point de la aplicacion Flet."""
    if _import_error is not None:
        _render_startup_error(ft_page, "IMPORT ERROR:\n" + _import_error)
        return
    try:
        await _fn_run_migrations()

        get_app_config_result_dto = GetAppConfigService.get_instance()()

        # Configurar error handler global para loguear errores no manejados
        def on_error(e: ft.ControlEvent):
            """Captura y loguea errores no manejados en event handlers."""
            logger = Logger.get_instance()
            error_data = e.data if hasattr(e, 'data') else str(e)
            logger.log_error(
                module="flet.event_handler",
                message=f"Unhandled error in Flet event handler: {error_data}",
                context={"traceback": traceback.format_exc()},
            )

        ft_page.on_error = on_error

        ft_page.theme_mode = ft.ThemeMode.LIGHT
        ft_page.title = get_app_config_result_dto.app_title
        ft_page.window.width = get_app_config_result_dto.window_width
        ft_page.window.height = get_app_config_result_dto.window_height
        ft_page.window.min_width = get_app_config_result_dto.window_min_width
        ft_page.window.min_height = get_app_config_result_dto.window_min_height
        # Arrancar ocupando toda la pantalla disponible (el tamaño de config
        # queda como tamaño al restaurar la ventana)
        ft_page.window.maximized = True

        Awaker.get_instance().keep_awake()

        ft_container = ft.Container(expand=True)
        app_router = AppRouter(ft_page, ft_container)
        app_router.navigate_to(ControllerRouteEnum.HOME)

        ft_page.controls.clear()
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
        ft_page.update()
    except Exception as startup_error:
        # En vez de pantalla en blanco silenciosa, pinta el error EN PANTALLA.
        detail = traceback.format_exc()
        try:
            Logger.get_instance().log_error(
                module="front_controller.fn_render",
                message=str(startup_error),
                context={"traceback": detail},
            )
        except Exception:
            pass
        _render_startup_error(ft_page, detail)


# En el APK serious_python ejecuta el modulo con runpy.run_module(run_name="__main__"),
# asi que el guard clasico funciona igual que en escritorio (verificado 2026-08-04).
if __name__ == "__main__":
    ft.run(fn_render)
