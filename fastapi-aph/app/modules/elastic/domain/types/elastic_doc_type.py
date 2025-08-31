from typing import Union, TypedDict

class ElasticDocType(TypedDict):
    domain: str
    environment: str
    level: str
    date_time: str
    server_ip: str
    request_ip: str
    request_uri: str
    log_content: str
    timestamp: Union[int, str]  # @timestamp field (@ not valid in Python variable names)