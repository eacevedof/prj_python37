---
name: workitems-conventions
description: Convenciones para crear work items en Azure DevOps. Usa cuando crees épicas, tareas o bugs para seguir los estándares del equipo.
---

# Work Items Conventions

Reglas y convenciones para crear work items en Azure DevOps.

## Formato de Títulos

### Épicas
- Formato: `[Módulo] Descripción funcional`
- Ejemplo: `[Auth] Sistema de autenticación con OAuth2`

### Tareas
- Formato: `[Verbo] descripción específica`
- Verbos permitidos: Implementar, Configurar, Corregir, Refactorizar, Documentar
- Ejemplo: `Implementar endpoint POST /users`

### Bugs
- Formato: `[BUG] Descripción del problema`
- Ejemplo: `[BUG] Error 500 al enviar formulario vacío`

## Campos Obligatorios

| Tipo | Campos requeridos |
|------|-------------------|
| Epic | title, description, tags |
| Task | title, epic_id, assigned_to |
| Bug | title, severity, steps to reproduce |

## Tags Estándar

- `backend`, `frontend`, `infra`, `docs`
- `priority:high`, `priority:medium`, `priority:low`
- `tech-debt`, `security`, `performance`

## Due Dates

- Las tareas DEBEN tener fecha límite
- Formato en título: `Título de la tarea 2024-12-31`
- El MCP extrae automáticamente la fecha del título

## Enlaces entre Work Items (HTML)

Para que los enlaces a work items se muestren correctamente en Azure DevOps, **NUNCA** usar `#ID` como texto plano. Usar el formato HTML completo con `data-vss-mention`:

```html
<a href="https://dev.azure.com/{org}/{project}/_workitems/edit/{ID}/" data-vss-mention="version:1.0">#{ID}</a>
```

### Ejemplo real

```html
<a href="https://dev.azure.com/lazarustechnology/caser-helvetia-telemetria/_workitems/edit/1991/" data-vss-mention="version:1.0">#1991</a>
```

## Estructura de Descripciones

### Épicas - Descripción

La descripción de una épica DEBE incluir la lista de tareas hijas con enlaces:

```html
<h2>Tareas</h2>
<ol>
  <li><a href="https://dev.azure.com/{org}/{project}/_workitems/edit/{ID}/" data-vss-mention="version:1.0">#{ID}</a> - descripción breve (dd/mm)</li>
  <li>...</li>
</ol>
```

### Tareas - Descripción

La descripción de una tarea DEBE comenzar con el enlace a la épica:

```html
<p>Épica: <a href="https://dev.azure.com/{org}/{project}/_workitems/edit/{EPIC_ID}/" data-vss-mention="version:1.0">#{EPIC_ID}</a></p>
<h2>Descripción</h2>
<ol>
  <li>Punto 1</li>
  <li>Punto 2</li>
</ol>
```

## Proceso de Creación

1. Crear la épica primero
2. Crear cada tarea con `epic_id` y enlace a la épica en descripción
3. Actualizar la épica agregando los enlaces a todas las tareas hijas

## Ejemplos

### Crear tarea correctamente

```
title: "Implementar validación de email 2024-12-15"
epic_id: 123
assigned_to: "dev@empresa.com"
tags: "backend,validation"
```

### Crear bug correctamente

```
title: "[BUG] Login falla con caracteres especiales"
description: |
  ## Pasos para reproducir
  1. Ir a /login
  2. Ingresar usuario con ñ
  3. Error 500

  ## Comportamiento esperado
  Login exitoso
tags: "backend,auth,priority:high"
```
