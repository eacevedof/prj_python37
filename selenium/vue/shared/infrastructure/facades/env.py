import os

ENV_HOME = "HOME"
ENV_PATHPRJ = "PATHPRJ"


def getenv(var: str) -> str:
    return os.environ.get(var, "")
