"""Repository de escritura de imagenes."""

import uuid
from pathlib import Path
from typing import final, Self
from datetime import datetime

from ddd.shared.infrastructure.components.sqlite_connector import SqliteConnector
from ddd.vocabulary.domain.entities import WordImageEntity
from ddd.vocabulary.domain.enums import ImageSourceEnum


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

    def _generate_filename(self, word_es_id: int, mime_type: str) -> str:
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

    async def create(self, word_image_entity: WordImageEntity) -> int:
        """Crea un registro de imagen y retorna el ID generado."""
        sqlite = SqliteConnector.get_instance()

        # Si es la primera imagen de la palabra, hacerla primaria
        is_primary = word_image_entity.is_primary
        count_result = await sqlite.fetch_one(
            "SELECT COUNT(*) as count FROM word_es_images WHERE word_es_id = ? AND is_active = 1",
            (word_image_entity.word_es_id,),
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
                word_image_entity.word_es_id,
                word_image_entity.source_type.value,
                word_image_entity.file_path,
                word_image_entity.mime_type,
                word_image_entity.original_url,
                word_image_entity.original_filename,
                word_image_entity.width,
                word_image_entity.height,
                word_image_entity.file_size,
                word_image_entity.svg_content,
                word_image_entity.caption,
                word_image_entity.alt_text,
                1 if is_primary else 0,
            ),
        )

        return image_id

    async def save_image_bytes(
        self,
        word_image_entity: WordImageEntity,
        image_bytes: bytes,
    ) -> int:
        """Guarda bytes de imagen en disco y crea el registro. Retorna el ID."""
        self._ensure_images_dir()

        filename = self._generate_filename(word_image_entity.word_es_id, word_image_entity.mime_type)
        file_path = self._images_dir / filename

        # Escribir archivo
        file_path.write_bytes(image_bytes)

        # Obtener dimensiones si es posible
        width, height = word_image_entity.width, word_image_entity.height
        if width is None or height is None:
            try:
                from PIL import Image
                import io
                img = Image.open(io.BytesIO(image_bytes))
                width, height = img.size
            except ImportError:
                pass
            except Exception:
                pass

        # Crear entidad actualizada con el path y dimensiones
        updated_entity = WordImageEntity(
            id=0,
            word_es_id=word_image_entity.word_es_id,
            source_type=word_image_entity.source_type,
            file_path=filename,
            mime_type=word_image_entity.mime_type,
            original_url=word_image_entity.original_url,
            original_filename=word_image_entity.original_filename,
            width=width,
            height=height,
            file_size=len(image_bytes),
            svg_content=word_image_entity.svg_content,
            caption=word_image_entity.caption,
            alt_text=word_image_entity.alt_text,
            is_primary=word_image_entity.is_primary,
        )

        return await self.create(updated_entity)

    async def save_svg_content(self, word_image_entity: WordImageEntity, svg_content: str) -> int:
        """Guarda contenido SVG y retorna el ID."""
        self._ensure_images_dir()

        filename = self._generate_filename(word_image_entity.word_es_id, "image/svg+xml")
        file_path = self._images_dir / filename

        # Escribir archivo SVG
        file_path.write_text(svg_content, encoding="utf-8")

        # Crear entidad actualizada
        updated_entity = WordImageEntity(
            id=0,
            word_es_id=word_image_entity.word_es_id,
            source_type=ImageSourceEnum.VECTORIAL,
            file_path=filename,
            mime_type="image/svg+xml",
            file_size=len(svg_content.encode("utf-8")),
            svg_content=svg_content if len(svg_content) < 10000 else None,
            caption=word_image_entity.caption,
            alt_text=word_image_entity.alt_text,
            is_primary=word_image_entity.is_primary,
        )

        return await self.create(updated_entity)

    async def update(self, word_image_entity: WordImageEntity) -> bool:
        """Actualiza caption, alt_text, sort_order, is_primary de una imagen."""
        sqlite = SqliteConnector.get_instance()
        rows = await sqlite.update(
            """
            UPDATE word_es_images
            SET caption = ?, alt_text = ?, sort_order = ?, is_primary = ?, updated_at = datetime('now')
            WHERE id = ?
            """,
            (
                word_image_entity.caption,
                word_image_entity.alt_text,
                word_image_entity.sort_order,
                1 if word_image_entity.is_primary else 0,
                word_image_entity.id,
            ),
        )
        return rows > 0

    async def soft_delete(self, word_image_entity: WordImageEntity) -> bool:
        """Soft delete de una imagen."""
        sqlite = SqliteConnector.get_instance()
        rows = await sqlite.update(
            "UPDATE word_es_images SET is_active = 0, updated_at = datetime('now') WHERE id = ?",
            (word_image_entity.id,),
        )
        return rows > 0

    async def hard_delete(self, word_image_entity: WordImageEntity) -> bool:
        """Elimina permanentemente una imagen y su archivo."""
        sqlite = SqliteConnector.get_instance()

        # Eliminar archivo
        self._ensure_images_dir()
        file_path = self._images_dir / word_image_entity.file_path
        if file_path.exists():
            file_path.unlink()

        # Eliminar registro
        rows = await sqlite.delete(
            "DELETE FROM word_es_images WHERE id = ?",
            (word_image_entity.id,),
        )
        return rows > 0

    async def delete_all_by_word(self, word_es_entity_id: int) -> int:
        """Elimina todas las imagenes de una palabra."""
        sqlite = SqliteConnector.get_instance()

        # Obtener archivos a eliminar
        images = await sqlite.fetch_all(
            "SELECT file_path FROM word_es_images WHERE word_es_id = ?",
            (word_es_entity_id,),
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
            (word_es_entity_id,),
        )
