import os

ENV_HOME = "HOME"
ENV_PATHPRJ = "PATHPRJ"
ENV_DEV_URL = "DEV_URL"
ENV_PRE_URL = "PRE_URL"


def getenv(var: str, default: str = "") -> str:
    return os.environ.get(var, default)
