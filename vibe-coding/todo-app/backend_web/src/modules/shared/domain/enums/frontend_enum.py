from typing import final


@final
class FrontendEnum:
    """Constantes para servir el front compilado desde la propia API.

    La misma aplicacion de Python sirve las dos cosas: `/api/*` y la pagina. Por
    eso no hace falta configurar CORS en ningun entorno y el navegador nunca hace
    peticiones a otro dominio.

    DIST_FOLDER es una ruta relativa a la raiz del proyecto, y es la MISMA en tu
    maquina y dentro del contenedor.
    """

    DIST_FOLDER = "frontend_web/dist"
    INDEX_FILE = "index.html"
    ASSETS_FOLDER = "assets"
    HEAD_TAG = "<head>"
    API_KEY_CONFIG_KEY = "apiKey"
