# vibe-specs — normativa para montar un PoC

Esto es lo que hay que leer **antes** de escribir código en un PoC nuevo.

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
| Añadir o tocar algo del front | [`30-frontend-vue.md`](30-frontend-vue.md) |
| Añadir una tabla o cambiar la base de datos | [`40-base-de-datos.md`](40-base-de-datos.md) |
| Entender por qué `make check` está en rojo | [`50-guardarrailes.md`](50-guardarrailes.md) |
| Envolver una herramienta o librería de GitHub | [`70-envolver-un-repo.md`](70-envolver-un-repo.md) |
| Saber si el PoC está listo para enseñarlo | [`60-checklist-poc.md`](60-checklist-poc.md) |
| Pedirle algo a Claude sin quedarte corto | [`90-prompts.md`](90-prompts.md) |

## La regla de oro

> Si `make check` está en verde, el PoC es mantenible.
> Si está en rojo, todavía no has terminado — aunque la aplicación funcione.

Que la aplicación funcione y que el código sea mantenible son dos cosas distintas.
`make check` mide la segunda, que es la que le cuesta dinero al equipo que venga
después.

## Qué NO cubre esto (todavía)

Ahora mismo la normativa está escrita para **backend en Python**. La mayoría de
los PoC lo son, así que es por donde se empieza.

Cuando toque envolver algo escrito en **Node** o en **Go**, la arquitectura y los
nombres serán los mismos (están pensados para no depender del lenguaje), pero
faltan las plantillas concretas. Se añadirán como `21-backend-node.md` y
`22-backend-go.md`. Hasta entonces, pregunta antes de improvisar.
