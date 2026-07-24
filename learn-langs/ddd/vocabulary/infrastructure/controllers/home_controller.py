"""Controller para el Home."""

from typing import Callable

import flet as ft

from ddd.shared.infrastructure.components.logger import Logger
from ddd.shared.infrastructure.controllers import BaseController
from ddd.vocabulary.application.get_last_activity_state import (
    GetLastActivityStateService,
)
from ddd.vocabulary.application.load_home import LoadHomeDto, LoadHomeService
from ddd.vocabulary.domain.enums import ActivityEnum, LanguageCodeEnum
from ddd.vocabulary.infrastructure.repositories import WordGroupsReaderSqliteRepository
from ddd.vocabulary.infrastructure.ui.views.home_view import HomeView
from ddd.vocabulary.infrastructure.ui.views.home_view_dto import HomeViewDto


class HomeController(BaseController):
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
        route_on_resume: Callable[
            [dict], None
        ],  # 1. Botón continuar (teal, si hay estado)
        route_on_start_image_study: Callable[
            [str, list[str], int | None], None
        ],  # 2. Botón secundario (morado, centro)
        route_on_start_slider: Callable[
            [str, list[str], int | None, bool], None
        ],  # 3. Botón Aprendizaje (verde) + orden aleatorio
        route_on_manage_words: Callable[
            [], None
        ],  # 4. Botón gestión palabras (amarillo)
        route_on_manage_groups: Callable[[], None],  # 5. Botón gestión grupos (naranja)
    ):
        # Callbacks de navegación (inyectados desde app_router)
        self._route_on_resume = route_on_resume
        self._route_on_start_image_study = route_on_start_image_study
        self._route_on_start_slider = route_on_start_slider
        self._route_on_manage_words = route_on_manage_words
        self._route_on_manage_groups = route_on_manage_groups

        self._logger = Logger.get_instance()
        self._load_home_service = LoadHomeService.get_instance()
        self._get_last_activity_state_service = (
            GetLastActivityStateService.get_instance()
        )
        self._word_groups_reader_sqlite_repository = (
            WordGroupsReaderSqliteRepository.get_instance()
        )

        self.__selected_lang: LanguageCodeEnum = LanguageCodeEnum.NL_NL
        self.__selected_tags: list[str] = []
        self.__selected_group_id: int | None = None
        self.__all_groups: list[dict] = []
        self.__resume_state: dict | None = None

        self._ft_container = HomeView.from_primitives(
            {
                "on_mount": self._on_mount,
                "on_lang_change": self._on_lang_change,
                "on_group_change": self._on_group_change,
                "on_tag_toggle": self._on_tag_toggle,
                "on_resume": self._route_on_resume_click,
                "on_start_image_study": self._route_on_start_image_study_click,
                "on_start_slider": self._route_on_start_slider_click,
                "on_manage_words": self._route_on_manage_words,
                "on_manage_groups": self._route_on_manage_groups,
            }
        )

    # =========================================================================
    # API PÚBLICA
    # =========================================================================
    # app_router.invoked
    @property
    def ft_container(self) -> ft.Container:
        """Vista para montar en el arbol de Flet."""
        return self._ft_container

    def refresh(self) -> None:
        """Recarga datos. Usar para refresh externo si se necesita."""
        self._ft_container.page.run_task(self._async_load_data)

    # =========================================================================
    # LIFECYCLE & CARGA DE DATOS
    # =========================================================================
    def _on_mount(self) -> None:
        """Callback cuando la vista se monta. Carga datos iniciales."""
        self._ft_container.page.run_task(self._async_load_data)

    async def _async_load_data(self) -> None:
        """Carga datos del servicio y actualiza la vista."""
        try:
            load_home_result_dto = await self._load_home_service(
                LoadHomeDto.from_primitives(
                    {
                        "lang_code": str(self.__selected_lang),
                    }
                )
            )

            if not load_home_result_dto.success:
                self._ft_container.render(
                    HomeViewDto.error(
                        message=load_home_result_dto.error_message
                        or "Error desconocido",
                        selected_lang_code=str(self.__selected_lang),
                    )
                )
                return

            # Cargar grupos disponibles
            all_groups_raw = (
                await self._word_groups_reader_sqlite_repository.get_all_word_groups()
            )

            # Ordenar grupos: generic al final, resto por ID desc
            generic_group = None
            other_groups = []
            for group in all_groups_raw:
                if group.get("title", "").lower() == "generic":
                    generic_group = group
                else:
                    other_groups.append(group)

            # Ordenar otros grupos por ID descendente
            other_groups.sort(key=lambda g: g.get("id", 0), reverse=True)

            # Construir lista final: otros grupos + generic al final
            self.__all_groups = other_groups + ([generic_group] if generic_group else [])

            # Si no hay grupo seleccionado, seleccionar el primero de la lista ordenada
            if self.__selected_group_id is None and self.__all_groups:
                self.__selected_group_id = self.__all_groups[0].get("id", 0)

            # Última actividad reanudable (botón Continuar)
            self.__resume_state = await self._get_resume_state()

            self._ft_container.render(
                HomeViewDto.ok(
                    tags=list(load_home_result_dto.tags),
                    stats=load_home_result_dto.stats,
                    selected_lang_code=str(self.__selected_lang),
                    selected_tags=self.__selected_tags,
                    groups=self.__all_groups,
                    selected_group_id=self.__selected_group_id,
                    resume_state=self.__resume_state,
                )
            )

        except Exception as e:
            self._logger.log_error(
                "HomeController",
                f"Error cargando datos: {e}",
                {"lang_code": str(self.__selected_lang)},
            )
            self._ft_container.render(
                HomeViewDto.error(
                    message=str(e),
                    selected_lang_code=str(self.__selected_lang),
                )
            )

    # =========================================================================
    # EVENT HANDLERS (orden visual/lógico de arriba a abajo en UI)
    # =========================================================================
    def _on_lang_change(self, lang_code: str) -> None:
        """Maneja el cambio de idioma (dropdown - arriba en UI)."""
        try:
            self.__selected_lang = LanguageCodeEnum(lang_code)
        except ValueError:
            self.__selected_lang = LanguageCodeEnum.NL_NL

        self._ft_container.page.run_task(self._async_load_data)

    def _on_group_change(self, group_id: int) -> None:
        """Maneja el cambio de grupo (dropdown - arriba en UI)."""
        self.__selected_group_id = group_id
        # DEBUG: Log del cambio de grupo
        self._logger.log_debug(
            "HomeController",
            f"Group changed to group_id={group_id}",
            {"group_id": group_id},
        )
        # No es necesario recargar datos, solo actualizar el estado

    def _on_tag_toggle(self, tag_name: str) -> None:
        """Alterna la seleccion de un tag (chips - medio en UI)."""
        if tag_name in self.__selected_tags:
            self.__selected_tags.remove(tag_name)
        else:
            self.__selected_tags.append(tag_name)

        self._ft_container.page.run_task(self._async_load_data)

    def _route_on_resume_click(self) -> None:
        """Maneja click en Continuar: retoma la última actividad guardada."""
        if not self.__resume_state:
            return
        self._route_on_resume(self.__resume_state)

    async def _get_resume_state(self) -> dict | None:
        """Carga el último estado de actividad y lo enriquece para la vista."""
        try:
            last_state = await self._get_last_activity_state_service()
        except Exception as e:
            self._logger.log_error(
                "HomeController",
                f"Error cargando estado de actividad: {e}",
            )
            return None

        if not last_state.has_state:
            return None

        try:
            activity_label = ActivityEnum(last_state.activity).display_name
        except ValueError:
            activity_label = last_state.activity

        group_title = next(
            (
                str(group.get("title", ""))
                for group in self.__all_groups
                if group.get("id") == last_state.group_id
            ),
            "",
        )

        return {
            **last_state.to_dict(),
            "activity_label": activity_label,
            "group_title": group_title,
        }

    def _route_on_start_image_study_click(self) -> None:
        """Maneja click en comenzar estudio con imagenes (boton morado - abajo en UI)."""
        # Leer el valor actual del dropdown (workaround para on_change que no se dispara)
        actual_group_id = self._ft_container.get_selected_group_id()
        if actual_group_id is not None:
            self.__selected_group_id = actual_group_id

        # DEBUG: Log del group_id seleccionado
        self._logger.log_debug(
            "HomeController",
            f"Starting image study with group_id={self.__selected_group_id}",
            {
                "lang": str(self.__selected_lang),
                "tags": self.__selected_tags,
                "group_id": self.__selected_group_id,
            },
        )
        self._route_on_start_image_study(
            str(self.__selected_lang), self.__selected_tags, self.__selected_group_id
        )

    def _route_on_start_slider_click(self) -> None:
        """Maneja click en Aprendizaje (boton verde - abajo en UI)."""
        # Leer el valor actual del dropdown (workaround para on_change que no se dispara)
        actual_group_id = self._ft_container.get_selected_group_id()
        if actual_group_id is not None:
            self.__selected_group_id = actual_group_id

        self._route_on_start_slider(
            str(self.__selected_lang),
            self.__selected_tags,
            self.__selected_group_id,
            self._ft_container.get_is_random_order(),
        )
