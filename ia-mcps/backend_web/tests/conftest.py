"""Fixtures de la suite — hermética: cero red y cero credenciales reales.

El único borde vivo de este repo es la API de EMT (aiohttp). Se corta en el
CASO DE USO: los tests sustituyen la clase del service en el módulo de la
fachada, que es exactamente de donde la fachada lo resuelve en producción. Así se
recorre la pila entera (ASGI -> borde de auth -> controller -> fachada -> caso de
uso) sin salir a internet.

Los favoritos y los usuarios NO se falsean: viven en SQLite, que es local, y se
ejercen de verdad contra una base temporal (ver `seeded_users`).
"""
import asyncio
import os
import sqlite3
import tempfile
from contextlib import closing
from pathlib import Path
from typing import Any, Callable

import pytest

TEST_APIKEY = "test-mcp-api-key"

# El borde de auth lee la clave del entorno en cada petición: se fija ANTES de
# importar nada de la app para que no dependa del .env de la máquina.
os.environ["MCP_API_KEY"] = TEST_APIKEY
os.environ["APP_ENV"] = "test"

# Los logs de la suite van a un temporal, NUNCA a `backend_web/storage/logs`:
# cada test levanta la app entera y el controller traza el alta de los cinco
# servers, así que un `make test` metía ~550 lineas de ruido en el log real y
# enterraba los errores de verdad.
os.environ["APP_LOG_PATH"] = str(Path(tempfile.gettempdir()) / "ia-mcps-tests-logs")

# Los favoritos y los usuarios SÍ se ejercen de verdad (SQLite es local, no es un
# tercero), pero contra una base temporal: `backend_web/storage/sqlite` no se
# toca en ningún test.
TEST_SQLITE_DB_PATH = str(Path(tempfile.gettempdir()) / "ia-mcps-tests-db_ia_mcps.sqlite")
os.environ["SQLITE_DB_PATH"] = TEST_SQLITE_DB_PATH

ADMIN_TG_ID = "tg-admin"
USER_TG_ID = "tg-user"
OTHER_USER_TG_ID = "tg-other"
PWD_USER_TG_ID = "tg-pwd"
DISABLED_USER_TG_ID = "tg-disabled"
USER_PASSWORD = "s3creta"


class FakeGetStopArrivalsService:
    """Doble del caso de uso `GetStopArrivals`. No toca la API de EMT.

    Sin puertos, la costura de los tests es el propio caso de uso: la fachada lo
    resuelve por su nombre en su módulo, así que se sustituye ahí. Devuelve el
    ResultDto de verdad, no un dict: es lo que la fachada va a leer.
    """

    @classmethod
    def get_instance(cls) -> "FakeGetStopArrivalsService":
        return cls()

    async def __call__(self, get_stop_arrivals_dto: Any) -> Any:
        from src.modules.emt_mod.application.get_stop_arrivals.arrival_item_dto import ArrivalItemDto
        from src.modules.emt_mod.application.get_stop_arrivals.get_stop_arrivals_result_dto import (
            GetStopArrivalsResultDto,
        )

        return GetStopArrivalsResultDto(
            stop_id=get_stop_arrivals_dto.stop_id,
            stop_name="Cibeles",
            arrivals=[
                ArrivalItemDto(
                    line="001",
                    destination="PLAZA CASTILLA",
                    time_left_seconds=120,
                    time_left_minutes=2,
                    distance_meters=350,
                    is_head=False,
                    deviation=0,
                )
            ],
            total=1,
        )


class FakeGetLinesInfoService:
    """Doble del caso de uso `GetLinesInfo`. No toca la API de EMT."""

    @classmethod
    def get_instance(cls) -> "FakeGetLinesInfoService":
        return cls()

    async def __call__(self, get_lines_info_dto: Any) -> Any:
        from src.modules.emt_mod.application.get_lines_info.get_lines_info_result_dto import (
            GetLinesInfoResultDto,
        )
        from src.modules.emt_mod.application.get_lines_info.line_item_dto import LineItemDto

        return GetLinesInfoResultDto(
            lines=[
                LineItemDto(
                    line="105",
                    label="105",
                    name_a="MANUEL BECERRA",
                    name_b="CIUDAD LINEAL",
                    group="1",
                    start_date="",
                    end_date="",
                )
            ],
            total=1,
        )


