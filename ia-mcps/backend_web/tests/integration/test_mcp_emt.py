"""Endpoint MCP de emt — formato agente.

Se entra en el lifespan (allí arranca el session manager del SDK) con los casos
de uso de `emt_mod` falseados, así que no se toca la API de EMT.
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
        test_client, "/mcp/emt", "tools/call", {"name": tool_name, "arguments": arguments or {}}
    )


def test_health_check_answers_without_apikey(mcp_app) -> None:
    with TestClient(mcp_app) as test_client:
        response = test_client.get("/health-check")

    assert response.status_code == 200
    assert response.json()["status"] == "ok"


def test_mcp_endpoint_rejects_a_call_without_apikey(mcp_app) -> None:
    # La apikey autoriza a consumir el servicio: sin ella no se llega al SDK.
    with TestClient(mcp_app) as test_client:
        response = test_client.post(
            "/mcp/emt",
            headers=_MCP_HEADERS,
            json={"jsonrpc": "2.0", "id": 1, "method": "tools/list", "params": {}},
        )

    assert response.status_code == 401


def test_mcp_endpoint_rejects_a_wrong_apikey(mcp_app) -> None:
    with TestClient(mcp_app, headers={"X-Api-Key": "not-the-key"}) as test_client:
        response = test_client.post(
            "/mcp/emt",
            headers=_MCP_HEADERS,
            json={"jsonrpc": "2.0", "id": 1, "method": "tools/list", "params": {}},
        )

    assert response.status_code == 401


def test_emt_publishes_its_tool_catalog(mcp_app) -> None:
    with TestClient(mcp_app, headers=_AUTH_HEADERS) as test_client:
        tools = _get_rpc_result(test_client, "/mcp/emt", "tools/list")["tools"]

    assert {tool["name"] for tool in tools} == {
        "emt_get_stop_arrivals",
        "emt_get_lines_info",
        "emt_get_stops_around",
        "emt_get_stop_detail",
        # Las de abajo no consultan a EMT: son los favoritos del usuario y el
        # listado de admin. Su comportamiento se prueba en
        # `test_mcp_emt_favorites.py`, contra una base de datos de verdad.
        "emt_add_favorite_stop",
        "emt_get_favorite_stops",
        "emt_update_favorite_stop",
        "emt_delete_favorite_stop",
        "emt_get_users",
    }


def test_stop_arrivals_answers_with_the_bus_times(mcp_app) -> None:
    with TestClient(mcp_app, headers=_AUTH_HEADERS) as test_client:
        result = _get_tool_result(test_client, "emt_get_stop_arrivals", {"stop_id": "72"})

    text = result["content"][0]["text"]
    assert "Cibeles" in text
    assert "2 min" in text
    assert result["isError"] is False


def test_stop_detail_answers_with_the_stop_data(mcp_app) -> None:
    with TestClient(mcp_app, headers=_AUTH_HEADERS) as test_client:
        result = _get_tool_result(test_client, "emt_get_stop_detail", {"stop_id": "72"})

    assert "Plaza de Cibeles" in result["content"][0]["text"]


def test_a_payload_that_breaks_the_published_schema_is_an_error(mcp_app) -> None:
    # El `required` del inputSchema lo hace cumplir el propio módulo: el Server
    # de bajo nivel del SDK 2.x no valida por su cuenta, así que `QueryEmtService`
    # contrasta el payload con el MISMO schema que publica en tools/list.
    with TestClient(mcp_app, headers=_AUTH_HEADERS) as test_client:
        result = _get_tool_result(test_client, "emt_get_stop_arrivals", {})

    assert result["isError"] is True
    assert "stop_id" in result["content"][0]["text"]


def test_an_unknown_tool_is_an_error(mcp_app) -> None:
    with TestClient(mcp_app, headers=_AUTH_HEADERS) as test_client:
        result = _get_tool_result(test_client, "emt_get_the_moon", {})

    assert result["isError"] is True
    assert "unknown tool" in result["content"][0]["text"]
