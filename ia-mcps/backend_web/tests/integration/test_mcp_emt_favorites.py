"""Paradas favoritas y usuarios — el guardarraíl visto desde el endpoint MCP.

A diferencia de la API de EMT (que se falsea), aquí se recorre la pila entera
CONTRA UNA BASE DE VERDAD, en un fichero temporal: el control de acceso es lo
que se está probando, y falsear el repositorio dejaría sin comprobar justo la
parte que importa.
"""
from fastapi.testclient import TestClient

from tests.conftest import (
    ADMIN_TG_ID,
    DISABLED_USER_TG_ID,
    OTHER_USER_TG_ID,
    PWD_USER_TG_ID,
    TEST_APIKEY,
    USER_PASSWORD,
    USER_TG_ID,
    set_authenticated_days_ago,
)

_MCP_HEADERS = {
    "Accept": "application/json, text/event-stream",
    "Content-Type": "application/json",
}
_AUTH_HEADERS = {"X-Api-Key": TEST_APIKEY}


def _get_tool_text(test_client, tool_name: str, arguments: dict) -> str:
    response = test_client.post(
        "/mcp/emt",
        headers=_MCP_HEADERS,
        json={
            "jsonrpc": "2.0",
            "id": 1,
            "method": "tools/call",
            "params": {"name": tool_name, "arguments": arguments},
        },
    )
    assert response.status_code == 200
    text: str = response.json()["result"]["content"][0]["text"]
    return text


def test_emt_publishes_also_the_favorites_tools(mcp_app, seeded_users) -> None:
    with TestClient(mcp_app, headers=_AUTH_HEADERS) as test_client:
        response = test_client.post(
            "/mcp/emt",
            headers=_MCP_HEADERS,
            json={"jsonrpc": "2.0", "id": 1, "method": "tools/list", "params": {}},
        )
        tools = response.json()["result"]["tools"]

    assert {
        "emt_add_favorite_stop",
        "emt_get_favorite_stops",
        "emt_update_favorite_stop",
        "emt_delete_favorite_stop",
        "emt_get_users",
    } <= {tool["name"] for tool in tools}


def test_a_user_adds_and_lists_his_own_stops(mcp_app, seeded_users) -> None:
    with TestClient(mcp_app, headers=_AUTH_HEADERS) as test_client:
        added_text = _get_tool_text(
            test_client,
            "emt_add_favorite_stop",
            {"user_tg_id": USER_TG_ID, "stop_nr": "72", "stop_description": "casa"},
        )
        listed_text = _get_tool_text(
            test_client, "emt_get_favorite_stops", {"user_tg_id": USER_TG_ID}
        )

    assert "72" in added_text and "casa" in added_text
    assert "[72] casa" in listed_text


def test_the_same_stop_twice_is_refused(mcp_app, seeded_users) -> None:
    with TestClient(mcp_app, headers=_AUTH_HEADERS) as test_client:
        _get_tool_text(
            test_client, "emt_add_favorite_stop", {"user_tg_id": USER_TG_ID, "stop_nr": "72"}
        )
        second_text = _get_tool_text(
            test_client, "emt_add_favorite_stop", {"user_tg_id": USER_TG_ID, "stop_nr": "72"}
        )

    assert "ya está en favoritos" in second_text


def test_a_user_only_sees_his_own_stops(mcp_app, seeded_users) -> None:
    # El admin le guarda una parada a OTRO usuario; el nuestro no debe verla.
    with TestClient(mcp_app, headers=_AUTH_HEADERS) as test_client:
        _get_tool_text(
            test_client,
            "emt_add_favorite_stop",
            {
                "user_tg_id": ADMIN_TG_ID,
                "target_user_tg_id": OTHER_USER_TG_ID,
                "stop_nr": "999",
                "stop_description": "la de otro",
            },
        )
        listed_text = _get_tool_text(
            test_client, "emt_get_favorite_stops", {"user_tg_id": USER_TG_ID}
        )

    assert "999" not in listed_text
    assert "la de otro" not in listed_text


