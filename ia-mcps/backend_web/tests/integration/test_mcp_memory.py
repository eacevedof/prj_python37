"""Endpoint MCP de memory — formato agente.

Con los casos de uso de `memory_mod` falseados: ni ChromaDB ni embeddings.
"""
import json

from fastapi.testclient import TestClient

from tests.conftest import TEST_APIKEY

_MCP_HEADERS = {
    "Accept": "application/json, text/event-stream",
    "Content-Type": "application/json",
}
_AUTH_HEADERS = {"X-Api-Key": TEST_APIKEY}


def _get_rpc_result(test_client, method: str, params: dict | None = None) -> dict:
    response = test_client.post(
        "/mcp/memory",
        headers=_MCP_HEADERS,
        json={"jsonrpc": "2.0", "id": 1, "method": method, "params": params or {}},
    )
    assert response.status_code == 200
    return response.json()["result"]


def _get_tool_result(test_client, tool_name: str, arguments: dict | None = None) -> dict:
    return _get_rpc_result(test_client, "tools/call", {"name": tool_name, "arguments": arguments or {}})


def test_memory_publishes_its_seven_tools(mcp_app) -> None:
    with TestClient(mcp_app, headers=_AUTH_HEADERS) as test_client:
        tools = _get_rpc_result(test_client, "tools/list")["tools"]

    assert {tool["name"] for tool in tools} == {
        "memory_store",
        "memory_search",
        "memory_check_freshness",
        "memory_list",
        "memory_delete",
        "memory_update",
        "memory_store_file",
    }


def test_store_answers_with_json(mcp_app) -> None:
    # memory responde JSON (no prosa): el agente encadena chunk_id entre llamadas.
    with TestClient(mcp_app, headers=_AUTH_HEADERS) as test_client:
        result = _get_tool_result(
            test_client,
            "memory_store",
            {"project": "ia-mcps", "type": "domain", "content": "algo"},
        )

    payload = json.loads(result["content"][0]["text"])
    assert payload["chunk_id"] == "chunk-1"
    assert result["isError"] is False


def test_search_answers_with_results(mcp_app) -> None:
    with TestClient(mcp_app, headers=_AUTH_HEADERS) as test_client:
        result = _get_tool_result(
            test_client, "memory_search", {"project": "ia-mcps", "query": "puerto"}
        )

    payload = json.loads(result["content"][0]["text"])
    assert payload["total"] == 1


def test_an_invalid_memory_type_is_rejected_by_the_schema(mcp_app) -> None:
    with TestClient(mcp_app, headers=_AUTH_HEADERS) as test_client:
        result = _get_tool_result(
            test_client,
            "memory_store",
            {"project": "p", "type": "inventado", "content": "x"},
        )

    assert result["isError"] is True


def test_delete_requires_the_chunk_id(mcp_app) -> None:
    with TestClient(mcp_app, headers=_AUTH_HEADERS) as test_client:
        result = _get_tool_result(test_client, "memory_delete", {"project": "p"})

    assert result["isError"] is True
    assert "chunk_id" in result["content"][0]["text"]


def test_store_file_is_disabled_by_default(mcp_app, monkeypatch) -> None:
    # Contra el service REAL (no el doble): se verifica que corta ANTES de leer
    # el fichero, que es lo que lo convertía en primitivo de exfiltración.
    import pytest

    from src.modules.memory_mod.application.store_file.store_file_dto import StoreFileDto
    from src.modules.memory_mod.application.store_file.store_file_service import StoreFileService
    from src.modules.memory_mod.domain.enums import MemoryTypeEnum
    from src.modules.memory_mod.domain.exceptions import MemoryException

    monkeypatch.delenv("APP_MEMORY_ALLOW_STORE_FILE", raising=False)
    with pytest.raises(MemoryException) as exception_info:
        import asyncio

        asyncio.run(
            StoreFileService.get_instance()(
                StoreFileDto(
                    project="ia-mcps",
                    file_path="/appdata/www/ia-mcps/.env",
                    memory_type=MemoryTypeEnum.DOCUMENTATION,
                )
            )
        )

    assert "memory_store_file is disabled" in exception_info.value.message
