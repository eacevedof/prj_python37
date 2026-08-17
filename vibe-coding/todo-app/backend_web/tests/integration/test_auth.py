"""El borde de autenticacion.

Estos tests protegen la decision mas facil de romper sin darse cuenta: que una
ruta nueva quede sin credencial. Como la autenticacion se aplica por prefijo
(`/api/`) y no ruta a ruta, basta con que un endpoint cuelgue de ahi para quedar
protegido. Estos tests comprueban que ese mecanismo sigue en pie.
"""

import pytest
from fastapi.testclient import TestClient


def test_health_check_no_pide_credencial(anonymous_client: TestClient) -> None:
    # Un monitor de disponibilidad tiene que poder llamarlo sin llave.
    response = anonymous_client.get("/health-check")

    assert response.status_code == 200
    assert response.json()["status"] == "ok"


def test_api_sin_credencial_devuelve_401(anonymous_client: TestClient) -> None:
    response = anonymous_client.get("/api/lists")

    assert response.status_code == 401


def test_api_con_credencial_incorrecta_devuelve_401(anonymous_client: TestClient) -> None:
    response = anonymous_client.get("/api/lists", headers={"X-Api-Key": "la-que-no-es"})

    assert response.status_code == 401


def test_api_con_credencial_correcta_pasa(client: TestClient) -> None:
    response = client.get("/api/lists")

    assert response.status_code == 200


def test_la_cabecera_no_distingue_mayusculas(anonymous_client: TestClient) -> None:
    # Starlette normaliza los nombres de cabecera a minusculas. Este test fija esa
    # expectativa: si alguien pone "X-Api-Key" con mayusculas en AuthEnum, la
    # busqueda dejaria de encontrar la cabecera y TODO devolveria 401.
    response = anonymous_client.get("/api/lists", headers={"x-API-key": "test-api-key"})

    assert response.status_code == 200


def test_credencial_vacia_en_el_entorno_deniega_todo(
    anonymous_client: TestClient, monkeypatch: pytest.MonkeyPatch
) -> None:
    # Un `.env` a medio rellenar no puede dejar la API abierta a cualquiera. Se usa
    # monkeypatch y no os.environ directamente para que el cambio se deshaga solo
    # al terminar el test; si no, el siguiente test se encontraria la variable
    # vacia y fallaria sin motivo aparente.
    monkeypatch.setenv("API_KEY", "")

    response = anonymous_client.get("/api/lists", headers={"X-Api-Key": ""})

    assert response.status_code == 401
