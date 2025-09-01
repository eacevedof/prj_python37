from enum import Enum


class LzRequestBodyTypeEnum(Enum):
    UNKNOWN = "unknown"  # binary, DELETE, GET, PUT, PATCH
    FORM_DATA = "form-data"
    FORM = "form"  # x-www-form-urlencoded
    JSON = "json"  # raw, graphql
    TEXT = "text"  # The body is encoded as text
    BINARY = "binary"  # The body is encoded as binary