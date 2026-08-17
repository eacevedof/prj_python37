# 30 · Frontend en Vue

Vue 3 + Vite + TypeScript + Pinia. Mismas capas que el backend, mismos nombres.

---

## La correspondencia con el backend

La ruta de un fichero es **la misma en los dos lados** salvo el último trozo.
Saltar de uno a otro es mecánico.

| Backend (Python) | Frontend (TypeScript) |
|---|---|
| `application/create_task/create_task_service.py` | `application/create_task/CreateTaskService.ts` |
| `create_task_dto.py` · `from_primitives()` | `CreateTaskDto.ts` · `fromPrimitives()` |
| `tasks_reader_sqlite_repository.py` | `TasksReaderApiRepository.ts` |
| `create_task_controller.py` ← **el único que captura** | `useTasksStore.ts` ← **el único que captura** |
| `routes.py` (tabla de endpoints) | `Routes.ts` (tabla de pantallas) |
| `env.py` + `EnvironmentReaderRawRepository` | `Env.ts` + `EnvironmentReaderRawRepository.ts` |

**Carpetas en `snake_case`** (iguales que en el backend), **ficheros en
`PascalCase`** (la convención de TypeScript). Es la única diferencia.

El repositorio también lleva su origen en el nombre, pero aquí es `Api` en vez de
`Sqlite`: al leer `TasksReaderApiRepository` sabes que esa llamada sale por la red.

---

## Dónde encaja Pinia

**Un store es infraestructura**, y vive en
`<modulo>_mod/infrastructure/stores/use<X>Store.ts`.

Dos razones: es un artefacto de un framework concreto (`defineStore` viene de
Pinia), y lo que guarda es estado de **interfaz** — si está cargando, el último
error, la colección que se muestra. Nada de eso son reglas de negocio.

**El store es al front lo que el controller es al backend.**

| El store PUEDE | El store NO PUEDE |
|---|---|
| Llamar a un Service | Llamar a `fetch` o a un `*ApiRepository` |
| Guardar el resultado en su estado | Contener reglas de negocio |
| **Capturar** la excepción → `state.error` | Ser importado por un Service o el dominio |
| Ser importado por las vistas `.vue` | **Importar el store de otro módulo** |

```typescript
async searchTasks(idList: number): Promise<void> {
    this.isLoading = true;
    this.error = "";
    try {
        const result = await SearchTasksService.getInstance().invoke(
            SearchTasksDto.fromPrimitives({ idList }),
        );
        this.tasks = result.items;
    } catch (exception: unknown) {
        this.error = HttpException.getMessage(exception);
    } finally {
        // `finally`, no al final del try: si algo falla, la pantalla no puede
        // quedarse girando para siempre.
        this.isLoading = false;
    }
}
```

**Es el único sitio del front con `try/catch`.** Las vistas solo **leen**
`error` e `isLoading`. Si te ves poniendo un try/catch en un `.vue`, casi siempre
lo que falta es una acción en el store.

**Y un store no importa otro store.** Si al terminar una tarea hay que refrescar
el contador de la lista, eso lo coordina la vista llamando a los dos, no un store
llamando al otro. Es la misma regla que en el backend, y evita las mismas
dependencias circulares.

---

## Dónde van los `.vue`

En `infrastructure/views/`. Los reutilizables entre módulos, en
`shared/infrastructure/views/`.

**No van en `components/`.** En este proyecto `components` significa lo mismo que
en el backend: utilidades sin interfaz (`Logger`, `DateFormatter`). Si no se fija
esto por escrito, en dos semanas la palabra significa dos cosas distintas en los
dos repos.

---

## Las llamadas a la API

`AbstractApiRepository` se ocupa de las cabeceras, de desenvolver el sobre
`{status, data}` y de convertir un error en excepción. Un repositorio concreto
queda así de corto:

```typescript
export class TasksReaderApiRepository extends AbstractApiRepository {
    public static getInstance(): TasksReaderApiRepository {
        return new TasksReaderApiRepository();
    }

    public async getByList(idList: number): Promise<SearchTasksResponse> {
        return this.getJson<SearchTasksResponse>(`${ApiPathEnum.LISTS}/${idList}/tasks`);
    }
}
```

> **`fetch` no falla con un 404.** Es lo que más sorprende: `fetch` solo lanza si
> no se pudo llegar al servidor. Un 500 lo resuelve con normalidad. Por eso
> `AbstractApiRepository` comprueba `response.ok` a mano. Ya está hecho; solo hay
> que saberlo si algún día tocas ese fichero.

La traducción `snake_case` → `camelCase` se hace **en el ResultDto**, en un solo
sitio. Así las plantillas usan nombres normales de JavaScript y, si la API renombra
un campo, solo hay que tocar una clase.

---

## El sistema de diseño: normalización

Todo el aspecto sale de `src/style.css`. **Ningún tamaño, espacio ni grosor se
escribe a mano en una vista.**

No es manía de orden: es lo que separa una interfaz que parece un producto de una
que parece un prototipo. El color se nota enseguida; lo que se nota sin saber
explicarlo es que **todo cae en la misma rejilla**. Cuando una pantalla usa 13px y
la de al lado 14px, el ojo lo ve aunque nadie sepa decir qué falla.

### Tamaños de fuente

Seis pasos, y cada uno sale de multiplicar el anterior por una razón (~1,125 a
1,27). No son números elegidos sueltos:

