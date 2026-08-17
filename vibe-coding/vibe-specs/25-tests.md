# 25 · Los tests que tienes que escribir

`make check` trae los tests de convención puestos. **Los que comprueban que tu PoC
hace lo que tiene que hacer los escribes tú**, y esta página dice cómo.

---

## Cuáles hacen falta

**Un fichero por módulo**, en `backend_web/tests/integration/`:

```
tests/integration/
├── test_auth.py              ya viene: no lo toques
├── test_notes_crud.py        el tuyo
└── test_documents_crud.py    el tuyo
```

Son tests de **integración**: entran por la ruta real, pasan por el front
controller, el controller, el caso de uso y el repositorio, y tocan una base de
datos de verdad. No se prueban clases sueltas.

¿Por qué no tests unitarios de cada service? Porque en un PoC lo que importa es
que el camino completo funcione. Un test que pasa por todo detecta más problemas
por línea escrita, y no hay que reescribirlo cada vez que cambias algo por dentro.

## La base de datos de los tests

Es **SQLite de verdad, en memoria**, con las migraciones reales aplicadas. Se crea
y se destruye en cada test, así que ninguno depende de otro.

No hay que hacer nada para que funcione: lo monta `tests/conftest.py`.

> **No escribas un "doble" de la base de datos.** Un doble solo sabe responder a lo
> que has previsto: si tu SQL tiene un error de sintaxis, el doble no se entera y
> el test pasa igual. Con SQLite de verdad revienta en el test, que es donde
> quieres enterarte.

## Los dos fixtures

| Fixture | Qué es |
|---|---|
| `client` | Cliente HTTP **con la credencial** puesta. El que usarás siempre |
| `anonymous_client` | Sin credencial. Solo para probar el borde de autenticación |

```python
from fastapi.testclient import TestClient


def test_crear_una_nota(client: TestClient) -> None:
    response = client.post("/api/notes", json={"title": "Comprar leche"})

    assert response.status_code == 201
    assert response.json()["data"]["title"] == "Comprar leche"
```

No hace falta importar nada más ni configurar nada: pides `client` como argumento
y ya está.

## Cómo se escribe uno

**Los nombres en castellano y describiendo el comportamiento**, no el método:

```python
def test_crear_sin_titulo_devuelve_400(...)          # sí
def test_no_deja_borrar_una_lista_con_tareas(...)    # sí
def test_create_note_service(...)                    # no: eso es el nombre de una clase
```

Cuando uno falla, lo primero que se ve es su nombre. Si el nombre dice qué se ha
roto, muchas veces no hace falta abrir nada.

**Tres bloques, separados por una línea en blanco**: preparar, actuar, comprobar.

```python
def test_no_deja_dos_notas_con_el_mismo_titulo(client: TestClient) -> None:
    client.post("/api/notes", json={"title": "Compra"})

    response = client.post("/api/notes", json={"title": "compra"})

    assert response.status_code == 409
```

**Una cosa por test.** Si estás comprobando dos comportamientos, son dos tests.

**Un ayudante para lo que se repita**, con guion bajo delante para que pytest no
lo confunda con un test:

```python
def _get_new_note_id(client: TestClient, title: str = "Compra") -> int:
    return int(client.post("/api/notes", json={"title": title}).json()["data"]["id"])
```

## Qué hay que cubrir, como mínimo

Por cada módulo:

- [ ] **Crear** → 201, y el `id` que devuelve es mayor que 0
- [ ] **Listar** → aparece lo que acabas de crear
- [ ] **Obtener uno** → devuelve lo que guardaste
- [ ] **Obtener uno que no existe** → 404
- [ ] **Modificar** → devuelve el cambio
- [ ] **Borrar** → 200, y después desaparece del listado
- [ ] **Cada validación del `_fail_if_wrong_input`** → 400
- [ ] **Cada `conflict_custom`** → 409

Y si tu módulo usa un **puerto**, el test más valioso del PoC:

```python
def test_crear_una_tarea_en_una_lista_inexistente_devuelve_404(client: TestClient) -> None:
    # El puerto en acción: sin él, esto sería un error de integridad de la base
    # de datos convertido en un 500 que no le dice nada a nadie.
    response = client.post("/api/tasks", json={"id_list": 9999, "title": "fantasma"})

    assert response.status_code == 404
```

## Cosas que NO hay que hacer

- **No crees una migración de datos iniciales para tus tests.** Cada test prepara
  lo que necesita. Si dependen de datos que trae la base, cambiar esos datos rompe
  tests que no tienen nada que ver.
- **No dependas del orden.** Cada test arranca con la base recién creada, así que
  no se puede "reutilizar" lo que dejó el anterior. Es a propósito.
- **No pongas `sleep`.** Si algo tarda, es que hay un problema de diseño.
- **No pruebes contra la base de fichero.** `make test` no debe tocar
  `storage/database/`. Si un test la modifica, algo está mal cableado.

## Ejecutar

```bash
make test                                                    # todos
cd backend_web && ../.venv/bin/python -m pytest tests/integration/test_notes_crud.py -v
```

`-v` muestra el nombre de cada test, que con nombres en castellano se lee como una
lista de lo que hace tu módulo.
