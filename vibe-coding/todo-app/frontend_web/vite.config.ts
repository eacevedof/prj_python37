import { readFileSync } from "node:fs";
import { fileURLToPath, URL } from "node:url";

import vue from "@vitejs/plugin-vue";
import { defineConfig, type Plugin } from "vite";

/**
 * Lee `APP_API_KEY` del `.env` DEL BACKEND.
 *
 * El front no tiene su propia copia de la credencial a proposito. Tenerla en dos
 * ficheros significa mantenerlos sincronizados a mano, y el dia que no coinciden
 * el sintoma es un 401 que parece un fallo de codigo y no de configuracion.
 *
 * Devuelve cadena vacia si no encuentra el fichero: entonces la API responde 401
 * y el mensaje ya dice que falta la credencial.
 */
function getBackendApiKey(): string {
    try {
        const envPath = fileURLToPath(new URL("../backend_web/.env", import.meta.url));
        const line = readFileSync(envPath, "utf-8")
            .split("\n")
            .find((each) => each.trim().startsWith("APP_API_KEY="));
        return line === undefined ? "" : line.split("=").slice(1).join("=").trim();
    } catch {
        return "";
    }
}

/**
 * En DESARROLLO, inyecta en la pagina la misma configuracion que el backend
 * inyecta al servirla en el contenedor.
 *
 * Gracias a esto, el front lee la configuracion del MISMO sitio en los dos
 * entornos (`window.__APP_CONFIG__`) y en local no hace falta configurar nada.
 *
 * `apply: "serve"` es importante: esto NO se ejecuta al compilar. El artefacto
 * que se despliega no puede llevar ninguna credencial dentro.
 */
function injectAppConfig(): Plugin {
    return {
        name: "inject-app-config",
        apply: "serve",
        transformIndexHtml(html: string): string {
            const appConfig = JSON.stringify({ apiKey: getBackendApiKey() });
            return html.replace("<head>", `<head><script>window.__APP_CONFIG__=${appConfig};</script>`);
        },
    };
}

export default defineConfig({
    plugins: [vue(), injectAppConfig()],
    resolve: {
        // Alias '@' = src/. La normativa prohibe las rutas relativas del tipo
        // `../../../`: en TypeScript la forma de cumplirlo es este alias.
        // OJO: tiene que estar declarado tambien en `tsconfig.json` (en "paths").
        // Vite lo resuelve al ejecutar y TypeScript al comprobar tipos: si solo
        // esta en uno de los dos, funciona pero el editor marca errores rojos (o
        // al reves, y entonces compila pero revienta en el navegador).
        alias: { "@": fileURLToPath(new URL("./src", import.meta.url)) },
    },
    server: {
        port: 6002,
        proxy: {
            // EL FRONT Y LA API TIENEN QUE SER EL MISMO ORIGEN. Este proxy hace
            // que el navegador crea que `/api` sale del propio 6002.
            //
            // No es un apano: reproduce en local la situacion real. En el
            // contenedor, la MISMA aplicacion de Python sirve la pagina y la API.
            // Gracias a eso el backend no necesita CORS en ningun entorno.
            //
            // ⚠️ Por eso NO pongas una URL en VITE_APP_API_BASE_URL. Si apuntas
            // el front a `http://localhost:6001`, las peticiones pasan a ser de
            // otro origen: el navegador manda antes una peticion OPTIONS de
            // comprobacion, la API responde 405 porque no tiene CORS, y la
            // llamada real ni se envia.
            "/api": {
                target: "http://127.0.0.1:6001",
                changeOrigin: true,
            },
            "/health-check": {
                target: "http://127.0.0.1:6001",
                changeOrigin: true,
            },
        },
    },
    build: {
        // El backend sirve esta carpeta como estatica cuando existe. La imagen de
        // Docker la genera en una etapa de compilacion y la copia dentro.
        outDir: "dist",
    },
});
