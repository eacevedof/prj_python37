# 21 · Backend en otro lenguaje (Node, Go, …)

A veces el repo que hay que envolver no es de Python. La respuesta corta:

> **Se replica la MISMA arquitectura que hay montada en Python.** Cambia la
> sintaxis; no cambian las capas, ni los nombres, ni las reglas.

Esta página es **genérica a propósito**: dice qué se conserva siempre y qué hay
que decidir en cada lenguaje. No hay plantillas concretas todavía. Lee también
[`20-backend-python.md`](20-backend-python.md): es la referencia, y aquí solo se
anotan las diferencias.

---

## Antes de nada: ¿de verdad hace falta?

Que la herramienta que envuelves esté escrita en Go **no obliga** a que tu API lo
esté. Dos opciones, y la primera suele ser la buena:

1. **Levantar esa herramienta al lado y hablarle por HTTP** desde el backend de
   Python de siempre, con un `*_reader_api_repository.py`. Sigues teniendo el kit
   entero: los guardarraíles, las plantillas, el ejemplar. Está explicado en
   [`70-envolver-un-repo.md`](70-envolver-un-repo.md) → *"cuando el repo que te
   dan es un servicio entero"*.

2. **Escribir el backend en ese lenguaje.** Solo si la librería es una biblioteca
   (no un servicio) y no hay equivalente razonable en Python, o si el PoC va a
   pasar a producción en ese stack.

**Pregunta antes de elegir la 2.** Es bastante más trabajo y hoy no tiene
guardarraíles.

---

## Lo que NO cambia nunca

Esto es la arquitectura, y es igual en cualquier lenguaje:

1. **Tres capas, y la flecha va en un solo sentido**:
   `infrastructure → application → domain`.
2. **Una carpeta por caso de uso**, con sus tres piezas: entrada, salida y el que
   hace el trabajo.
3. **Un fichero, una unidad** (clase, struct, tipo), **y el fichero se llama como
   ella**.
4. **El nombre de un repositorio dice de dónde salen los datos**:
   `TasksReaderSqliteRepository`, `TasksReaderApiRepository`.
5. **Los repositorios no capturan errores.** Ni tienen reglas de negocio.
6. **Solo el borde HTTP traduce errores** a códigos de respuesta.
7. **Entre módulos, siempre por un puerto** declarado por quien lo necesita y
   cumplido por un adaptador del otro.
8. **Una tabla de rutas** en un fichero, no decoradores repartidos.
9. **Migraciones `.sql`** numeradas y idempotentes, aplicadas al arrancar.
10. **Un contenedor** que sirve el front compilado y la API.
11. **Ninguna constante suelta**: todas en un enum del dominio.

## Lo único que cambia por lenguaje

**El casing del nombre de fichero**, y nada más:

| Lenguaje | Ficheros | Carpetas |
|---|---|---|
| Python | `create_task_service.py` | `snake_case` |
| TypeScript / Node | `CreateTaskService.ts` | `snake_case` |
| Go | `create_task_service.go` | `snake_case` |

El **nombre del concepto** (`CreateTaskService`) es idéntico en los tres. La ruta
de un artefacto también, salvo el último trozo — igual que ya pasa entre el
backend y el front de Vue.

---

## Cómo se traduce cada pieza

| Concepto | Python | TypeScript / Node | Go |
|---|---|---|---|
| Caso de uso | clase + `__call__(dto)` | clase + `invoke(dto)` | struct + `Invoke(dto)` |
| Construcción | `get_instance()` | `getInstance()` | `NewCreateTaskService()` |
| DTO entrada | `@dataclass(frozen=True)` + `from_primitives()` | clase con campos `readonly` + `fromPrimitives()` | struct con campos no exportados + `NewXFromPrimitives()` |
| DTO salida | `to_dict()` | `toPrimitives()` | `ToMap()` |
| Puerto | `Protocol` | `interface` | `interface` |
| Excepción del módulo | `TasksException` | `TasksException extends Error` | ver abajo: Go no tiene excepciones |
| Enum | `@final class XEnum` / `IntEnum` | `export const XEnum = {...} as const` | `const` tipado o `type X int` |
| Sin herencia | `@final` | `final` no existe: no extender | los structs no se heredan: ya está |

---

## Node / TypeScript

Es el más parecido: **la parte de TypeScript ya está resuelta y probada en el
front**. Léete [`30-frontend-vue.md`](30-frontend-vue.md) y aplica lo mismo al
backend; lo único que cambia es que en vez de `fetch` hay un servidor.

- **Ficheros en PascalCase, carpetas en snake_case.** Igual que el front.
- **Servidor**: Express o Fastify. La tabla de rutas es un objeto
  `"MÉTODO /ruta" → controller`, recorrido en un bucle, como en `routes.py`. **Nada
  de decoradores ni de `app.get(...)` repartidos por el código.**
