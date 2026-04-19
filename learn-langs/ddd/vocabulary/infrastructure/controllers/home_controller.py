"""Controller para el Home."""

import flet as ft
from typing import Callable

from ddd.vocabulary.application.load_home import LoadHomeDto, LoadHomeService
from ddd.vocabulary.domain.enums import LanguageCodeEnum
from ddd.vocabulary.infrastructure.controllers.home_view_dto import HomeViewDto
from ddd.vocabulary.infrastructure.ui.views.home_view import HomeView


class HomeController(ft.Container):
    """
    Controller del Home.

    Responsabilidades:
    - Manejar estado (idioma seleccionado, tags seleccionados)
    - Llamar al servicio LoadHomeService
    - Transformar resultado a HomeViewDto
    - Actualizar la vista
    """

    def __init__(
        self,
        on_start_study: Callable[[str, list[str]], None],
        on_manage_words: Callable[[], None],
    ):
        super().__init__()

        # Callbacks de navegación
        self._on_start_study = on_start_study
        self._on_manage_words = on_manage_words

        # Estado interno
        self._selected_lang: LanguageCodeEnum = LanguageCodeEnum.default()
        self._selected_tags: list[str] = []

        # Servicio
        self._load_home_service = LoadHomeService.get_instance()

        # Vista (se crea en _build_ui)
        self._home_view: HomeView | None = None

        self._build_ui()


    def _build_ui(self) -> None:
        """Construye la vista con el DTO inicial."""
        self._home_view = HomeView.from_primitives({
            "on_lang_change": self._handle_lang_change,
            "on_tag_toggle": self._handle_tag_toggle,
            "on_start_study": self._handle_start_study,
            "on_manage_words": self._handle_manage_words,
        })
        self.content = self._home_view
        self.expand = True

    def did_mount(self) -> None:
        """Se llama cuando el controller se monta en la página."""
        self.page.run_task(self._load_data)

    async def _load_data(self) -> None:
        """Carga datos del servicio y actualiza la vista."""
        result = await self._load_home_service(
            LoadHomeDto.from_primitives({
                "lang_code": str(self._selected_lang),
            })
        )

        if not result.success:
            home_view_dto = HomeViewDto.error(
                message=result.error_message or "Error desconocido",
                selected_lang_code=str(self._selected_lang),
            )
        else:
            home_view_dto = HomeViewDto.ok(
                tags=[
                    {"id": t.id, "name": t.name, "color": t.color}
                    for t in result.tags
                ],
                stats={
                    "total_words": result.stats.total_words,
                    "due_for_review": result.stats.due_for_review,
                    "avg_score": result.stats.avg_score,
                },
                selected_lang_code=str(self._selected_lang),
                selected_tags=self._selected_tags,
            )

        if self._home_view:
            self._home_view.render(home_view_dto)

    def _handle_lang_change(self, lang_code: str) -> None:
        """Maneja el cambio de idioma."""
        try:
            self._selected_lang = LanguageCodeEnum(lang_code)
        except ValueError:
            self._selected_lang = LanguageCodeEnum.default()

        self.page.run_task(self._load_data)

    def _handle_tag_toggle(self, tag_name: str) -> None:
        """Alterna la selección de un tag."""
        if tag_name in self._selected_tags:
            self._selected_tags.remove(tag_name)
        else:
            self._selected_tags.append(tag_name)

        # Re-render con el nuevo estado
        self.page.run_task(self._load_data)

    def _handle_start_study(self) -> None:
        """Inicia el estudio con el idioma y tags seleccionados."""
        self._on_start_study(str(self._selected_lang), self._selected_tags)

    def _handle_manage_words(self) -> None:
        """Navega a la gestión de palabras."""
        self._on_manage_words()
