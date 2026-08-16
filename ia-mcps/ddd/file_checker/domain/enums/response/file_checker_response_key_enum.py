from enum import StrEnum
from typing import final


@final
class FileCheckerResponseKeyEnum(StrEnum):
    """Response dictionary keys for file checker results."""

    FILE_PATH = "file_path"
    FILE_SIZE = "file_size"
    LAST_MODIFIED = "last_modified"
    SOURCE = "source"
    HASH_VALUE = "hash_value"
    ALGORITHM = "algorithm"
    EXECUTABLE_FORMAT = "executable_format"
    EXECUTABLE_VERSION = "executable_version"
    EXECUTABLE_DESCRIPTION = "executable_description"
    EXECUTABLE_PRODUCT_NAME = "executable_product_name"
    EXECUTABLE_COMPANY = "executable_company"
    SIGNATURE_STATUS = "signature_status"
    SIGNATURE_METHOD = "signature_method"
    SIGNATURE_SIGNER = "signature_signer"