| Token | | Para qué |
|---|---|---|
| `--font-size-100` | 12px | etiquetas, chips, pies |
| `--font-size-200` | 14px | texto secundario |
| `--font-size-300` | **16px** | **base**: el texto normal |
| `--font-size-400` | 18px | texto destacado |
| `--font-size-500` | 22px | título de sección |
| `--font-size-600` | 28px | título de página |

Los pasos pequeños van juntos (en una interfaz necesitas 14 **y** 16, y la
diferencia importa) y se separan al subir (entre 22 y 28 tiene que haber salto).

Se numeran **100, 200, 300…** en vez de `sm`/`md`/`lg` a propósito: si mañana hace
falta un paso intermedio, entra como `250` sin renombrar nada. Con `sm`/`md`
acabas inventando `md-plus`.

> **El texto base es 16px, no menos.** Es el tamaño por defecto del navegador.
> Bajarlo "porque se ve más compacto" es el error clásico: quien tiene la vista
> cansada ya lo había ajustado en su navegador, y tú se lo reduces.

### Lo que también es tipografía y se suele olvidar

Un tamaño de fuente sin lo demás no está normalizado. Estas tres escalas existen
por el mismo motivo:

| | Tokens |
|---|---|
| **Altura de línea** | `--leading-tight` 1,2 · `--leading-snug` 1,35 · `--leading-normal` 1,55 |
| **Grosor** | `--weight-regular` 400 · `--weight-medium` 500 · `--weight-semibold` 600 |
| **Espaciado entre letras** | `--tracking-tight` · `--tracking-normal` · `--tracking-wide` |

La altura de línea va **al revés** que el tamaño: cuanto más grande el texto, más
junta la línea. Un título de 28px con interlineado de 1,55 se ve desmontado. Por
eso los `h1`/`h2` no heredan el interlineado del cuerpo.

Tres grosores y no más: con cinco, nadie sabe cuál toca.

### Espaciado y tamaños: una sola escala

Rejilla de 4px, nueve pasos:

```
1 → 4px     2 → 8px     3 → 12px    4 → 16px    5 → 20px
6 → 24px    7 → 32px    8 → 48px    9 → 64px
```

Lineal abajo, donde hace falta precisión; doblando arriba, donde solo importa que
haya aire.

**La misma escala sirve para espaciar y para dimensionar**, porque las dos cosas
viven en la misma rejilla: el hueco entre dos filas y el lado de una casilla se
miden igual. Tener dos escalas distintas es como acaban los márgenes sin cuadrar
con las alturas.

Y `--stroke` (1px) para todos los filetes: si unos separadores son de 1px y otros
de 2, la página se ve sucia sin que sepas por qué.

### Cómo saber si lo estás haciendo bien

```bash
grep -rn "px;\|rem;" --include="*.vue" src/ | grep -v "var(--"
```

**Si eso devuelve algo, tienes un valor fuera de la escala.** O lo cambias por el
token que corresponda, o —si de verdad falta un paso— lo añades a `style.css` y
piensas por qué hacía falta.

---

## La credencial en el navegador

Esto hay que leerlo entero.

**Todo lo que empieza por `VITE_` se incrusta en texto plano dentro del JavaScript
que descarga el navegador.** Cualquiera puede abrirlo y leerlo. Una credencial en
un front **nunca es un secreto**.

Cómo está resuelto aquí:

- **En desarrollo** (`npm run dev`): se usa `VITE_API_KEY` de tu `.env.local`. Es
  la clave local, no sale de tu máquina, no pasa nada.
- **En el contenedor**: el backend **inyecta** la credencial al servir la página,
  en `window.__APP_CONFIG__`. El JavaScript compilado no contiene ninguna
  credencial, así que el mismo artefacto vale para cualquier entorno y cambiarla es
  editar el `.env` y reiniciar.

**Lo que esto NO arregla:** quien abra la página puede leer la credencial mirando
el código fuente. Eso es inevitable en cualquier aplicación de navegador sin
login.

> **La apikey sirve para que la API no esté abierta a rastreadores automáticos.
> NO sirve para separar unos usuarios de otros.** Si el PoC llega a manejar datos
> de más de una persona, hace falta autenticación de verdad, y eso ya no es un
> PoC: es un producto.

---

## Mismo origen, siempre

El navegador pide `/api/...` al mismo sitio del que descargó la página. En los dos
entornos:

- **desarrollo** — el proxy de `vite.config.ts` manda `/api` al puerto 6001
- **contenedor** — la misma aplicación de Python sirve la página y la API

Consecuencia práctica: **el backend no necesita configurar CORS en ningún sitio**,
y en el código del front no hay ningún dominio escrito.

---

## TypeScript estricto

`npm run build` ejecuta `vue-tsc --noEmit` antes de compilar: **si hay un error de
tipos, no hay build**. Es el guardarraíl del front, igual que `make check` lo es
del backend. Y el `Dockerfile-deploy` lo ejecuta también, así que un error de tipos
impide construir la imagen.

Dos opciones del `tsconfig.json` que la gente suele desactivar y que aquí se
quedan:

- **`noUncheckedIndexedAccess`** — `array[0]` puede no existir, y te obliga a
  comprobarlo.
- **`exactOptionalPropertyTypes`** — `campo?: string` no es lo mismo que
  `campo: string | undefined`.

Las dos molestan exactamente donde hay que tener cuidado: al convertir lo que
devuelve la API en objetos tuyos.

---

## Comandos

```bash
make front-install     # una vez
make front-local         # http://localhost:6002, con make local en otra terminal
make front-build       # compila comprobando tipos
```
