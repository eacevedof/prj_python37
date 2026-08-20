from typing import final


@final
class PdfResultKeyEnum:
    """Claves del `to_dict()` del caso de uso de pdf_mod.

    Contrato que cruza el puerto `PdfConversion` hacia `pdf_mcp`.
    """

    PDF_FILE_PATH = "pdf_file_path"
    PDF_SIZE_BYTES = "pdf_size_bytes"
