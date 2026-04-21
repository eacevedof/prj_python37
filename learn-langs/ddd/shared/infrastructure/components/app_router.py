"""Router de la aplicacion."""

import flet as ft
from typing import Any

from ddd.shared.domain.enums import ControllerRouteEnum
from ddd.vocabulary.domain.enums import LanguageCodeEnum
from ddd.vocabulary.infrastructure.controllers import (
    HomeController,
    CreateWordController,
)
from ddd.vocabulary.infrastructure.ui.views import (
    StudyView,
    UpdateWordView,
    ListWordsView,
)


class AppRouter:
    """Maneja la navegacion entre vistas."""

    def __init__(
        self,
        ft_page: ft.Page,
        ft_container: ft.Container
    ):
        self._ft_page = ft_page
        self._ft_container = ft_container
        self._route_name_enum: ControllerRouteEnum = ControllerRouteEnum.HOME

    @property
    def current_route(self) -> ControllerRouteEnum:
        """Ruta actual."""
        return self._route_name_enum

    def navigate_to(
        self,
        route_name_enum: ControllerRouteEnum | str,
        **kwargs: Any,
    ) -> None:
        """Navega a una vista especifica."""
        # Convertir string a enum si es necesario
        if isinstance(route_name_enum, str):
            route_name_enum = ControllerRouteEnum(route_name_enum)

        self._route_name_enum = route_name_enum
        self._ft_container.content = self._build_view(route_name_enum, **kwargs)
        self._ft_page.update()

    def _build_view(
        self,
        route_name: ControllerRouteEnum,
        **kwargs: Any,
    ) -> ft.Control:
        """Construye la vista correspondiente a la ruta."""
        if route_name == ControllerRouteEnum.HOME:
            controller = HomeController(
                on_start_study=lambda lang, tags: self.navigate_to(
                    ControllerRouteEnum.STUDY,
                    lang_code=lang,
                    tags=tags,
                ),
                on_manage_words=lambda: self.navigate_to(
                    ControllerRouteEnum.WORDS,
                ),
            )
            return controller.view

        if route_name == ControllerRouteEnum.STUDY:
            return StudyView(
                lang_code=kwargs.get("lang_code", LanguageCodeEnum.default()),
                tags=kwargs.get("tags", []),
                on_back=lambda: self.navigate_to(ControllerRouteEnum.HOME),
            )

        if route_name == ControllerRouteEnum.WORDS:
            return ListWordsView(
                on_back=lambda: self.navigate_to(ControllerRouteEnum.HOME),
                on_create=lambda: self.navigate_to(ControllerRouteEnum.CREATE_WORD),
                on_edit=lambda word_id: self.navigate_to(
                    ControllerRouteEnum.UPDATE_WORD,
                    word_id=word_id,
                ),
            )

        if route_name == ControllerRouteEnum.CREATE_WORD:
            controller = CreateWordController(
                on_success=lambda: self.navigate_to(ControllerRouteEnum.WORDS),
                on_back=lambda: self.navigate_to(ControllerRouteEnum.WORDS),
            )
            return controller.view

        if route_name == ControllerRouteEnum.UPDATE_WORD:
            return UpdateWordView(
                word_id=kwargs.get("word_id", 0),
                on_back=lambda: self.navigate_to(ControllerRouteEnum.WORDS),
                on_word_updated=lambda: None,
            )

        return self._build_view(ControllerRouteEnum.HOME)
