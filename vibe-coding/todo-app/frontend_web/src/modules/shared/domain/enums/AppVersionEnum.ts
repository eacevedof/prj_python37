/**
 * Version del front. Gemelo de `app_version_enum.py` del backend.
 *
 * INCREMENTAR en cada cambio que se compile y se despliegue.
 *
 * Es una constante propia del front y NO se lee del backend a proposito: lo que
 * interesa saber es que version del FRONT tiene el navegador cargada, que puede
 * no ser la misma que la del servidor si el bundle se quedo en cache o si la
 * imagen se construyo con codigo viejo.
 *
 * Por eso, que la version del front y la del backend NO coincidan es la senal
 * util: significa que una de las dos partes esta desactualizada.
 */
export const AppVersionEnum = {
    CURRENT: "0.1.0",
} as const;