def test_a_user_cannot_operate_on_another_user(mcp_app, seeded_users) -> None:
    with TestClient(mcp_app, headers=_AUTH_HEADERS) as test_client:
        text = _get_tool_text(
            test_client,
            "emt_get_favorite_stops",
            {"user_tg_id": USER_TG_ID, "target_user_tg_id": OTHER_USER_TG_ID},
        )

    assert "solo un administrador" in text


def test_an_admin_operates_on_another_user_stops(mcp_app, seeded_users) -> None:
    with TestClient(mcp_app, headers=_AUTH_HEADERS) as test_client:
        _get_tool_text(
            test_client,
            "emt_add_favorite_stop",
            {
                "user_tg_id": ADMIN_TG_ID,
                "target_user_tg_id": USER_TG_ID,
                "stop_nr": "72",
                "stop_description": "casa",
            },
        )
        admin_listed_text = _get_tool_text(
            test_client,
            "emt_get_favorite_stops",
            {"user_tg_id": ADMIN_TG_ID, "target_user_tg_id": USER_TG_ID},
        )
        owner_listed_text = _get_tool_text(
            test_client, "emt_get_favorite_stops", {"user_tg_id": USER_TG_ID}
        )

    assert f"de {USER_TG_ID}" in admin_listed_text
    assert "[72] casa" in owner_listed_text


def test_an_unknown_telegram_id_is_not_authorized(mcp_app, seeded_users) -> None:
    with TestClient(mcp_app, headers=_AUTH_HEADERS) as test_client:
        text = _get_tool_text(test_client, "emt_get_favorite_stops", {"user_tg_id": "tg-nadie"})

    assert "usuario no autorizado" in text


def test_a_disabled_user_cannot_enter(mcp_app, seeded_users) -> None:
    with TestClient(mcp_app, headers=_AUTH_HEADERS) as test_client:
        text = _get_tool_text(
            test_client, "emt_get_favorite_stops", {"user_tg_id": DISABLED_USER_TG_ID}
        )

    assert "deshabilitada" in text


def test_a_user_with_password_is_asked_for_it_and_then_not_again(mcp_app, seeded_users) -> None:
    with TestClient(mcp_app, headers=_AUTH_HEADERS) as test_client:
        # Recién dado de alta no hay validación previa: se pide la contraseña.
        first_text = _get_tool_text(
            test_client, "emt_get_favorite_stops", {"user_tg_id": PWD_USER_TG_ID}
        )
        with_password_text = _get_tool_text(
            test_client,
            "emt_get_favorite_stops",
            {"user_tg_id": PWD_USER_TG_ID, "password": USER_PASSWORD},
        )
        # Acertarla abre la ventana de 7 días: la siguiente llamada ya no la pide.
        inside_window_text = _get_tool_text(
            test_client, "emt_get_favorite_stops", {"user_tg_id": PWD_USER_TG_ID}
        )

    assert "se requiere la contraseña" in first_text
    assert "no hay paradas favoritas" in with_password_text
    assert "no hay paradas favoritas" in inside_window_text


def test_a_wrong_password_is_refused(mcp_app, seeded_users) -> None:
    with TestClient(mcp_app, headers=_AUTH_HEADERS) as test_client:
        text = _get_tool_text(
            test_client,
            "emt_get_favorite_stops",
            {"user_tg_id": PWD_USER_TG_ID, "password": "la-que-no-es"},
        )

    assert "contraseña incorrecta" in text


def test_after_seven_days_the_password_is_asked_again(mcp_app, seeded_users) -> None:
    set_authenticated_days_ago(PWD_USER_TG_ID, 8)

    with TestClient(mcp_app, headers=_AUTH_HEADERS) as test_client:
        expired_text = _get_tool_text(
            test_client, "emt_get_favorite_stops", {"user_tg_id": PWD_USER_TG_ID}
        )

    assert "se requiere la contraseña" in expired_text


