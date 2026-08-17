import os
from pathlib import Path

from dotenv import load_dotenv

# Carga backend_web/.env al importar este modulo.
# parents[3]: boot -> core -> src -> backend_web
load_dotenv(Path(__file__).resolve().parents[3] / ".env")


def get(key: str, default: str = "") -> str:
    """Lee una variable de entorno.

    Esta es la UNICA funcion de toda la app que toca os.environ, y solo la llama
    EnvironmentReaderRawRepository. Si necesitas una variable nueva, no llames a
    esto desde tu codigo: anade un getter tipado al repositorio.

    Es una funcion suelta y no una clase porque tiene que poder usarse antes de
    que exista nada mas (la carga del .env ocurre en el import).
    """
    return os.environ.get(key, default)
