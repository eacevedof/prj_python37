/**
 * Claves del sobre de respuesta de la API. Gemelo de `response_key_enum.py`.
 *
 * Aqui se ve para que sirve tener el mismo enum en los dos lados: si el backend
 * cambia "data" por otra cosa, el sitio donde hay que tocar en el front es UNO.
 */
export const ResponseKeyEnum = {
    STATUS: "status",
    DATA: "data",
    ERROR: "error",
} as const;
