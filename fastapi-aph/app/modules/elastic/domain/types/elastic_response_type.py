from typing import TypedDict

class ElasticResponseType(TypedDict):
    stdout: str
    stderr: str
    status: int