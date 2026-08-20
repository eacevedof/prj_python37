"""Endpoint MCP de pdf — formato agente.

Con el puerto `PdfConversion` falseado: ni weasyprint ni disco.
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
        "/mcp/pdf",
        headers=_MCP_HEADERS,
        json={"jsonrpc": "2.0", "id": 1, "method": method, "params": params or {}},
    )
    assert response.status_code == 200
    return response.json()["result"]


def _get_tool_result(test_client, tool_name: str, arguments: dict | None = None) -> dict:
    return _get_rpc_result(test_client, "tools/call", {"name": tool_name, "arguments": arguments or {}})


def test_pdf_publishes_its_tool_catalog(mcp_app) -> None:
    with TestClient(mcp_app, headers=_AUTH_HEADERS) as test_client:
        tools = _get_rpc_result(test_client, "tools/list")["tools"]

    assert {tool["name"] for tool in tools} == {"pdf_convert_md_to_pdf"}


def test_convert_md_to_pdf_answers_with_path_and_size(mcp_app) -> None:
    with TestClient(mcp_app, headers=_AUTH_HEADERS) as test_client:
        result = _get_tool_result(
            test_client, "pdf_convert_md_to_pdf", {"md_file_path": "/docs/guia.md"}
        )

    text = result["content"][0]["text"]
    assert "/docs/guia.pdf" in text
    assert "2048 bytes" in text
    assert result["isError"] is False


def test_convert_requires_the_md_path(mcp_app) -> None:
    with TestClient(mcp_app, headers=_AUTH_HEADERS) as test_client:
        result = _get_tool_result(test_client, "pdf_convert_md_to_pdf", {})

    assert result["isError"] is True
    assert "md_file_path" in result["content"][0]["text"]
