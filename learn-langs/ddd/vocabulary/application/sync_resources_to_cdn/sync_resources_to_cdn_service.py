from pathlib import Path
from typing import Self, final

from ddd.shared.infrastructure.components.file_hasher import FileHasher
from ddd.shared.infrastructure.repositories import ResourcesWriterCdnRepository
from ddd.vocabulary.domain.enums.resource_kind_enum import ResourceKindEnum
from ddd.vocabulary.domain.enums.resource_sync_scope_enum import ResourceSyncScopeEnum
from ddd.vocabulary.domain.enums.resource_sync_status_enum import ResourceSyncStatusEnum
from ddd.vocabulary.domain.enums.tts_accent_enum import TtsAccentEnum
from ddd.vocabulary.domain.exceptions.vocabulary_exception import VocabularyException
from ddd.vocabulary.infrastructure.repositories.images_reader_sqlite_repository import (
    ImagesReaderSqliteRepository,
)
from ddd.vocabulary.infrastructure.repositories.images_writer_sqlite_repository import (
    ImagesWriterSqliteRepository,
)
from ddd.vocabulary.infrastructure.repositories.word_audios_reader_file_repository import (
    WordAudiosReaderFileRepository,
)
from ddd.vocabulary.infrastructure.repositories.word_media_reader_sqlite_repository import (
    WordMediaReaderSqliteRepository,
)
from ddd.vocabulary.infrastructure.repositories.word_media_writer_sqlite_repository import (
    WordMediaWriterSqliteRepository,
)
from ddd.vocabulary.application.sync_resources_to_cdn.sync_resources_to_cdn_dto import (
    SyncResourcesToCdnDto,
)
from ddd.vocabulary.application.sync_resources_to_cdn.sync_resources_to_cdn_result_dto import (
    SyncResourcesToCdnResultDto,
)


