# 00 · Cómo montar un PoC, paso a paso

De "me han pedido un PoC" a "negocio lo está probando". Sigue el orden.

---

## Paso 0 · Entender qué te han pedido

Antes de tocar nada, ten claras estas cuatro cosas. Si alguna no la sabes,
pregúntala: es más barato preguntar ahora que rehacerlo luego.

| Pregunta | Por qué importa |
|---|---|
| ¿Qué herramienta o repo hay que envolver? | Define qué dependencias entran y qué puede fallar |
| ¿Qué tiene que poder hacer una persona con esto? | Son los casos de uso, y de ahí sale la estructura |
| ¿Qué datos hay que guardar? | Son las tablas |
| ¿Quién lo va a probar y desde dónde? | Decide si hace falta desplegarlo o basta con local |

Escribe las respuestas en el `README.md` de tu PoC. Te las va a preguntar
cualquiera que lo mire, incluido tú dentro de dos semanas.

---

## Paso 1 · Copiar el ejemplar

```bash
cp -r vibe-coding/todo-app vibe-coding/mi-poc
cd vibe-coding/mi-poc
rm -rf .venv frontend_web/node_modules frontend_web/dist backend_web/storage/database/*.db*
```

**No empieces de cero.** Todo lo que hay en `todo-app` que no sean los dos módulos
de ejemplo es infraestructura que necesitas igual: el arranque, la autenticación,
el migrador, los guardarraíles, Docker. Reescribirlo es perder una tarde para
acabar con algo peor.

## Paso 2 · Renombrar

`todo-app` aparece en estos sitios, y en ninguno más:

```bash
grep -rl "todo-app\|todo_app" --exclude-dir=.venv --exclude-dir=node_modules --exclude-dir=dist .
```

A día de hoy son:

- `makefile` — el mensaje del target `gitpush`
- `backend_web/.env.example` y tu `.env` — `DB_PATH=storage/database/todo_app.db`
- `backend_web/public/main.py` — `FastAPI(title="todo-app")`
- `frontend_web/package.json` — el campo `name`
- `frontend_web/index.html` — el `<title>`
- `docker/*.yml` — los comentarios de ejemplo
- `CLAUDE.md` y `README.md`

## Paso 3 · Dejarlo arrancando, antes de tocar nada

```bash
make venv-install
cp backend_web/.env.example backend_web/.env
make local
```

En otra terminal:

```bash
curl localhost:6001/health-check
```

Tiene que responder `{"status":"ok",...}`. **No sigas hasta que responda.** Si
algo está mal, es mucho más fácil arreglarlo ahora, cuando lo único que hay es el
esqueleto.

Y comprueba que partes de verde:

```bash
make check
```

## Paso 4 · Quitar los módulos de ejemplo

`lists_mod` y `tasks_mod` son un ejemplo de to-do list. Tu PoC va de otra cosa.

```bash
rm -rf backend_web/src/modules/lists_mod backend_web/src/modules/tasks_mod
rm -rf backend_web/tests/integration/test_lists_crud.py \
       backend_web/tests/integration/test_tasks_crud.py \
       backend_web/tests/integration/test_lists_tasks_relation.py
rm -rf backend_web/database/migrations/20260818090500-create-app-lists.sql \
       backend_web/database/migrations/20260818091000-create-app-tasks.sql \
       backend_web/database/migrations/20260818091500-initial-data.sql
rm -rf frontend_web/src/modules/lists_mod frontend_web/src/modules/tasks_mod
```

Deja **la primera migración** (`...-create-migrations-table.sql`): esa es del
sistema, no del ejemplo.

Luego vacía la tabla de rutas de `backend_web/src/core/routes/routes.py` (quita
los imports y deja `BY_PATH = {}`) y la de
`frontend_web/src/core/routes/Routes.ts`.

> **Antes de borrarlos, léelos.** Sobre todo `create_task_service.py`,
> `create_list_controller.py` y los dos puertos. Son quince minutos y te ahorran
> tener que volver aquí a preguntar cómo se hacía cada cosa.

Vuelve a lanzar `make check`. Tiene que seguir verde con los módulos fuera.

## Paso 5 · Pedirle a Claude tus módulos

Ahora sí. Usa un prompt de [`90-prompts.md`](90-prompts.md), que ya incluye lo que
Claude necesita saber.

Un módulo por entidad. Si tu PoC va de documentos y de etiquetas, son
`documents_mod` y `tags_mod`, no un `main_mod` con todo dentro.

## Paso 6 · `make check` en verde

```bash
make check
```

Si sale algo en rojo, el mensaje te dice qué regla se ha roto y cómo arreglarlo.
Si no lo entiendes, búscalo en [`50-guardarrailes.md`](50-guardarrailes.md).

**No sigas con el rojo puesto.** Un fallo de convención al principio son dos
minutos; treinta ficheros después, una tarde.

## Paso 7 · El front

```bash
make front-install
make front-local      # http://localhost:6002
```

Con `make local` corriendo en otra terminal. El front habla con la API a través del
proxy de Vite, así que las dos cosas parecen estar en el mismo sitio — igual que
estarán cuando se despliegue.

## Paso 8 · Verlo entero como se va a desplegar

```bash
make up-deploy-local      # http://localhost:6003
```

Y si lo que quieres es enseñárselo a alguien sin que tenga que instalar nada:

```bash
make up-ephemeral         # http://localhost:6004
```

Ese no pide `.env` ni deja nada en disco: cada arranque empieza de cero. Va bien
para una demo y para comprobar que el PoC arranca **de verdad** desde cero, sin
depender de un fichero que solo tienes tú.

