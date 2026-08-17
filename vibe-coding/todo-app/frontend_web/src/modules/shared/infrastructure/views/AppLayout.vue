<script setup lang="ts">
/**
 * Marco comun de todas las pantallas.
 *
 * Columna de lectura centrada y de ancho limitado: el texto largo en lineas
 * anchas se lee mal, y una lista de tareas a 1400px de ancho deja el ojo
 * viajando de un extremo a otro para relacionar el titulo con su fecha.
 */
</script>

<template>
    <div class="layout">
        <header class="layout__header">
            <RouterLink to="/" class="layout__brand">todo</RouterLink>
            <span class="layout__note">ejemplar del kit vibe-coding</span>
        </header>

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

.layout__note {
    color: var(--text-subtle);
    font-size: var(--font-size-100);
}
</style>
