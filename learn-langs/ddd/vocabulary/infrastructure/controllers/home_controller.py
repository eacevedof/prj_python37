"""Controller para el Home."""

from typing import Callable

import flet as ft

from ddd.vocabulary.application.load_home import LoadHomeDto, LoadHomeService
from ddd.vocabulary.domain.enums import LanguageCodeEnum
from ddd.vocabulary.infrastructure.ui.views.home_view import HomeView
from ddd.vocabulary.infrastructure.ui.views.home_view_dto import HomeViewDto


class HomeController:
    """
    Controller del Home.

    Responsabilidades:
    - Orquestar flujo entre Vista y Servicios
    - Crear ViewDTOs y pasarlos a la Vista
    - Manejar callbacks de la Vista
    - NO hereda de ft.Container
    """

    def __init__(
        self,
        on_start_study: Callable[[str, list[str]], None],
        on_manage_words: Callable[[], None],
    ):
        # Lambdas de navegacion en app_router
        self._on_start_study = on_start_study
        self._on_manage_words = on_manage_words

        # Estado interno
        self._selected_lang: LanguageCodeEnum = LanguageCodeEnum.default()
        self._selected_tags: list[str] = []

        # Servicios
        self._load_home_service = LoadHomeService.get_instance()

        # Vista
        self._view = HomeView.from_primitives({
            "on_lang_change": self._handle_lang_change,
            "on_tag_toggle": self._handle_tag_toggle,
            "on_manage_words": self._on_manage_words,
            "on_start_study": lambda: self._on_start_study(
                str(self._selected_lang),
                self._selected_tags,
            ),
            "on_mount": self._handle_mount,
        })

    @property
    def view(self) -> ft.Container:
        """Vista para montar en el arbol de Flet."""
        return self._view

    def _handle_mount(self) -> None:
        """Callback cuando la vista se monta. Carga datos iniciales."""
        self._view.page.run_task(self._async_load_data)

    def refresh(self) -> None:
        """Recarga datos. Usar para refresh externo si se necesita."""
        self._view.page.run_task(self._async_load_data)

    async def _async_load_data(self) -> None:
        """Carga datos del servicio y actualiza la vista."""
        load_home_result_dto = await self._load_home_service(
            LoadHomeDto.from_primitives({
                "lang_code": str(self._selected_lang),
            })
        )

        if not load_home_result_dto.success:
            home_view_dto = HomeViewDto.error(
                message=load_home_result_dto.error_message or "Error desconocido",
                selected_lang_code=str(self._selected_lang),
            )
        else:
            home_view_dto = HomeViewDto.ok(
                tags=[
                    {"id": t.id, "name": t.name, "color": t.color}
                    for t in load_home_result_dto.tags
                ],
                stats={
                    "total_words": load_home_result_dto.stats.total_words,
                    "due_for_review": load_home_result_dto.stats.due_for_review,
                    "avg_score": load_home_result_dto.stats.avg_score,
                },
                selected_lang_code=str(self._selected_lang),
                selected_tags=self._selected_tags,
            )

        self._view.render(home_view_dto)

    def _handle_lang_change(self, lang_code: str) -> None:
        """Maneja el cambio de idioma."""
        try:
            self._selected_lang = LanguageCodeEnum(lang_code)
        except ValueError:
            self._selected_lang = LanguageCodeEnum.default()

        self._view.page.run_task(self._async_load_data)

    def _handle_tag_toggle(self, tag_name: str) -> None:
        """Alterna la seleccion de un tag."""
        if tag_name in self._selected_tags:
            self._selected_tags.remove(tag_name)
        else:
            self._selected_tags.append(tag_name)

        # Re-render con el nuevo estado
        self._view.page.run_task(self._async_load_data)
