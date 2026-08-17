import os
from pathlib import Path

from dotenv import load_dotenv


def get_env_file_path() -> Path:
    """Ruta del fichero `.env` que carga la aplicacion.

    parents[3]: boot -> core -> src -> backend_web

    Se expone como funcion para que el arranque pueda dejar constancia de QUE
    ruta se ha mirado. Cuando el `.env` no llega (un bind-mount mal puesto, por
    ejemplo), lo primero que hace falta saber es donde lo estaba buscando.
    """
    return Path(__file__).resolve().parents[3] / ".env"


# Carga el .env al importar este modulo. Si el fichero no existe, `load_dotenv`
# no protesta: devuelve False y sigue. Por eso el arranque escribe una traza con
# lo que ha encontrado de verdad.
load_dotenv(get_env_file_path())


def get(key: str, default: str = "") -> str:
    """Lee una variable de entorno.

    Esta es la UNICA funcion de toda la app que toca os.environ, y solo la llama
    EnvironmentReaderRawRepository. Si necesitas una variable nueva, no llames a
    esto desde tu codigo: anade un getter tipado al repositorio.
    """
    return os.environ.get(key, default)
