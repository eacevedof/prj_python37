import io
from typing import final, Self

from pypdf import PdfReader


@final
class Pdfer:

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def get_text_from_bytes(self, pdf_bytes: bytes) -> str:
        reader = PdfReader(io.BytesIO(pdf_bytes))
        return "\n".join(
            (page.extract_text() or "") for page in reader.pages
        ).strip()
