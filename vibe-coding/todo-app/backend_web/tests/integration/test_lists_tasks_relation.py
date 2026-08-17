"""La relacion entre los dos modulos, a traves de sus puertos.

Estos son los tests mas importantes del ejemplar. No prueban un CRUD: prueban que
los dos puertos hacen su trabajo, que es la pieza que hay que copiar cuando un PoC
tenga dos entidades relacionadas.

    ListsReader   (tasks pregunta a lists)  -> "¿existe esta lista?"
    TasksCounter  (lists pregunta a tasks)  -> "¿cuantas tareas abiertas tiene?"

Si alguien "simplifica" el codigo importando el repositorio del otro modulo
directamente, estos tests seguiran pasando -el comportamiento es el mismo- pero el
test de dependencias entre capas fallara. Los dos hacen falta: uno protege el
comportamiento, el otro la estructura.
"""

from fastapi.testclient import TestClient


def test_crear_tarea_en_lista_inexistente_devuelve_404(client: TestClient) -> None:
    # PUERTO ListsReader en accion: tasks pregunta antes de escribir. Sin el, esto
    # reventaria como error de integridad de la base de datos y devolveria un 500.
    response = client.post("/api/tasks", json={"id_list": 9999, "title": "fantasma"})

    assert response.status_code == 404
    assert "9999" in response.json()["error"]


def test_mover_una_tarea_a_una_lista_inexistente_devuelve_404(client: TestClient) -> None:
    # La comprobacion tambien esta al editar, porque UpdateTask puede mover la
    # tarea de lista.
    list_id = client.post("/api/lists", json={"name": "Compra"}).json()["data"]["id"]
    task_id = client.post("/api/tasks", json={"id_list": list_id, "title": "Leche"}).json()["data"]["id"]

    response = client.put(f"/api/tasks/{task_id}", json={"id_list": 9999, "title": "Leche"})

    assert response.status_code == 404


def test_el_listado_de_listas_trae_el_contador_de_tareas_abiertas(client: TestClient) -> None:
    # PUERTO TasksCounter en accion: el dato viene del modulo de tareas.
    list_id = client.post("/api/lists", json={"name": "Compra"}).json()["data"]["id"]
    client.post("/api/tasks", json={"id_list": list_id, "title": "Leche"})
    client.post("/api/tasks", json={"id_list": list_id, "title": "Pan"})

    response = client.get("/api/lists")

    items = {item["id"]: item for item in response.json()["data"]["items"]}
    assert items[list_id]["open_tasks_count"] == 2


def test_el_contador_solo_cuenta_las_tareas_sin_terminar(client: TestClient) -> None:
    list_id = client.post("/api/lists", json={"name": "Compra"}).json()["data"]["id"]
    task_id = client.post("/api/tasks", json={"id_list": list_id, "title": "Leche"}).json()["data"]["id"]
    client.post("/api/tasks", json={"id_list": list_id, "title": "Pan"})

    client.patch(f"/api/tasks/{task_id}/done", json={"is_done": True})

    assert client.get(f"/api/lists/{list_id}").json()["data"]["open_tasks_count"] == 1


def test_no_deja_borrar_una_lista_con_tareas_sin_terminar(client: TestClient) -> None:
    # Regla de negocio: borrar en silencio trabajo pendiente es una sorpresa
    # desagradable. Mejor un 409 que explique por que.
    list_id = client.post("/api/lists", json={"name": "Compra"}).json()["data"]["id"]
    client.post("/api/tasks", json={"id_list": list_id, "title": "Leche"})

    response = client.delete(f"/api/lists/{list_id}")

    assert response.status_code == 409
    assert "sin terminar" in response.json()["error"]


def test_al_terminar_las_tareas_ya_deja_borrar_la_lista(client: TestClient) -> None:
    list_id = client.post("/api/lists", json={"name": "Compra"}).json()["data"]["id"]
    task_id = client.post("/api/tasks", json={"id_list": list_id, "title": "Leche"}).json()["data"]["id"]
    client.patch(f"/api/tasks/{task_id}/done", json={"is_done": True})

    response = client.delete(f"/api/lists/{list_id}")

    assert response.status_code == 200


def test_borrar_las_tareas_tambien_libera_la_lista(client: TestClient) -> None:
    # Una tarea borrada no cuenta: el contador filtra por delete_date IS NULL.
    list_id = client.post("/api/lists", json={"name": "Compra"}).json()["data"]["id"]
    task_id = client.post("/api/tasks", json={"id_list": list_id, "title": "Leche"}).json()["data"]["id"]
    client.delete(f"/api/tasks/{task_id}")

    response = client.delete(f"/api/lists/{list_id}")

    assert response.status_code == 200
