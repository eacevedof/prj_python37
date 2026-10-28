"""Clase base abstracta para todos los controllers del sistema."""

from abc import ABC, abstractmethod
import flet as ft


class BaseController(ABC):
    """
    Clase base abstracta para todos los controllers.

    Responsabilidades de un controller:
    - Recibir callbacks de navegación desde app_router
    - Crear y configurar la vista (UI)
    - Orquestar la comunicación entre Vista y Servicios
    - Manejar el ciclo de vida de la vista
    - Exponer ft_container para que app_router monte la vista

    Contrato (métodos abstractos):
    - ft_container: Property que retorna el container de Flet para renderizar

    Patrón:
        Controller → crea → View
        Controller → orquesta → Services
        Controller → expone → ft_container (para app_router)

    Example:
        ```python
        class HomeController(BaseController):
            def __init__(self, route_callback: Callable):
                self._view = HomeView.from_primitives({
                    "on_action": self._handle_action,
                })

            @property
            def ft_container(self) -> ft.Container:
                return self._view

            def _handle_action(self) -> None:
                # Lógica del controller
                pass
        ```

    Note:
        Todos los controllers del sistema DEBEN heredar de esta clase.
        Python lanzará TypeError si intentas instanciar un controller
        que no implementa todos los métodos abstractos.
    """

    @property
    @abstractmethod
    def ft_container(self) -> ft.Container:
        """
        Container de Flet que app_router monta en la página.

        Este método es invocado por app_router cuando:
        - Se navega a la ruta asociada al controller
        - Se necesita renderizar la vista en la página
        - Se monta el controller en el árbol de componentes de Flet

        Returns:
            ft.Container: Vista del controller lista para renderizar.
                         Típicamente es la instancia de una View (HomeView, etc.)

        Raises:
            NotImplementedError: Si la subclase no implementa este método.

        Note:
            @invoked_by: app_router
            @lifecycle: called_once_per_navigation
            @visibility: public

        Example:
            ```python
            @property
            def ft_container(self) -> ft.Container:
                return self._view
            ```
        """
        pass
