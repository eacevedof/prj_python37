"""Endpoint MCP de media — formato agente.

Con el puerto `MediaGeneration` falseado: ni OpenAI ni escritura en disco.
"""
from fastapi.testclient import TestClient

from tests.conftest import TEST_APIKEY

_MCP_HEADERS = {
    "Accept": "application/json, text/event-stream",
    "Content-Type": "application/json",
}
_AUTH_HEADERS = {"X-Api-Key": TEST_APIKEY}


def _get_rpc_result(test_client, path: str, method: str, params: dict | None = None) -> dict:
    response = test_client.post(
        path,
        headers=_MCP_HEADERS,
        json={"jsonrpc": "2.0", "id": 1, "method": method, "params": params or {}},
    )
    assert response.status_code == 200
    return response.json()["result"]


def _get_tool_result(test_client, tool_name: str, arguments: dict | None = None) -> dict:
    return _get_rpc_result(
        test_client, "/mcp/media", "tools/call", {"name": tool_name, "arguments": arguments or {}}
    )


def test_media_publishes_its_own_tool_catalog(mcp_app) -> None:
    # Cada xxx_mcp es un servidor independiente: su catálogo no filtra tools de
    # los demás.
    with TestClient(mcp_app, headers=_AUTH_HEADERS) as test_client:
        media_tools = {
            tool["name"] for tool in _get_rpc_result(test_client, "/mcp/media", "tools/list")["tools"]
        }
        emt_tools = {
            tool["name"] for tool in _get_rpc_result(test_client, "/mcp/emt", "tools/list")["tools"]
        }

    assert media_tools == {"media_create_image", "media_create_audio"}
    assert not media_tools & emt_tools


def test_mcp_media_rejects_a_call_without_apikey(mcp_app) -> None:
    with TestClient(mcp_app) as test_client:
        response = test_client.post(
            "/mcp/media",
            headers=_MCP_HEADERS,
            json={"jsonrpc": "2.0", "id": 1, "method": "tools/list", "params": {}},
        )

    assert response.status_code == 401


def test_create_image_answers_with_the_written_path(mcp_app) -> None:
    with TestClient(mcp_app, headers=_AUTH_HEADERS) as test_client:
        result = _get_tool_result(test_client, "media_create_image", {"prompt": "un gato"})

    text = result["content"][0]["text"]
    assert "/out/una-imagen.png" in text
    assert result["isError"] is False


def test_create_audio_answers_with_the_written_path(mcp_app) -> None:
    with TestClient(mcp_app, headers=_AUTH_HEADERS) as test_client:
        result = _get_tool_result(
            test_client, "media_create_audio", {"text": "hola", "voice": "nova"}
        )

    text = result["content"][0]["text"]
    assert "/out/un-audio.mp3" in text
    assert "nova" in text


def test_create_image_requires_a_prompt(mcp_app) -> None:
    with TestClient(mcp_app, headers=_AUTH_HEADERS) as test_client:
        result = _get_tool_result(test_client, "media_create_image", {})

    assert result["isError"] is True
    assert "prompt" in result["content"][0]["text"]


def test_an_unknown_argument_is_rejected(mcp_app) -> None:
    # Los schemas llevan additionalProperties: false, así que un argumento que el
    # modelo se invente no llega al caso de uso.
    with TestClient(mcp_app, headers=_AUTH_HEADERS) as test_client:
        result = _get_tool_result(
            test_client, "media_create_image", {"prompt": "un gato", "colour": "azul"}
        )

    assert result["isError"] is True


def test_the_app_starts_without_openai_key_and_only_media_fails(monkeypatch) -> None:
    """Regresión del arranque en prod (2026-08-16).

    `AbstractOpenAIApiRepository` exigía la clave en `__init__`, y como el
    lifespan materializa TODOS los controllers MCP, un `.env` sin
    `OPENAI_API_KEY` tumbaba la app entera en bucle de reinicio. Aquí se usa el
    adaptador REAL de media (no el doble) para comprobar que la app levanta y que
    el fallo se queda dentro de su tool.
    """
    import public.main as main_module
    from src.modules.media_mcp.infrastructure.controllers.create_media_controller import (
        CreateMediaController,
    )

    monkeypatch.setenv("OPENAI_API_KEY", "")
    monkeypatch.setattr(CreateMediaController, "_instance", None)

    with TestClient(main_module.app, headers=_AUTH_HEADERS) as test_client:
        # 1) la app arranca: el resto de servidores responden
        assert test_client.get("/health-check").status_code == 200
        assert _get_rpc_result(test_client, "/mcp/emt", "tools/list")["tools"]

        # 2) y media falla sola, con su mensaje, sin tirar nada
        result = _get_tool_result(test_client, "media_create_image", {"prompt": "un gato"})

    assert result["isError"] is True
    assert "api key" in result["content"][0]["text"].lower()
