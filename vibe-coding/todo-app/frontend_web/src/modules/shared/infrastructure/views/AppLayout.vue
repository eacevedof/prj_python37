<script setup lang="ts">
import { EnvironmentReaderRawRepository } from "@/modules/shared/infrastructure/repositories/configuration/EnvironmentReaderRawRepository";

/**
 * Marco comun de todas las pantallas.
 *
 * Columna de lectura centrada y de ancho limitado: una lista de tareas a 1400px
 * de ancho deja el ojo viajando de un extremo a otro para relacionar el titulo
 * con su fecha.
 *
 * Aqui se lee la configuracion directamente del repositorio, sin pasar por un
 * store. Es la excepcion, y esta razonada: la configuracion no es un dato que se
 * cargue, no puede fallar y no tiene estados. Un store no anadiria nada, igual
 * que en el backend `public/main.py` llama al lector de entorno sin caso de uso
 * de por medio.
 */
const environmentReaderRawRepository = EnvironmentReaderRawRepository.getInstance();

const appVersion = environmentReaderRawRepository.getAppVersion();
// Si la credencial no llego, TODA llamada a la API va a devolver 401. Merece un
// aviso propio: sin el, el sintoma es un "Invalid or missing X-Api-Key" que
// parece un fallo del codigo y es de configuracion.
const hasApiKey = environmentReaderRawRepository.getApiKey() !== "";
</script>

<template>
    <div class="layout">
        <header class="layout__header">
            <RouterLink to="/" class="layout__brand">todo</RouterLink>
            <span class="layout__version" :title="`Version del front: ${appVersion}`">
                v{{ appVersion }}
            </span>
        </header>

        <p v-if="!hasApiKey" class="layout__warning" role="alert">
            <strong>Falta la credencial.</strong>
            El front no ha recibido ninguna <code>X-Api-Key</code>, así que la API va a
            rechazar todas las llamadas con 401. En local la inyecta Vite leyendo
            <code>APP_API_KEY</code> de <code>backend_web/.env</code>; en el contenedor la
            inyecta el backend al servir esta página.
        </p>

        <main>
            <slot />
        </main>
    </div>
</template>

<style scoped>
.layout {
    max-inline-size: var(--layout-width);
    margin-inline: auto;
    padding-inline: var(--space-6);
    padding-block: var(--space-7) var(--space-9);
}

.layout__header {
    display: flex;
    align-items: baseline;
    justify-content: space-between;
    gap: var(--space-4);
    padding-block-end: var(--space-4);
    margin-block-end: var(--space-7);
    border-block-end: var(--stroke) solid var(--border);
}

.layout__brand {
    color: var(--text);
    font-weight: var(--weight-semibold);
    font-size: var(--font-size-400);
    letter-spacing: var(--tracking-tight);
    text-decoration: none;
}

/* El punto del acento es la unica marca de color del encabezado: gastarlo aqui
   y no en un logotipo grande mantiene la atencion en el contenido. */
.layout__brand::after {
    content: "";
    display: inline-block;
    inline-size: var(--stroke-mark);
    block-size: var(--stroke-mark);
    margin-inline-start: var(--space-1);
    border-radius: var(--radius-pill);
    background: var(--accent);
}

/* En monoespaciada porque es un dato, no texto. */
.layout__version {
    color: var(--text-subtle);
    font-family: var(--font-mono);
    font-size: var(--font-size-100);
    font-variant-numeric: tabular-nums;
}

.layout__warning {
    margin-block: 0 var(--space-6);
    padding: var(--space-3) var(--space-4);
    border-inline-start: var(--stroke-mark) solid var(--danger);
    border-radius: var(--radius-md);
    background: var(--danger-soft);
    color: var(--danger);
    font-size: var(--font-size-200);
    text-wrap: pretty;
}

.layout__warning code {
    font-family: var(--font-mono);
    font-size: var(--font-size-100);
}
</style>