@final
class SyncResourcesToCdnService:
    """Sube al CDN los audios/imagenes locales y guarda su URL (idempotente).

    - Audios: file-driven. Recorre los mp3 reales de data/audio (convencion
      word-{word_es_id}-{accent}.mp3, 2 por palabra: origen es_ES + traduccion
      nl_NL), sube el que falte o haya cambiado (md5) y guarda la URL en la tabla
      word_es_media (upsert por word_es_id+lang_code+file_ext).
    - Imagenes: recorre word_es_images (file_path) y guarda la URL en esa tabla.

    dry_run no sube nada (marca lo que se subiria como PENDING).
    """

    _AUDIO_FILE_EXT: str = "mp3"

    def __init__(self) -> None:
        self._file_hasher = FileHasher.get_instance()
        self._resources_writer_cdn_repository = (
            ResourcesWriterCdnRepository.get_instance()
        )
        self._word_audios_reader_file_repository = (
            WordAudiosReaderFileRepository.get_instance()
        )
        self._word_media_reader_sqlite_repository = (
            WordMediaReaderSqliteRepository.get_instance()
        )
        self._word_media_writer_sqlite_repository = (
            WordMediaWriterSqliteRepository.get_instance()
        )
        self._images_reader_sqlite_repository = (
            ImagesReaderSqliteRepository.get_instance()
        )
        self._images_writer_sqlite_repository = (
            ImagesWriterSqliteRepository.get_instance()
        )

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(
        self, sync_resources_to_cdn_dto: SyncResourcesToCdnDto
    ) -> SyncResourcesToCdnResultDto:
        self._fail_if_wrong_input(sync_resources_to_cdn_dto)

        scope = sync_resources_to_cdn_dto.scope
        dry_run = sync_resources_to_cdn_dto.dry_run

        results: list[dict[str, str]] = []
        if scope in (
            ResourceSyncScopeEnum.ALL.value,
            ResourceSyncScopeEnum.AUDIOS.value,
        ):
            results.extend(await self._get_synced_audios(dry_run))
        if scope in (
            ResourceSyncScopeEnum.ALL.value,
            ResourceSyncScopeEnum.IMAGES.value,
        ):
            results.extend(await self._get_synced_images(dry_run))

        return self._get_result_dto(results)

    async def _get_synced_audios(self, dry_run: bool) -> list[dict[str, str]]:
        media_by_key = await self._get_media_lookup()
        results: list[dict[str, str]] = []
        for (
            filename
        ) in self._word_audios_reader_file_repository.get_all_audio_filenames():
            parsed = self._parse_audio_filename(filename)
            if parsed is None:
                continue
            word_es_id, lang_code = parsed
            existing = media_by_key.get((word_es_id, lang_code, self._AUDIO_FILE_EXT))
            local_path = str(self._get_audio_dir() / filename)

            result = await self._get_synced_resource(
                ResourceKindEnum.AUDIO.value,
                word_es_id,
                local_path,
                existing.get("file_url") if existing else None,
                existing.get("file_synced_md5") if existing else None,
                dry_run,
            )
            result["lang_code"] = lang_code
            result["file_ext"] = self._AUDIO_FILE_EXT
            result["filename"] = filename

            if result["status"] == ResourceSyncStatusEnum.UPLOADED.value:
                try:
                    await self._word_media_writer_sqlite_repository.upsert(
                        word_es_id,
                        lang_code,
                        self._AUDIO_FILE_EXT,
                        filename,
                        result["url"],
                        result["md5"],
                    )
                except Exception as persist_error:
                    result["status"] = ResourceSyncStatusEnum.FAILED.value
                    result["error"] = f"persist: {persist_error}"

            results.append(result)
        return results

    async def _get_synced_images(self, dry_run: bool) -> list[dict[str, str]]:
        rows = await self._images_reader_sqlite_repository.get_all_active_files()
        results: list[dict[str, str]] = []
        for row in rows:
            local_path = self._get_image_local_path(str(row.get("file_path") or ""))
            result = await self._get_synced_resource(
                ResourceKindEnum.IMAGE.value,
                int(row["id"]),
                local_path,
                row.get("file_url"),
                row.get("file_synced_md5"),
                dry_run,
            )
            if result["status"] == ResourceSyncStatusEnum.UPLOADED.value:
                await self._images_writer_sqlite_repository.update_file_sync(
                    int(row["id"]), result["url"], result["md5"]
                )
            results.append(result)
        return results

    async def _get_synced_resource(
        self,
        kind: str,
        resource_id: int,
        local_path: str,
        current_url: str | None,
        synced_md5: str | None,
        dry_run: bool,
    ) -> dict[str, str]:
        """Decide y ejecuta el sync de UN recurso; devuelve su resultado.

        NOTA DDD: el try/except es orquestacion de LOTE deliberada (no swallow):
        captura el fallo de subida de UN recurso para marcarlo FAILED y seguir con
        el resto; el error viaja en el resultado (str(e)) hasta el controller.
        """
        if not local_path or not Path(local_path).is_file():
            return self._get_result_row(
                kind, resource_id, ResourceSyncStatusEnum.MISSING.value, local_path
            )

        current_md5 = self._file_hasher.get_md5(local_path)
        if current_url and synced_md5 == current_md5:
            return self._get_result_row(
                kind,
                resource_id,
                ResourceSyncStatusEnum.SKIPPED.value,
                local_path,
                url=current_url,
            )

        if dry_run:
            return self._get_result_row(
                kind,
                resource_id,
                ResourceSyncStatusEnum.PENDING.value,
                local_path,
                md5=current_md5,
            )

        try:
            public_url = await self._resources_writer_cdn_repository.upload_file(
                local_path
            )
        except Exception as upload_error:
            return self._get_result_row(
                kind,
                resource_id,
                ResourceSyncStatusEnum.FAILED.value,
                local_path,
                error=str(upload_error),
            )

        return self._get_result_row(
            kind,
            resource_id,
            ResourceSyncStatusEnum.UPLOADED.value,
            local_path,
            url=public_url,
            md5=current_md5,
        )

    def _get_result_row(
        self,
        kind: str,
        resource_id: int,
        status: str,
        local_path: str,
        lang_code: str = "",
        file_ext: str = "",
        filename: str = "",
        url: str = "",
        md5: str = "",
        error: str = "",
    ) -> dict[str, str]:
        return {
            "kind": kind,
            "id": str(resource_id),
            "status": status,
            "lang_code": lang_code,
            "file_ext": file_ext,
            "filename": filename,
            "local_path": local_path,
            "url": url,
            "md5": md5,
            "error": error,
        }

    async def _get_media_lookup(self) -> dict[tuple[int, str, str], dict]:
        rows = await self._word_media_reader_sqlite_repository.get_all()
        return {
            (int(row["word_es_id"]), str(row["lang_code"]), str(row["file_ext"])): row
            for row in rows
        }

    def _parse_audio_filename(self, filename: str) -> tuple[int, str] | None:
        """word-{word_es_id}-{accent_label}.mp3 -> (word_es_id, lang_code) o None."""
        if not filename.endswith(".mp3"):
            return None
        stem = filename[: -len(".mp3")]
        prefix = "word-"
        if not stem.startswith(prefix):
            return None
        word_id_text, separator, accent_label = stem[len(prefix) :].partition("-")
        if not separator or not word_id_text.isdigit():
            return None
        lang_code = TtsAccentEnum.lang_for_label(accent_label)
        if not lang_code:
            return None
        return (int(word_id_text), lang_code)

    def _get_result_dto(
        self, results: list[dict[str, str]]
    ) -> SyncResourcesToCdnResultDto:
        return SyncResourcesToCdnResultDto.from_primitives(
            {
                "total_resources": len(results),
                "uploaded_count": self._get_count_by_status(
                    results, ResourceSyncStatusEnum.UPLOADED.value
                ),
                "skipped_count": self._get_count_by_status(
                    results, ResourceSyncStatusEnum.SKIPPED.value
                ),
                "missing_count": self._get_count_by_status(
                    results, ResourceSyncStatusEnum.MISSING.value
                ),
                "failed_count": self._get_count_by_status(
                    results, ResourceSyncStatusEnum.FAILED.value
                ),
                "resources": results,
            }
        )

    def _get_count_by_status(self, results: list[dict[str, str]], status: str) -> int:
        return sum(1 for result in results if result["status"] == status)

    def _get_image_local_path(self, stored_file_path: str) -> str:
        if not stored_file_path:
            return ""
        path = Path(stored_file_path)
        if path.is_absolute():
            return str(path)
        return str(self._get_images_dir() / path.name)

    def _get_audio_dir(self) -> Path:
        return Path(__file__).resolve().parents[4] / "data" / "audio"

    def _get_images_dir(self) -> Path:
        return Path(__file__).resolve().parents[4] / "data" / "images"

    def _fail_if_wrong_input(
        self, sync_resources_to_cdn_dto: SyncResourcesToCdnDto
    ) -> None:
        valid_scopes = {
            ResourceSyncScopeEnum.ALL.value,
            ResourceSyncScopeEnum.AUDIOS.value,
            ResourceSyncScopeEnum.IMAGES.value,
        }
        if sync_resources_to_cdn_dto.scope not in valid_scopes:
            VocabularyException.bad_request_custom(
                f"scope invalido: '{sync_resources_to_cdn_dto.scope}'"
            )
