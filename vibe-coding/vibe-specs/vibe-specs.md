# vibe-specs — el índice: qué encargo tienes y dónde está su normativa

Esto es lo que hay que leer **antes** de ponerse con cualquier encargo de esta
carpeta. Este fichero es el índice: di qué te han encargado y te dice qué leer.

## Lo primero de todo: escoge qué te han encargado

Nada de este kit se lee entero ni en orden. Se entra por aquí, se contesta a
**dos preguntas**, y eso te dice qué leer y qué va a salir.

### Pregunta 1 · ¿Qué te han encargado?

| Te encargan... | Entras por | Sale |
|---|---|---|
| **Un PoC rápido** de una herramienta o idea | [`00-como-usar-esto.md`](00-como-usar-esto.md) | una aplicación que funciona |
| **Analizar la seguridad** de un código | [`80-analizar-seguridad.md`](80-analizar-seguridad.md) | un informe |
| **Un mockup** para enseñar antes de construir | [`85-mockups.md`](85-mockups.md) | una interfaz navegable con datos falsos |
| **Clonar una función** de otro fabricante | [`70-envolver-un-repo.md`](70-envolver-un-repo.md#cuando-no-hay-repo-clonar-la-funcionalidad-de-otro-fabricante) | un PoC (con sus límites legales) |

### Pregunta 2 · Si sale un PoC: ¿qué necesita estar corriendo, además de tu app?

Esto decide la **índole** del despliegue, y conviene saberla **antes** del primer
módulo — lo explica [`65-despliegue.md`](65-despliegue.md):

| Índole | Cuándo | Contenedores |
|---|---|---|
| **A** | front + API + SQLite y nada más (lo normal) | 1 — el ejemplar tal cual |
| **B** | tu app necesita piezas de apoyo: un Redis/Valkey, un Tor, un worker periódico | 1 + sidecars, mismo compose |
| **C** | envuelves una aplicación completa que vive sola (su web, su BD, su compose) | 2 despliegues separados, por HTTP |

Con las dos respuestas dichas **en voz alta** (en el `README.md` del PoC y a
quien te lo encargó), ya sabes qué leer. Sin ellas, no empieces.

## Por qué existe

Cuando llega una petición del tipo *"haznos un PoC de este repo de GitHub"*, la
forma rápida de resolverla es pedirle a Claude que escriba algo que funcione. Eso
funciona, y ahí acaba lo bueno: cada PoC sale con una estructura distinta, y
cuando uno pasa a producción, el equipo de desarrollo se encuentra con código que
no se parece a nada de lo que ya mantiene.

Este kit resuelve eso de una forma concreta: **hay una sola forma de montar un
PoC, está escrita aquí, y hay un programa que comprueba si la has seguido.**

No hace falta que sepas programar para usarlo. Hace falta que sepas dos cosas:

1. **Dónde va cada cosa** — lo cuenta esta carpeta.
2. **Cómo saber si lo has hecho bien** — lo dice `make check`.

## Las tres piezas del kit

```
vibe-coding/
├── vibe-specs/     ← estás aquí: la normativa
├── todo-app/       ← el EJEMPLAR: un CRUD completo que cumple la normativa
└── CLAUDE.md       ← lo que lee Claude al abrir la carpeta
```

El ejemplar no es documentación de adorno: es de donde se copia. Cada regla de
esta carpeta tiene su ejemplo real ahí, y esta carpeta te dice cuál mirar.

## Por dónde empezar

| Si vas a... | Lee |
|---|---|
| Montar un PoC nuevo, ahora | [`00-como-usar-esto.md`](00-como-usar-esto.md) |
| Entender por qué el código está partido así | [`10-arquitectura.md`](10-arquitectura.md) |
| Añadir o tocar algo del backend | [`20-backend-python.md`](20-backend-python.md) |
| Añadir o tocar algo del backend, **en Node o Go** | [`21-backend-otros-lenguajes.md`](21-backend-otros-lenguajes.md) |
| Escribir los tests de tu módulo | [`25-tests.md`](25-tests.md) |
| Añadir o tocar algo del front | [`30-frontend-vue.md`](30-frontend-vue.md) |
| Añadir una tabla o cambiar la base de datos | [`40-base-de-datos.md`](40-base-de-datos.md) |
| Entender por qué `make check` está en rojo | [`50-guardarrailes.md`](50-guardarrailes.md) |
| Desplegar, o añadir contenedores al lado de la app | [`65-despliegue.md`](65-despliegue.md) |
| Envolver una herramienta o librería de GitHub | [`70-envolver-un-repo.md`](70-envolver-un-repo.md) |
| Auditar la seguridad de un repo ajeno | [`80-analizar-seguridad.md`](80-analizar-seguridad.md) |
| Montar un mockup sin backend | [`85-mockups.md`](85-mockups.md) |
| Saber si el PoC está listo para enseñarlo | [`60-checklist-poc.md`](60-checklist-poc.md) |
| Pedirle algo a Claude sin quedarte corto | [`90-prompts.md`](90-prompts.md) |

## La regla de oro

> Si `make check` está en verde, el PoC es mantenible.
> Si está en rojo, todavía no has terminado — aunque la aplicación funcione.

Que la aplicación funcione y que el código sea mantenible son dos cosas distintas.
`make check` mide la segunda, que es la que le cuesta dinero al equipo que venga
después.

Lo que `make check` **no** mide es si el código hace lo que dice y si deja algún
agujero. Para eso, antes de entregar, se pasan `/code-review` y `/security-review`
dentro de Claude Code — [paso 9 de `00-como-usar-esto.md`](00-como-usar-esto.md#paso-9--que-claude-te-revise-lo-que-ha-escrito).

## Si el backend no es Python

La normativa detallada está escrita para **Python**, que es lo que son casi todos
los PoC. Para **Node o Go** hay una spec genérica —
[`21-backend-otros-lenguajes.md`](21-backend-otros-lenguajes.md) — que dice lo
único que hay que saber: **se replica la misma arquitectura**, cambia la sintaxis
y nada más.

Lo que ahí falta, y hay que tener presente, son los **tests de convención**: en
Python los trae puestos `make check`, y en Node o Go todavía no existen. Un PoC en
esos lenguajes hay que revisarlo a mano.

Antes de arrancar uno, léete esa página entera: la primera pregunta que hace es si
de verdad hace falta cambiar de lenguaje, y muchas veces la respuesta es que no.
