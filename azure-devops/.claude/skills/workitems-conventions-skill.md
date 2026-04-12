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