class FakeGetStopsAroundService:
    """Doble del caso de uso `GetStopsAround`. No toca la API de EMT."""

    @classmethod
    def get_instance(cls) -> "FakeGetStopsAroundService":
        return cls()

    async def __call__(self, get_stops_around_dto: Any) -> Any:
        from src.modules.emt_mod.application.get_stops_around.get_stops_around_result_dto import (
            GetStopsAroundResultDto,
        )
        from src.modules.emt_mod.application.get_stops_around.stop_item_dto import StopItemDto

        return GetStopsAroundResultDto(
            stops=[
                StopItemDto(
                    stop_id="72",
                    stop_name="Cibeles",
                    latitude=40.4168,
                    longitude=-3.7038,
                    address="Plaza de Cibeles",
                    lines=["001", "002"],
                )
            ],
            total=1,
            latitude=get_stops_around_dto.latitude,
            longitude=get_stops_around_dto.longitude,
            radius=get_stops_around_dto.radius,
        )


class FakeGetStopDetailService:
    """Doble del caso de uso `GetStopDetail`. No toca la API de EMT."""

    @classmethod
    def get_instance(cls) -> "FakeGetStopDetailService":
        return cls()

    async def __call__(self, get_stop_detail_dto: Any) -> Any:
        from src.modules.emt_mod.application.get_stop_detail.get_stop_detail_result_dto import (
            GetStopDetailResultDto,
        )

        return GetStopDetailResultDto(
            stop_id=get_stop_detail_dto.stop_id,
            stop_name="Cibeles",
            latitude=40.4168,
            longitude=-3.7038,
            address="Plaza de Cibeles",
            postal_code="28014",
            lines=["001", "002"],
            wifi=True,
        )


class FakeGenerateImageService:
    """Doble del caso de uso `GenerateImage`. Ni llama a OpenAI ni escribe en disco."""

    @classmethod
    def get_instance(cls) -> "FakeGenerateImageService":
        return cls()

    def __call__(self, generate_image_dto: Any) -> Any:
        from src.modules.media_mod.application.generate_image.generate_image_result_dto import (
            GenerateImageResultDto,
        )

        return GenerateImageResultDto(
            model=generate_image_dto.image_model,
            size=generate_image_dto.size,
            quality=generate_image_dto.quality,
            file_paths=["/out/una-imagen.png"],
        )


class FakeGenerateAudioService:
    """Doble del caso de uso `GenerateAudio`. Ni llama a OpenAI ni escribe en disco."""

    @classmethod
    def get_instance(cls) -> "FakeGenerateAudioService":
        return cls()

    def __call__(self, generate_audio_dto: Any) -> Any:
        from src.modules.media_mod.application.generate_audio.generate_audio_result_dto import (
            GenerateAudioResultDto,
        )

        return GenerateAudioResultDto(
            model=generate_audio_dto.tts_model,
            voice=generate_audio_dto.voice,
            speed=generate_audio_dto.speed,
            audio_format=generate_audio_dto.response_format,
            file_paths=["/out/un-audio.mp3"],
        )


class FakeConvertMdToPdfService:
    """Doble del caso de uso `ConvertMdToPdf`. Ni lee markdown ni escribe PDF.

    Sin puertos, la costura de los tests es el propio caso de uso: la fachada lo
    resuelve por su nombre en su módulo, así que se sustituye ahí. Es SÍNCRONO
    porque el de verdad lo es (la fachada lo llama con `asyncio.to_thread`).
    """

    @classmethod
    def get_instance(cls) -> "FakeConvertMdToPdfService":
        return cls()

    def __call__(self, convert_md_to_pdf_dto: Any) -> Any:
        from src.modules.pdf_mod.application.convert_md_to_pdf.convert_md_to_pdf_result_dto import (
            ConvertMdToPdfResultDto,
        )

        return ConvertMdToPdfResultDto.from_primitives({
            "pdf_file_path": convert_md_to_pdf_dto.md_file_path.replace(".md", ".pdf"),
            "pdf_size_bytes": 2048,
        })


