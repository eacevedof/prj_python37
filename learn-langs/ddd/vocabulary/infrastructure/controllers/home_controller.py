"""Controller para el Home."""

from typing import Callable

import flet as ft

from ddd.shared.infrastructure.components.logger import Logger
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
        route_on_start_study: Callable[[str, list[str]], None],
        route_on_manage_words: Callable[[], None],
    ):
        # Lambdas de navegacion en app_router
        self._route_on_start_study = route_on_start_study
        self._route_on_manage_words = route_on_manage_words

        self._logger = Logger.get_instance()
        self._load_home_service = LoadHomeService.get_instance()

        self._selected_lang: LanguageCodeEnum = LanguageCodeEnum.default()
        self._selected_tags: list[str] = []

        self._ft_container = HomeView.from_primitives({
            "on_manage_words": self._route_on_manage_words,
            "on_start_study": self._route_on_start_study_click,
            "on_lang_change": self._on_lang_change,
            "on_tag_toggle": self._on_tag_toggle,
            "on_mount": self._on_mount,
        })

    @property
    def ft_container(self) -> ft.Container:
        """Vista para montar en el arbol de Flet."""
        return self._ft_container

    def _on_mount(self) -> None:
        """Callback cuando la vista se monta. Carga datos iniciales."""
        self._ft_container.page.run_task(self._async_load_data)

    async def _async_load_data(self) -> None:
        """Carga datos del servicio y actualiza la vista."""
        try:
            load_home_result_dto = await self._load_home_service(
                LoadHomeDto.from_primitives({
                    "lang_code": str(self._selected_lang),
                })
            )

            if not load_home_result_dto.success:
                self._ft_container.render(
                    HomeViewDto.error(
                        message=load_home_result_dto.error_message or "Error desconocido",
                        selected_lang_code=str(self._selected_lang),
                    )
                )
                return

            self._ft_container.render(
                HomeViewDto.ok(
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
            )


        except Exception as e:
            self._logger.write_error(
                "HomeController",
                f"Error cargando datos: {e}",
                {"lang_code": str(self._selected_lang)},
            )
            self._ft_container.render(
                HomeViewDto.error(
                    message=str(e),
                    selected_lang_code=str(self._selected_lang),
                )
            )

    def refresh(self) -> None:
        """Recarga datos. Usar para refresh externo si se necesita."""
        self._ft_container.page.run_task(self._async_load_data)

    def _on_lang_change(self, lang_code: str) -> None:
        """Maneja el cambio de idioma."""
        try:
            self._selected_lang = LanguageCodeEnum(lang_code)
        except ValueError:
            self._selected_lang = LanguageCodeEnum.default()

        self._ft_container.page.run_task(self._async_load_data)

    def _on_tag_toggle(self, tag_name: str) -> None:
        """Alterna la seleccion de un tag."""
        if tag_name in self._selected_tags:
            self._selected_tags.remove(tag_name)
        else:
            self._selected_tags.append(tag_name)

        self._ft_container.page.run_task(self._async_load_data)

    def _route_on_start_study_click(self) -> None:
        """Maneja click en comenzar estudio."""
        self._route_on_start_study(
            str(self._selected_lang),
            self._selected_tags
        )
