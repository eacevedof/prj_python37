"""CRUD de listas de punta a punta, por HTTP.

Son tests de INTEGRACION: entran por la ruta real, pasan por el front controller,
el controller, el caso de uso y el repositorio, y tocan una base de datos SQLite
de verdad. No se prueba una clase aislada; se prueba que el camino completo
funciona, que es lo que le importa a quien use la API.

Cada test comprueba UNA cosa y se lee de arriba abajo: preparar, actuar,
comprobar.
"""

from fastapi.testclient import TestClient


def test_el_listado_trae_la_lista_por_defecto(client: TestClient) -> None:
    # La migracion de datos iniciales crea la lista "Entrada".
    response = client.get("/api/lists")

    assert response.status_code == 200
    data = response.json()["data"]
    assert data["total"] == 1
    assert data["items"][0]["name"] == "Entrada"


def test_crear_una_lista_devuelve_201_y_su_id(client: TestClient) -> None:
    response = client.post("/api/lists", json={"name": "Compra", "color": "#FF0000"})

    assert response.status_code == 201
    data = response.json()["data"]
    assert data["id"] > 0
    assert data["name"] == "Compra"
    assert data["color"] == "#FF0000"


def test_crear_sin_nombre_devuelve_400(client: TestClient) -> None:
    response = client.post("/api/lists", json={"color": "#FF0000"})

    assert response.status_code == 400
    assert "name" in response.json()["error"]


def test_crear_con_color_invalido_devuelve_400(client: TestClient) -> None:
    response = client.post("/api/lists", json={"name": "X", "color": "rojo"})

    assert response.status_code == 400


def test_crear_con_nombre_repetido_devuelve_409(client: TestClient) -> None:
    client.post("/api/lists", json={"name": "Compra"})

    response = client.post("/api/lists", json={"name": "compra"})

    # Mayusculas distintas, mismo nombre: el indice unico es sobre lower(name).
    assert response.status_code == 409


def test_obtener_una_lista_que_no_existe_devuelve_404(client: TestClient) -> None:
    response = client.get("/api/lists/9999")

    assert response.status_code == 404


def test_modificar_una_lista(client: TestClient) -> None:
    list_id = client.post("/api/lists", json={"name": "Compra"}).json()["data"]["id"]

    response = client.put(f"/api/lists/{list_id}", json={"name": "Supermercado", "color": "#00FF00"})

    assert response.status_code == 200
    assert response.json()["data"]["name"] == "Supermercado"


def test_modificar_no_choca_con_su_propio_nombre(client: TestClient) -> None:
    # Cambiar solo el color de una lista no puede dar conflicto consigo misma.
    list_id = client.post("/api/lists", json={"name": "Compra"}).json()["data"]["id"]

    response = client.put(f"/api/lists/{list_id}", json={"name": "Compra", "color": "#123456"})

    assert response.status_code == 200


def test_borrar_una_lista_la_saca_del_listado(client: TestClient) -> None:
    list_id = client.post("/api/lists", json={"name": "Temporal"}).json()["data"]["id"]

    delete_response = client.delete(f"/api/lists/{list_id}")

    assert delete_response.status_code == 200
    assert client.get(f"/api/lists/{list_id}").status_code == 404
    nombres = [item["name"] for item in client.get("/api/lists").json()["data"]["items"]]
    assert "Temporal" not in nombres


def test_el_nombre_de_una_lista_borrada_se_puede_reutilizar(client: TestClient) -> None:
    # El indice unico es PARCIAL (solo sobre las vivas): borrar libera el nombre.
    list_id = client.post("/api/lists", json={"name": "Temporal"}).json()["data"]["id"]
    client.delete(f"/api/lists/{list_id}")

    response = client.post("/api/lists", json={"name": "Temporal"})

    assert response.status_code == 201


def test_filtrar_el_listado_por_nombre(client: TestClient) -> None:
    client.post("/api/lists", json={"name": "Compra semanal"})
    client.post("/api/lists", json={"name": "Trabajo"})

    response = client.get("/api/lists", params={"name_contains": "compra"})

    assert response.status_code == 200
    assert response.json()["data"]["total"] == 1