class FakeVerifyFileSignatureService:
    """Doble del caso de uso `VerifyFileSignature`. Ni lee disco ni descarga nada."""

    @classmethod
    def get_instance(cls) -> "FakeVerifyFileSignatureService":
        return cls()

    def __call__(self, verify_file_signature_dto: Any) -> Any:
        from src.modules.filechecker_mod.application.verify_file_signature.verify_file_signature_result_dto import (
            VerifyFileSignatureResultDto,
        )

        return VerifyFileSignatureResultDto.from_primitives({
            "file_path": verify_file_signature_dto.file_path_or_url,
            "source": "local",
            "file_size": 1234,
            "last_modified": "2026-08-16 10:00:00",
            "algorithm": verify_file_signature_dto.algorithm,
            "hash_value": "abc123",
            "executable_format": "",
            "executable_version": "",
            "executable_description": "",
            "executable_product_name": "",
            "executable_company": "",
            "signature_status": "",
            "signature_method": "",
            "signature_signer": "",
        })


class FakeMemoryResultDto:
    """Lo único que la fachada le pide a un ResultDto de memory: `to_primitives()`."""

    def __init__(self, primitives: dict[str, Any]) -> None:
        self._primitives = primitives

    def to_primitives(self) -> dict[str, Any]:
        return self._primitives


def get_fake_memory_use_case(get_primitives: Callable[[Any], dict[str, Any]]) -> type:
    """Fabrica el doble de UN caso de uso de `memory_mod`.

    Sin puertos, la costura de los tests es el caso de uso: la fachada lo
    resuelve por su nombre en su propio módulo, así que se sustituye la clase
    entera. Son siete, y solo cambia el dict que devuelve cada uno — de ahí la
    factoría en vez de siete clases calcadas.
    """

    class FakeMemoryUseCase:
        @classmethod
        def get_instance(cls) -> "FakeMemoryUseCase":
            return cls()

        async def __call__(self, use_case_dto: Any) -> FakeMemoryResultDto:
            return FakeMemoryResultDto(get_primitives(use_case_dto))

    return FakeMemoryUseCase


@pytest.fixture()
def mcp_app(monkeypatch):
    """La app con TODOS los puertos falseados.

    Cada service resuelve su adaptador en el `__init__`, y los controllers se
    cachean en `get_instance()`, así que se limpian los singletons para que los
    dobles entren de verdad en cada test.
    """
    from src.modules.emt_mcp.application.query_emt import query_emt_service
    from src.modules.emt_mcp.infrastructure.controllers.query_emt_controller import (
        QueryEmtController,
    )
    from src.modules.media_mcp.application.create_media import create_media_service
    from src.modules.media_mcp.infrastructure.controllers.create_media_controller import (
        CreateMediaController,
    )
    from src.modules.filechecker_mcp.application.verify_file import verify_file_service
    from src.modules.filechecker_mcp.infrastructure.controllers.verify_file_controller import (
        VerifyFileController,
    )
    from src.modules.memory_mcp.application.manage_memory import manage_memory_service
    from src.modules.memory_mcp.infrastructure.controllers.manage_memory_controller import (
        ManageMemoryController,
    )
    from src.modules.pdf_mcp.application.convert_pdf import convert_pdf_service
    from src.modules.pdf_mcp.infrastructure.controllers.convert_pdf_controller import (
        ConvertPdfController,
    )
    import public.main as main_module

    monkeypatch.setattr(query_emt_service, "GetStopArrivalsService", FakeGetStopArrivalsService)
    monkeypatch.setattr(query_emt_service, "GetLinesInfoService", FakeGetLinesInfoService)
    monkeypatch.setattr(query_emt_service, "GetStopsAroundService", FakeGetStopsAroundService)
    monkeypatch.setattr(query_emt_service, "GetStopDetailService", FakeGetStopDetailService)
    monkeypatch.setattr(create_media_service, "GenerateImageService", FakeGenerateImageService)
    monkeypatch.setattr(create_media_service, "GenerateAudioService", FakeGenerateAudioService)
    monkeypatch.setattr(QueryEmtController, "_instance", None)
    monkeypatch.setattr(convert_pdf_service, "ConvertMdToPdfService", FakeConvertMdToPdfService)
    monkeypatch.setattr(CreateMediaController, "_instance", None)
    monkeypatch.setattr(
        verify_file_service, "VerifyFileSignatureService", FakeVerifyFileSignatureService
    )
    monkeypatch.setattr(ConvertPdfController, "_instance", None)
    monkeypatch.setattr(
        manage_memory_service,
        "StoreMemoryService",
        get_fake_memory_use_case(
            lambda dto: {"chunk_id": "chunk-1", "project": dto.project, "stored": True}
        ),
    )
    monkeypatch.setattr(
        manage_memory_service,
        "SearchMemoryService",
        get_fake_memory_use_case(
            lambda dto: {
                "results": [{"chunk_id": "chunk-1", "content": "algo", "score": 0.9}],
                "total": 1,
            }
        ),
    )
    monkeypatch.setattr(
        manage_memory_service,
        "CheckFreshnessService",
        get_fake_memory_use_case(lambda dto: {"stale": [], "fresh": 3}),
    )
    monkeypatch.setattr(
        manage_memory_service,
        "ListMemoriesService",
        get_fake_memory_use_case(lambda dto: {"memories": [{"chunk_id": "chunk-1"}], "total": 1}),
    )
    monkeypatch.setattr(
        manage_memory_service,
        "DeleteMemoryService",
        get_fake_memory_use_case(lambda dto: {"deleted": True, "chunk_id": dto.chunk_id}),
    )
    monkeypatch.setattr(
        manage_memory_service,
        "UpdateMemoryService",
        get_fake_memory_use_case(lambda dto: {"updated": True, "chunk_id": dto.chunk_id}),
    )
    monkeypatch.setattr(
        manage_memory_service,
        "StoreFileService",
        get_fake_memory_use_case(
            lambda dto: {"stored": True, "file_path": dto.file_path, "chunks": 4}
        ),
    )
    monkeypatch.setattr(VerifyFileController, "_instance", None)
    monkeypatch.setattr(ManageMemoryController, "_instance", None)
    return main_module.app


