"""Fixtures de la suite — hermética: cero red y cero credenciales reales.

El único borde vivo de este repo es la API de EMT (aiohttp). Se corta en el
puerto `EmtQuery`: los tests sustituyen el adaptador de `emt_mod` por uno falso,
que es la MISMA costura que usa la fachada MCP en producción. Así se recorre la
pila entera (ASGI -> borde de auth -> controller -> service -> puerto) sin salir
a internet.
"""
import os
from typing import Any

import pytest

TEST_APIKEY = "test-mcp-api-key"

# El borde de auth lee la clave del entorno en cada petición: se fija ANTES de
# importar nada de la app para que no dependa del .env de la máquina.
os.environ["MCP_API_KEY"] = TEST_APIKEY
os.environ["APP_ENV"] = "test"


class FakeEmtQueryAdapter:
    """Doble del puerto `EmtQuery`. Devuelve los primitivos que devolvería el
    `to_dict()` de cada caso de uso de emt_mod, sin tocar la API de EMT."""

    @classmethod
    def get_instance(cls) -> "FakeEmtQueryAdapter":
        return cls()

    async def get_stop_arrivals(self, primitives: dict[str, Any]) -> dict[str, Any]:
        return {
            "stop_id": primitives.get("stop_id", ""),
            "stop_name": "Cibeles",
            "arrivals": [
                {
                    "line": "001",
                    "destination": "PLAZA CASTILLA",
                    "time_left_seconds": 120,
                    "time_left_minutes": 2,
                    "distance_meters": 350,
                    "is_head": False,
                    "deviation": 0,
                }
            ],
            "total": 1,
        }

    async def get_lines_info(self, primitives: dict[str, Any]) -> dict[str, Any]:
        return {
            "lines": [
                {
                    "line": "105",
                    "label": "105",
                    "name_a": "MANUEL BECERRA",
                    "name_b": "CIUDAD LINEAL",
                    "group": "1",
                    "start_date": "",
                    "end_date": "",
                }
            ],
            "total": 1,
        }

    async def get_stops_around(self, primitives: dict[str, Any]) -> dict[str, Any]:
        return {
            "stops": [
                {
                    "stop_id": "72",
                    "stop_name": "Cibeles",
                    "latitude": 40.4168,
                    "longitude": -3.7038,
                    "address": "Plaza de Cibeles",
                    "lines": ["001", "002"],
                }
            ],
            "total": 1,
            "latitude": primitives.get("latitude", 0),
            "longitude": primitives.get("longitude", 0),
            "radius": primitives.get("radius", 500),
        }

    async def get_stop_detail(self, primitives: dict[str, Any]) -> dict[str, Any]:
        return {
            "stop_id": primitives.get("stop_id", ""),
            "stop_name": "Cibeles",
            "latitude": 40.4168,
            "longitude": -3.7038,
            "address": "Plaza de Cibeles",
            "postal_code": "28014",
            "lines": ["001", "002"],
            "wifi": True,
        }


class FakeMediaGenerationAdapter:
    """Doble del puerto `MediaGeneration`. Ni llama a OpenAI ni escribe en disco."""

    @classmethod
    def get_instance(cls) -> "FakeMediaGenerationAdapter":
        return cls()

    async def generate_image(self, primitives: dict[str, Any]) -> dict[str, Any]:
        return {
            "files": ["/out/una-imagen.png"],
            "model": primitives.get("model", "gpt-image-1.5"),
            "size": primitives.get("size", "1024x1024"),
            "quality": primitives.get("quality", "standard"),
        }

    async def generate_audio(self, primitives: dict[str, Any]) -> dict[str, Any]:
        return {
            "files": ["/out/un-audio.mp3"],
            "model": primitives.get("model", "tts-1"),
            "voice": primitives.get("voice", "alloy"),
            "speed": primitives.get("speed", 1.0),
            "format": primitives.get("response_format", "mp3"),
        }


class FakePdfConversionAdapter:
    """Doble del puerto `PdfConversion`. Ni lee markdown ni escribe PDF."""

    @classmethod
    def get_instance(cls) -> "FakePdfConversionAdapter":
        return cls()

    async def convert_md_to_pdf(self, primitives: dict[str, Any]) -> dict[str, Any]:
        md_file_path = str(primitives.get("md_file_path", ""))
        return {
            "pdf_file_path": md_file_path.replace(".md", ".pdf"),
            "pdf_size_bytes": 2048,
        }


class FakeFileVerificationAdapter:
    """Doble del puerto `FileVerification`. Ni lee disco ni descarga nada."""

    @classmethod
    def get_instance(cls) -> "FakeFileVerificationAdapter":
        return cls()

    async def verify_file_signature(self, primitives: dict[str, Any]) -> dict[str, Any]:
        return {
            "file_path": primitives.get("file_path_or_url", ""),
            "source": "local",
            "file_size": 1234,
            "last_modified": "2026-08-16 10:00:00",
            "algorithm": primitives.get("algorithm", "sha256"),
            "hash_value": "abc123",
            "executable_format": "",
            "executable_version": "",
            "executable_description": "",
            "executable_product_name": "",
            "executable_company": "",
            "signature_status": "",
            "signature_method": "",
            "signature_signer": "",
        }


class FakeMemoryStoreAdapter:
    """Doble del puerto `MemoryStore`. Ni ChromaDB ni modelo de embeddings."""

    @classmethod
    def get_instance(cls) -> "FakeMemoryStoreAdapter":
        return cls()

    async def store_memory(self, primitives: dict[str, Any]) -> dict[str, Any]:
        return {"chunk_id": "chunk-1", "project": primitives["project"], "stored": True}

    async def search_memory(self, primitives: dict[str, Any]) -> dict[str, Any]:
        return {"results": [{"chunk_id": "chunk-1", "content": "algo", "score": 0.9}], "total": 1}

    async def check_freshness(self, primitives: dict[str, Any]) -> dict[str, Any]:
        return {"stale": [], "fresh": 3}

    async def list_memories(self, primitives: dict[str, Any]) -> dict[str, Any]:
        return {"memories": [{"chunk_id": "chunk-1"}], "total": 1}

    async def delete_memory(self, primitives: dict[str, Any]) -> dict[str, Any]:
        return {"deleted": True, "chunk_id": primitives["chunk_id"]}

    async def update_memory(self, primitives: dict[str, Any]) -> dict[str, Any]:
        return {"updated": True, "chunk_id": primitives["chunk_id"]}

    async def store_file(self, primitives: dict[str, Any]) -> dict[str, Any]:
        return {"stored": True, "file_path": primitives["file_path"], "chunks": 4}


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

    monkeypatch.setattr(query_emt_service, "EmtQueryAdapter", FakeEmtQueryAdapter)
    monkeypatch.setattr(create_media_service, "MediaGenerationAdapter", FakeMediaGenerationAdapter)
    monkeypatch.setattr(QueryEmtController, "_instance", None)
    monkeypatch.setattr(convert_pdf_service, "PdfConversionAdapter", FakePdfConversionAdapter)
    monkeypatch.setattr(CreateMediaController, "_instance", None)
    monkeypatch.setattr(verify_file_service, "FileVerificationAdapter", FakeFileVerificationAdapter)
    monkeypatch.setattr(ConvertPdfController, "_instance", None)
    monkeypatch.setattr(manage_memory_service, "MemoryStoreAdapter", FakeMemoryStoreAdapter)
    monkeypatch.setattr(VerifyFileController, "_instance", None)
    monkeypatch.setattr(ManageMemoryController, "_instance", None)
    return main_module.app