def test_inside_the_seven_days_the_password_is_not_asked(mcp_app, seeded_users) -> None:
    set_authenticated_days_ago(PWD_USER_TG_ID, 6)

    with TestClient(mcp_app, headers=_AUTH_HEADERS) as test_client:
        text = _get_tool_text(test_client, "emt_get_favorite_stops", {"user_tg_id": PWD_USER_TG_ID})

    assert "no hay paradas favoritas" in text


def test_a_stop_can_be_updated_and_deleted(mcp_app, seeded_users) -> None:
    with TestClient(mcp_app, headers=_AUTH_HEADERS) as test_client:
        _get_tool_text(
            test_client,
            "emt_add_favorite_stop",
            {"user_tg_id": USER_TG_ID, "stop_nr": "72", "stop_description": "casa"},
        )
        updated_text = _get_tool_text(
            test_client,
            "emt_update_favorite_stop",
            {"user_tg_id": USER_TG_ID, "stop_nr": "72", "stop_description": "casa de mis padres"},
        )
        deleted_text = _get_tool_text(
            test_client, "emt_delete_favorite_stop", {"user_tg_id": USER_TG_ID, "stop_nr": "72"}
        )
        listed_text = _get_tool_text(
            test_client, "emt_get_favorite_stops", {"user_tg_id": USER_TG_ID}
        )

    assert "casa de mis padres" in updated_text
    assert "quitada de favoritos" in deleted_text
    assert "no hay paradas favoritas" in listed_text


def test_deleting_a_stop_of_another_user_does_not_delete_anything(mcp_app, seeded_users) -> None:
    with TestClient(mcp_app, headers=_AUTH_HEADERS) as test_client:
        _get_tool_text(
            test_client,
            "emt_add_favorite_stop",
            {
                "user_tg_id": ADMIN_TG_ID,
                "target_user_tg_id": OTHER_USER_TG_ID,
                "stop_nr": "999",
                "stop_description": "la de otro",
            },
        )
        deleted_text = _get_tool_text(
            test_client, "emt_delete_favorite_stop", {"user_tg_id": USER_TG_ID, "stop_nr": "999"}
        )
        other_listed_text = _get_tool_text(
            test_client,
            "emt_get_favorite_stops",
            {"user_tg_id": ADMIN_TG_ID, "target_user_tg_id": OTHER_USER_TG_ID},
        )

    assert "no está en favoritos" in deleted_text
    assert "[999] la de otro" in other_listed_text


def test_only_an_admin_lists_the_users(mcp_app, seeded_users) -> None:
    with TestClient(mcp_app, headers=_AUTH_HEADERS) as test_client:
        admin_text = _get_tool_text(test_client, "emt_get_users", {"user_tg_id": ADMIN_TG_ID})
        user_text = _get_tool_text(test_client, "emt_get_users", {"user_tg_id": USER_TG_ID})

    assert f"telegram: {USER_TG_ID}" in admin_text
    assert "deshabilitado" in admin_text
    assert "solo un administrador" in user_text


def test_no_answer_leaks_the_storage_or_the_password(mcp_app, seeded_users) -> None:
    """Ni el esquema ni el hash pueden asomar en un texto para el agente."""
    with TestClient(mcp_app, headers=_AUTH_HEADERS) as test_client:
        texts = [
            _get_tool_text(test_client, "emt_get_users", {"user_tg_id": ADMIN_TG_ID}),
            _get_tool_text(test_client, "emt_get_favorite_stops", {"user_tg_id": "tg-nadie"}),
            _get_tool_text(
                test_client,
                "emt_get_favorite_stops",
                {"user_tg_id": PWD_USER_TG_ID, "password": USER_PASSWORD},
            ),
            _get_tool_text(
                test_client,
                "emt_add_favorite_stop",
                {"user_tg_id": USER_TG_ID, "stop_nr": "72", "stop_description": "casa"},
            ),
        ]

    for text in texts:
        assert "app_users" not in text
        assert "app_mcp_stops" not in text
        assert "pbkdf2" not in text
        assert "sqlite" not in text.lower()
