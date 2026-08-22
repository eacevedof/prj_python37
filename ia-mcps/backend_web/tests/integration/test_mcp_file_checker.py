"""Endpoint MCP de file_checker — formato agente.

Con el puerto `FileVerificationPort` falseado: ni disco ni descargas.
"""
from fastapi.testclient import TestClient

from tests.conftest import TEST_APIKEY

_MCP_HEADERS = {
    "Accept": "application/json, text/event-stream",
    "Content-Type": "application/json",
}
_AUTH_HEADERS = {"X-Api-Key": TEST_APIKEY}


def _get_rpc_result(test_client, method: str, params: dict | None = None) -> dict:
    response = test_client.post(
        "/mcp/file-checker",
        headers=_MCP_HEADERS,
        json={"jsonrpc": "2.0", "id": 1, "method": method, "params": params or {}},
    )
    assert response.status_code == 200
    return response.json()["result"]


def _get_tool_result(test_client, tool_name: str, arguments: dict | None = None) -> dict:
    return _get_rpc_result(test_client, "tools/call", {"name": tool_name, "arguments": arguments or {}})


def test_file_checker_publishes_its_tool_catalog(mcp_app) -> None:
    with TestClient(mcp_app, headers=_AUTH_HEADERS) as test_client:
        tools = _get_rpc_result(test_client, "tools/list")["tools"]

    assert {tool["name"] for tool in tools} == {"file_checker_verify_file_signature"}


def test_verify_file_answers_with_the_report(mcp_app) -> None:
    with TestClient(mcp_app, headers=_AUTH_HEADERS) as test_client:
        result = _get_tool_result(
            test_client,
            "file_checker_verify_file_signature",
            {"file_path_or_url": "/tmp/fichero.bin"},
        )

    text = result["content"][0]["text"]
    assert "/tmp/fichero.bin" in text
    assert "abc123" in text
    # Los campos vacíos se cuentan con palabras, no en blanco.
    assert "no es un ejecutable" in text
    assert result["isError"] is False


def test_an_unsupported_algorithm_is_rejected_by_the_schema(mcp_app) -> None:
    # El enum del inputSchema lo hace cumplir el propio módulo.
    with TestClient(mcp_app, headers=_AUTH_HEADERS) as test_client:
        result = _get_tool_result(
            test_client,
            "file_checker_verify_file_signature",
            {"file_path_or_url": "/tmp/f.bin", "algorithm": "crc32"},
        )

    assert result["isError"] is True


def test_verify_requires_the_path(mcp_app) -> None:
    with TestClient(mcp_app, headers=_AUTH_HEADERS) as test_client:
        result = _get_tool_result(test_client, "file_checker_verify_file_signature", {})

    assert result["isError"] is True
    assert "file_path_or_url" in result["content"][0]["text"]


def test_url_download_is_disabled_by_default(mcp_app, monkeypatch) -> None:
    # Se prueba contra el service REAL (no el doble): lo que se verifica es que
    # el interruptor corta ANTES de salir a la red.
    from src.modules.filechecker_mod.application.verify_file_signature.verify_file_signature_service import (
        VerifyFileSignatureService,
    )
    from src.modules.filechecker_mod.application.verify_file_signature.verify_file_signature_dto import (
        VerifyFileSignatureDto,
    )
    from src.modules.filechecker_mod.domain.exceptions.file_checker_exception import (
        FileCheckerException,
    )
    import pytest

    monkeypatch.delenv("FILE_CHECKER_ALLOW_URL_DOWNLOAD", raising=False)
    with pytest.raises(FileCheckerException) as exception_info:
        VerifyFileSignatureService.get_instance()(
            VerifyFileSignatureDto.from_primitives(
                {"file_path_or_url": "http://169.254.169.254/latest/meta-data/"}
            )
        )

    assert "url download is disabled" in exception_info.value.message
