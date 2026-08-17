"""CRUD de tareas de punta a punta, por HTTP."""

from fastapi.testclient import TestClient


def _get_new_list_id(client: TestClient, name: str = "Compra") -> int:
    return int(client.post("/api/lists", json={"name": name}).json()["data"]["id"])


def test_crear_una_tarea(client: TestClient) -> None:
    list_id = _get_new_list_id(client)

    response = client.post(
        "/api/tasks",
        json={"id_list": list_id, "title": "Leche", "description": "entera", "due_date": "2026-08-25"},
    )

    assert response.status_code == 201
    data = response.json()["data"]
    assert data["title"] == "Leche"
    assert data["is_done"] is False
    assert data["due_date"] == "2026-08-25"


def test_crear_sin_titulo_devuelve_400(client: TestClient) -> None:
    list_id = _get_new_list_id(client)

    response = client.post("/api/tasks", json={"id_list": list_id})

    assert response.status_code == 400
    assert "title" in response.json()["error"]


def test_crear_con_fecha_mal_formada_devuelve_400(client: TestClient) -> None:
    list_id = _get_new_list_id(client)

    response = client.post("/api/tasks", json={"id_list": list_id, "title": "X", "due_date": "25/08/2026"})

    assert response.status_code == 400


def test_marcar_hecha_y_volver_a_pendiente(client: TestClient) -> None:
    list_id = _get_new_list_id(client)
    task_id = client.post("/api/tasks", json={"id_list": list_id, "title": "Leche"}).json()["data"]["id"]

    done_response = client.patch(f"/api/tasks/{task_id}/done", json={"is_done": True})
    assert done_response.status_code == 200
    assert done_response.json()["data"]["is_done"] is True

    pending_response = client.patch(f"/api/tasks/{task_id}/done", json={"is_done": False})
    assert pending_response.json()["data"]["is_done"] is False


def test_marcar_hecha_dos_veces_deja_el_mismo_resultado(client: TestClient) -> None:
    # Idempotencia: se manda el estado deseado, no un interruptor que alterna. Dos
    # pestanas del navegador pulsando a la vez no pueden dejarla pendiente.
    list_id = _get_new_list_id(client)
    task_id = client.post("/api/tasks", json={"id_list": list_id, "title": "Leche"}).json()["data"]["id"]

    client.patch(f"/api/tasks/{task_id}/done", json={"is_done": True})
    response = client.patch(f"/api/tasks/{task_id}/done", json={"is_done": True})

    assert response.json()["data"]["is_done"] is True


def test_modificar_una_tarea(client: TestClient) -> None:
    list_id = _get_new_list_id(client)
    task_id = client.post("/api/tasks", json={"id_list": list_id, "title": "Leche"}).json()["data"]["id"]

    response = client.put(f"/api/tasks/{task_id}", json={"id_list": list_id, "title": "Leche desnatada"})

    assert response.status_code == 200
    assert response.json()["data"]["title"] == "Leche desnatada"


def test_modificar_no_cambia_el_estado_de_hecha(client: TestClient) -> None:
    # UpdateTask no toca `is_done`: para eso esta SetTaskDone. Este test fija esa
    # separacion, que es facil de romper al anadir campos.
    list_id = _get_new_list_id(client)
    task_id = client.post("/api/tasks", json={"id_list": list_id, "title": "Leche"}).json()["data"]["id"]
    client.patch(f"/api/tasks/{task_id}/done", json={"is_done": True})

    response = client.put(f"/api/tasks/{task_id}", json={"id_list": list_id, "title": "Otra cosa"})

    assert response.json()["data"]["is_done"] is True


def test_borrar_una_tarea(client: TestClient) -> None:
    list_id = _get_new_list_id(client)
    task_id = client.post("/api/tasks", json={"id_list": list_id, "title": "Leche"}).json()["data"]["id"]

    assert client.delete(f"/api/tasks/{task_id}").status_code == 200
    assert client.get(f"/api/tasks/{task_id}").status_code == 404


def test_filtrar_por_estado(client: TestClient) -> None:
    list_id = _get_new_list_id(client)
    done_id = client.post("/api/tasks", json={"id_list": list_id, "title": "Hecha"}).json()["data"]["id"]
    client.post("/api/tasks", json={"id_list": list_id, "title": "Pendiente"})
    client.patch(f"/api/tasks/{done_id}/done", json={"is_done": True})

    pendientes = client.get("/api/tasks", params={"id_list": list_id, "is_done": 0}).json()["data"]
    hechas = client.get("/api/tasks", params={"id_list": list_id, "is_done": 1}).json()["data"]
    todas = client.get("/api/tasks", params={"id_list": list_id}).json()["data"]

    assert pendientes["total"] == 1
    assert hechas["total"] == 1
    # Sin el filtro salen las dos: `is_done` ausente NO es lo mismo que is_done=0.
    assert todas["total"] == 2


def test_el_subrecurso_de_la_lista_devuelve_sus_tareas(client: TestClient) -> None:
    list_id = _get_new_list_id(client)
    otra_list_id = _get_new_list_id(client, "Trabajo")
    client.post("/api/tasks", json={"id_list": list_id, "title": "Leche"})
    client.post("/api/tasks", json={"id_list": otra_list_id, "title": "Informe"})

    response = client.get(f"/api/lists/{list_id}/tasks")

    assert response.status_code == 200
    assert response.json()["data"]["total"] == 1
    assert response.json()["data"]["items"][0]["title"] == "Leche"
