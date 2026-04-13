"""Repository de escritura de imagenes."""

import hashlib
import uuid
from pathlib import Path
from typing import final, Self
from datetime import datetime

from ddd.shared.infrastructure.repositories.sqlite_connection import SqliteConnection


@final
class ImagesWriterSqliteRepository:
    """Repository para escribir imagenes de palabras."""

    _instance: "ImagesWriterSqliteRepository | None" = None
    _images_dir: Path | None = None

    @classmethod
    def get_instance(cls) -> Self:
        if cls._instance is None:
            cls._instance = cls()
            cls._instance._ensure_images_dir()
        return cls._instance

    def _ensure_images_dir(self) -> None:
        """Asegura que existe el directorio de imagenes."""
        if self._images_dir is None:
            base_path = Path(__file__).parent.parent.parent.parent.parent
            self._images_dir = base_path / "data" / "images"
            self._images_dir.mkdir(parents=True, exist_ok=True)

    def _generate_filename(self, word_es_id: int, mime_type: str, original_name: str = "") -> str:
        """Genera un nombre de archivo unico."""
        ext_map = {
            "image/png": ".png",
            "image/jpeg": ".jpg",
            "image/jpg": ".jpg",
            "image/gif": ".gif",
            "image/webp": ".webp",
            "image/svg+xml": ".svg",
            "image/bmp": ".bmp",
        }
        ext = ext_map.get(mime_type, ".png")
        unique_id = uuid.uuid4().hex[:8]
        timestamp = datetime.now().strftime("%Y%m%d")
        return f"word_{word_es_id}_{timestamp}_{unique_id}{ext}"

    async def create(
        self,
        word_es_id: int,
        source_type: str,
        file_path: str,
        mime_type: str,
        original_url: str | None = None,
        original_filename: str | None = None,
        width: int | None = None,
        height: int | None = None,
        file_size: int | None = None,
        svg_content: str | None = None,
        caption: str | None = None,
        alt_text: str | None = None,
        is_primary: bool = False,
    ) -> dict:
        """Crea un registro de imagen."""
        sqlite = SqliteConnection.get_instance()

        # Si es la primera imagen de la palabra, hacerla primaria
        count_result = await sqlite.fetch_one(
            "SELECT COUNT(*) as count FROM word_es_images WHERE word_es_id = ? AND is_active = 1",
            (word_es_id,),
        )
        if count_result and count_result["count"] == 0:
            is_primary = True

        image_id = await sqlite.insert(
            """
            INSERT INTO word_es_images (
                word_es_id, source_type, file_path, mime_type,
                original_url, original_filename, width, height, file_size,
                svg_content, caption, alt_text, is_primary
            ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
            """,
            (
                word_es_id, source_type, file_path, mime_type,
                original_url, original_filename, width, height, file_size,
                svg_content, caption, alt_text, 1 if is_primary else 0,
            ),
        )

        return await sqlite.fetch_one(
            "SELECT * FROM word_es_images WHERE id = ?",
            (image_id,),
        )

    async def save_image_bytes(
        self,
        word_es_id: int,
        source_type: str,
        image_bytes: bytes,
        mime_type: str,
        original_filename: str | None = None,
        original_url: str | None = None,
        caption: str | None = None,
        is_primary: bool = False,
    ) -> dict:
        """Guarda bytes de imagen en disco y crea el registro."""
        self._ensure_images_dir()

        filename = self._generate_filename(word_es_id, mime_type, original_filename or "")
        file_path = self._images_dir / filename

        # Escribir archivo
        file_path.write_bytes(image_bytes)

        # Obtener dimensiones si es posible
        width, height = None, None
        try:
            from PIL import Image
            import io
            img = Image.open(io.BytesIO(image_bytes))
            width, height = img.size
        except ImportError:
            pass
        except Exception:
            pass

        return await self.create(
            word_es_id=word_es_id,
            source_type=source_type,
            file_path=filename,
            mime_type=mime_type,
            original_url=original_url,
            original_filename=original_filename,
            width=width,
            height=height,
            file_size=len(image_bytes),
            caption=caption,
            is_primary=is_primary,
        )

    async def save_svg_content(
        self,
        word_es_id: int,
        svg_content: str,
        caption: str | None = None,
        is_primary: bool = False,
    ) -> dict:
        """Guarda contenido SVG."""
        self._ensure_images_dir()

        filename = self._generate_filename(word_es_id, "image/svg+xml")
        file_path = self._images_dir / filename

        # Escribir archivo SVG
        file_path.write_text(svg_content, encoding="utf-8")

        return await self.create(
            word_es_id=word_es_id,
            source_type="VECTORIAL",
            file_path=filename,
            mime_type="image/svg+xml",
            file_size=len(svg_content.encode("utf-8")),
            svg_content=svg_content if len(svg_content) < 10000 else None,
            caption=caption,
            is_primary=is_primary,
        )

    async def set_primary(self, image_id: int) -> bool:
        """Establece una imagen como primaria."""
        sqlite = SqliteConnection.get_instance()

        # El trigger en la BD se encarga de quitar el primary de las otras
        rows = await sqlite.update(
            "UPDATE word_es_images SET is_primary = 1, updated_at = datetime('now') WHERE id = ?",
            (image_id,),
        )
        return rows > 0

    async def update_caption(self, image_id: int, caption: str, alt_text: str | None = None) -> bool:
        """Actualiza caption y alt_text de una imagen."""
        sqlite = SqliteConnection.get_instance()
        rows = await sqlite.update(
            """
            UPDATE word_es_images
            SET caption = ?, alt_text = ?, updated_at = datetime('now')
            WHERE id = ?
            """,
            (caption, alt_text, image_id),
        )
        return rows > 0

    async def update_sort_order(self, image_id: int, sort_order: int) -> bool:
        """Actualiza el orden de una imagen."""
        sqlite = SqliteConnection.get_instance()
        rows = await sqlite.update(
            "UPDATE word_es_images SET sort_order = ?, updated_at = datetime('now') WHERE id = ?",
            (sort_order, image_id),
        )
        return rows > 0

    async def soft_delete(self, image_id: int) -> bool:
        """Soft delete de una imagen."""
        sqlite = SqliteConnection.get_instance()
        rows = await sqlite.update(
            "UPDATE word_es_images SET is_active = 0, updated_at = datetime('now') WHERE id = ?",
            (image_id,),
        )
        return rows > 0

    async def hard_delete(self, image_id: int) -> bool:
        """Elimina permanentemente una imagen y su archivo."""
        sqlite = SqliteConnection.get_instance()

        # Obtener info del archivo
        image = await sqlite.fetch_one(
            "SELECT file_path FROM word_es_images WHERE id = ?",
            (image_id,),
        )

        if image:
            # Eliminar archivo
            self._ensure_images_dir()
            file_path = self._images_dir / image["file_path"]
            if file_path.exists():
                file_path.unlink()

            # Eliminar registro
            rows = await sqlite.delete(
                "DELETE FROM word_es_images WHERE id = ?",
                (image_id,),
            )
            return rows > 0
        return False

    async def delete_all_by_word_id(self, word_es_id: int) -> int:
        """Elimina todas las imagenes de una palabra."""
        sqlite = SqliteConnection.get_instance()

        # Obtener archivos a eliminar
        images = await sqlite.fetch_all(
            "SELECT file_path FROM word_es_images WHERE word_es_id = ?",
            (word_es_id,),
        )

        # Eliminar archivos
        self._ensure_images_dir()
        for img in images:
            file_path = self._images_dir / img["file_path"]
            if file_path.exists():
                file_path.unlink()

        # Eliminar registros
        return await sqlite.delete(
            "DELETE FROM word_es_images WHERE word_es_id = ?",
            (word_es_id,),
        )
