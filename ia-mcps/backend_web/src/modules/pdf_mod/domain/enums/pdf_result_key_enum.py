from typing import final


@final
class PdfResultKeyEnum:
    """Claves del `to_dict()` del caso de uso de pdf_mod.

    Las claves del `to_dict()`, que es lo que serializaría un `api_controller`.
    """

    PDF_FILE_PATH = "pdf_file_path"
    PDF_SIZE_BYTES = "pdf_size_bytes"