def _create_test_user(user_tg_id: str, user_name: str, **primitives: Any) -> None:
    """Alta por el caso de uso real: así la contraseña se guarda hasheada por el
    mismo camino que en producción, y el test no tiene que saber el formato."""
    from src.modules.users_mod.application.create_user.create_user_dto import CreateUserDto
    from src.modules.users_mod.application.create_user.create_user_service import CreateUserService

    asyncio.run(
        CreateUserService.get_instance()(
            CreateUserDto.from_primitives({
                "user_tg_id": user_tg_id,
                "user_name": user_name,
                **primitives,
            })
        )
    )


def set_authenticated_days_ago(user_tg_id: str, days: int) -> None:
    """Envejece la última validación de contraseña para probar la ventana de 7
    días sin esperar una semana. Es el único sitio de la suite que toca SQL a
    pelo: no hay caso de uso que retroceda el reloj, ni debe haberlo."""
    # `closing` además del `with` de la conexión: el segundo confirma la
    # transacción pero NO cierra el fichero, y en Windows un fichero abierto no
    # se puede borrar (el teardown del fixture fallaba con PermissionError).
    with closing(sqlite3.connect(TEST_SQLITE_DB_PATH)) as connection, connection:
        connection.execute(
            "UPDATE app_users SET authenticated_at = datetime('now', ?) WHERE user_tg_id = ?",
            [f"-{days} days", user_tg_id],
        )


@pytest.fixture()
def seeded_users():
    """Base de datos recién creada con cinco usuarios de prueba.

    Se borra el fichero entero antes de cada test: el esquema lo vuelven a crear
    los repositorios en la primera conexión (`CREATE TABLE IF NOT EXISTS`), así
    que no hay estado que arrastre de un test al siguiente.
    """
    from src.modules.users_mod.domain.enums.user_role_enum import UserRoleEnum

    Path(TEST_SQLITE_DB_PATH).unlink(missing_ok=True)
    _create_test_user(ADMIN_TG_ID, "Admin", user_role_id=int(UserRoleEnum.ADMIN))
    _create_test_user(USER_TG_ID, "Eduardo")
    _create_test_user(OTHER_USER_TG_ID, "Otro")
    _create_test_user(PWD_USER_TG_ID, "Con contraseña", plain_password=USER_PASSWORD)
    _create_test_user(DISABLED_USER_TG_ID, "Deshabilitado", is_enabled=False)
    yield
    Path(TEST_SQLITE_DB_PATH).unlink(missing_ok=True)