- **`try/catch` solo en los controllers.** Mismos dos `catch`: el de la excepción
  del módulo y el genérico que registra y devuelve 500.
- **Base de datos**: `node:sqlite` (Node 22+) o `better-sqlite3`, dentro de un
  `AbstractSqliteRepository` con la misma costura de inyección de conexión.
- **TypeScript estricto obligatorio**, con las mismas opciones del `tsconfig.json`
  del front, `noUncheckedIndexedAccess` y `exactOptionalPropertyTypes` incluidas.

## Go

Es el que más se aleja en sintaxis y, curiosamente, **el que más ayuda a cumplir
la arquitectura**, por dos motivos:

- **Los interfaces se cumplen sin declararlo**, igual que los `Protocol` de
  Python. Un adaptador no necesita decir que implementa un puerto: le basta con
  tener los métodos.
- **Los ciclos de imports son un error de compilación.** En Python un ciclo entre
  módulos compila y falla en tiempo de ejecución; en Go no compila. La regla de
  "los adaptadores solo bajan a su propia infraestructura" la impone el compilador.

Lo que hay que decidir y tener claro:

- **No hay excepciones. Los errores son valores.** La regla *"solo el controller
  captura"* se convierte en: **todo devuelve `error` y lo pasa hacia arriba sin
  tocarlo** (`if err != nil { return nil, err }`), y **solo el handler HTTP lo
  traduce** a un código de respuesta, con `errors.Is` / `errors.As` para
  distinguir el error del dominio del inesperado.
  El equivalente de `TasksException` es un tipo de error propio del módulo, con
  su código, y unas funciones constructoras `NewBadRequestError(...)`.
- **Exportado = con mayúscula inicial.** Lo que en Python es `_privado`, en Go es
  minúscula. La intención es la misma: el contrato hacia fuera es lo mínimo.
- **Un paquete por carpeta**, con el nombre de la carpeta.
- **Base de datos**: `database/sql` + `modernc.org/sqlite` (sin cgo, más fácil de
  meter en la imagen) dentro del mismo `AbstractSqliteRepository`.

---

## Los guardarraíles: lo que hay que montar

⚠️ **Esta es la parte importante, y hoy es el hueco del kit.** Sin `make check`,
todo lo anterior son buenas intenciones.

El mínimo innegociable es que **`make check` exista y haga lo mismo**: formato,
tipos y tests, en un solo comando, y que verde signifique lo mismo.

| | Python (hecho) | Node | Go |
|---|---|---|---|
| Formato | `ruff format` | `prettier` o `biome` | `gofmt` (viene con Go) |
| Lint | `ruff check` | `eslint` o `biome` | `golangci-lint` |
| Tipos | `mypy --strict` | `tsc --noEmit` | el compilador |
| Tests | `pytest` | `vitest` o `node:test` | `go test ./...` |
| **Convenciones** | **16 comprobaciones AST** | **por escribir** | **por escribir** |

La fila de abajo es la que da el valor del kit, y es la que falta. Dos caminos
razonables cuando toque:

- **Node**: `eslint-plugin-boundaries` o `import/no-restricted-paths` cubren de
  entrada la regla de capas. Lo de "un fichero una clase" y los sufijos por
  carpeta se escribe con `ts-morph`, que es el equivalente del `ast` de Python.
- **Go**: el linter `depguard` (dentro de `golangci-lint`) cubre la regla de capas
  por configuración, sin escribir código. El resto, con `go/ast`, que está en la
  librería estándar.

**Mientras eso no exista, quien revise ese PoC tiene que leerlo a mano.** Dilo al
entregarlo: es una diferencia real respecto a un PoC en Python.

---

## Qué hacer hoy, en la práctica

1. **Plantéate primero la opción 1** de arriba: envolver el servicio desde Python.
   Resuelve la mayoría de los casos y te quedas con el kit entero.
2. Si de verdad hace falta el otro lenguaje, **avisa antes de empezar**: hay que
   decidir el stack concreto (servidor, driver de base de datos, herramientas) y
   esa decisión se queda para todos los PoC siguientes.
3. **Copia la estructura de carpetas de `todo-app/backend_web` tal cual.** Los
   nombres de carpeta son los mismos en cualquier lenguaje.
4. **Monta `make check` desde el primer día**, aunque de momento solo tenga
   formato + lint + tipos + tests. Añadir un comando a un proyecto que ya está
   verde es fácil; ponerlo cuando ya hay treinta ficheros torcidos, no.
5. **Escribe qué decidiste y por qué** en el `README.md` del PoC. Eso es el
   borrador de la spec concreta que vendrá después (`21-backend-node.md`,
   `22-backend-go.md`).