Esto construye la imagen de verdad: compila el front y lo sirve junto con la API
en **un solo contenedor**. Es exactamente lo que se despliega. Si aquí funciona,
en el servidor funciona.

## Paso 9 · Que Claude te revise lo que ha escrito

`make check` comprueba que el código **está bien puesto**. No comprueba que esté
bien *hecho*: un caso de uso que borra la fila equivocada, o una consulta que se
deja el `WHERE delete_date IS NULL`, pasa el `check` en verde.

Para eso hay dos comandos de Claude Code. Se escriben **dentro de Claude**, en el
chat, no en la terminal:

```
/code-review
```

Busca errores de verdad: lógica que no hace lo que dice, casos que se dejan
fuera, cosas duplicadas que se pueden simplificar.

```
/security-review
```

Busca lo otro: credenciales escritas en el código, entradas del usuario que
llegan sin validar a una consulta o a un comando del sistema, endpoints que se
han quedado sin la apikey, ficheros que se escriben donde no toca.

**Los dos miran los cambios de la rama.** Si ya lo has commiteado todo y no queda
diff, no tienen qué revisar; pásales entonces la carpeta de tu módulo:

```
/code-review backend_web/src/modules/mi_entidad_mod
```

### ¿Lo arregla Claude solo, o lo arreglas tú?

Lo arregla **Claude**, pero **no en la misma pasada**. Por defecto los dos
comandos solo **informan**: te dan una lista de hallazgos y no tocan ni un
fichero.

- `/code-review` admite `--fix`, que aplica los arreglos al código él solo.
  **En este kit, no lo uses.** El revisor va a por el fallo; la normativa no es
  su trabajo, y sus arreglos pueden salir con la forma equivocada.
- `/security-review` no arregla: sus hallazgos se corrigen pidiéndolo.

Lo que se hace es leer la lista, decidir qué entra, y pedirlo **en el chat
normal** — ahí Claude sí tiene delante `vibe-specs/` y el ejemplar:

```
Arregla los puntos 1 y 3 de la revisión.

Sigue vibe-specs/ (20-backend-python.md) y copia la forma de todo-app. No
cambies la estructura de capas, ni los nombres de fichero, ni metas lógica en
el controller para resolverlo. Si un arreglo te obliga a saltarte la normativa,
para y dímelo antes de tocar nada.

Al terminar, lanza make check.
```

Está también en [`90-prompts.md`](90-prompts.md), como prompt 8.

**Por qué tanto cuidado:** un arreglo correcto puede llegar con la forma
equivocada — una función suelta en un controller, un `try/except` donde no va,
una constante a nivel de módulo. Eso es exactamente lo que caza `make check`, y
por eso es obligatorio **volver a lanzarlo después de cada arreglo**. La medida no
se toca para que un arreglo pase: si un hallazgo solo se puede arreglar saltándose
la normativa, es que está mal planteado — pregunta.

### Qué hacer con lo que salga

No todo lo que salga hay que arreglarlo — es un PoC, no producción. La regla es:

- **Lo que diga `/security-review`, se arregla.** Es lo que no se puede entregar
  con un "ya lo miraremos": una credencial en el código o un endpoint abierto
  siguen ahí el día que aquello se despliegue.
- **De `/code-review`, lo que sea un error de comportamiento.** Lo demás
  (simplificaciones, gustos) solo si es rápido.
- Si Claude te propone arreglar algo, que **vuelva a lanzar `make check`**
  después. Los arreglos también rompen convenciones.

> Si no entiendes un hallazgo, pídeselo en cristiano: *"explícame ese punto 3 y
> enséñame la línea"*. No apliques un cambio que no entiendes.

## Paso 10 · La lista de comprobación

Antes de enseñárselo a nadie: [`60-checklist-poc.md`](60-checklist-poc.md).

---

## Si necesitas trastear

Tarde o temprano vas a querer crear algo para probar: un script suelto, un volcado
de datos, una copia de un fichero antes de tocarlo.

**Que no acabe en el repositorio.** Dos sitios válidos, en este orden:

1. **Fuera del proyecto** (`/tmp/loquesea`). Es lo mejor: no puede colarse.
2. **`_scratch/`**, dentro del proyecto. Está en el `.gitignore` y en el
   `.dockerignore`, así que ni entra en un commit ni acaba dentro de la imagen.

Lo que no se hace es dejarlo suelto en medio del código. Pasa de verdad: en este
mismo kit, un `mkdir -p` lanzado desde la carpeta equivocada creó un
`backend_web/backend_web/` que nadie usaba, se commiteó, y `docker build` lo metió
dentro de la imagen. Ahora hay un test que lo caza
(`test_no_hay_carpetas_de_paquete_vacias`), pero es mejor no llegar ahí.

> Truco relacionado: antes de un `mkdir -p` con ruta relativa, mira en qué carpeta
> estás. El `cd` se arrastra entre comandos y esa es la forma más fácil de crear un
> árbol paralelo sin enterarte.

## Los cuatro errores que se repiten

1. **Empezar de cero "porque el ejemplar tiene cosas que no necesito".** Lo que
   sobra son dos módulos. Lo demás lo necesitas.
2. **Dejar `make check` en rojo "para arreglarlo luego".** Luego son treinta
   ficheros con el mismo fallo repetido.
3. **Meter todo en un módulo.** Un módulo por entidad. Si dudas, mira si las dos
   cosas se borrarían juntas: si no, son dos módulos.
4. **Copiar el `.env` con la credencial de ejemplo a un servidor.** `API_KEY` se
   cambia siempre antes de desplegar.
