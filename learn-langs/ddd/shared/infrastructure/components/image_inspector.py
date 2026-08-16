"""Componente: inspección best-effort de metadatos de imagen (envuelve Pillow/PIL)."""

import importlib.util
import io
from typing import Self


class ImageInspector:
    """Inspecciona bytes de imagen envolviendo Pillow (PIL).

    Las dimensiones son metadatos OPCIONALES. Si Pillow no está instalado o los
    bytes no son una imagen decodificable, devuelve (None, None): ese None es un
    RESULTADO del contrato (como str.find devuelve -1), no un error tragado. Así
    el repositorio que persiste la imagen no necesita try/except y la ausencia
    de dimensiones nunca impide guardar la imagen.
    """

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def get_dimensions(
        self, image_bytes: bytes
    ) -> tuple[int | None, int | None]:
        """Devuelve (width, height) de la imagen, o (None, None) si no se puede
        determinar (sin Pillow o bytes no decodificables)."""
        if not image_bytes or importlib.util.find_spec("PIL") is None:
            return (None, None)

        from PIL import Image

        # Único punto donde PIL falla con bytes no decodificables. El contrato es
        # best-effort (dimensiones opcionales), por eso se acota aquí y se
        # devuelve (None, None) en vez de propagar.
        try:
            with Image.open(io.BytesIO(image_bytes)) as image:
                width, height = image.size
            return (int(width), int(height))
        except Exception:
            return (None, None)
