import { fileURLToPath, URL } from "node:url";

import vue from "@vitejs/plugin-vue";
import { defineConfig } from "vite";

export default defineConfig({
    plugins: [vue()],
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
        port: 5173,
        proxy: {
            // EN DESARROLLO: el front corre en el 5173 y la API en el 8000, que
            // son origenes distintos. Este proxy hace que el navegador crea que
            // todo viene del 5173.
            //
            // No es un apano: es lo que reproduce en local la situacion real. En
            // el contenedor, la MISMA aplicacion de Python sirve el front y la
            // API, asi que tambien son el mismo origen. Gracias a eso:
            //   - el backend no necesita configurar CORS en ningun entorno
            //   - las llamadas del front son siempre a `/api/...`, sin dominio
            "/api": {
                target: "http://127.0.0.1:8000",
                changeOrigin: true,
            },
            "/health-check": {
                target: "http://127.0.0.1:8000",
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
