/**
 * Lectura de la configuracion del front. Gemelo de `src/core/boot/env.py`.
 *
 * Es el UNICO fichero de todo el front que toca `import.meta.env` o `window`.
 * Igual que en el backend, quien lo consume es un repositorio con un getter
 * tipado por cada valor.
 *
 * DOS ORIGENES, y el orden importa:
 *
 *   1. `window.__APP_CONFIG__` — lo inyecta el BACKEND al servir la pagina en el
 *      contenedor. Gana, porque es configuracion de tiempo de ejecucion: se
 *      puede cambiar por entorno sin volver a compilar el front.
 *   2. `import.meta.env` — las variables VITE_*, que se incrustan al compilar.
 *      Es lo que se usa en desarrollo con `npm run dev`.
 */

interface AppConfig {
    apiKey?: string;
    apiBaseUrl?: string;
}

declare global {
    interface Window {
        __APP_CONFIG__?: AppConfig;
    }
}

export function getRuntimeConfig(): AppConfig {
    return window.__APP_CONFIG__ ?? {};
}

export function getBuildConfig(): AppConfig {
    return {
        apiKey: import.meta.env.VITE_APP_API_KEY,
        apiBaseUrl: import.meta.env.VITE_APP_API_BASE_URL,
    };
}
