/**
 * Rutas de la API. Gemelo de la tabla `Routes.BY_PATH` del backend.
 *
 * Estan aqui y no escritas dentro de cada repositorio por la misma razon que en
 * el backend estan en un solo fichero: la lista completa de lo que el front le
 * pide al servidor cabe de un vistazo.
 */
export const ApiPathEnum = {
    BASE: "/api",
    LISTS: "/api/lists",
    TASKS: "/api/tasks",
    HEALTH_CHECK: "/health-check",
} as const;
