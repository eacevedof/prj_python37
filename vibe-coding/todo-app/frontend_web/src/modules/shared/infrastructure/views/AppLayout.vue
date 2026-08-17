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
    max-inline-size: var(--content-width);
    margin-inline: auto;
    padding-inline: var(--space-5);
    padding-block: var(--space-6) var(--space-7);
}

.layout__header {
    display: flex;
    align-items: baseline;
    justify-content: space-between;
    gap: var(--space-4);
    padding-block-end: var(--space-4);
    margin-block-end: var(--space-6);
    border-block-end: 1px solid var(--border);
}

.layout__brand {
    color: var(--text);
    font-weight: 600;
    font-size: var(--text-lg);
    letter-spacing: -0.02em;
    text-decoration: none;
}

/* El punto del acento es la unica marca de color del encabezado: gastarlo aqui
   y no en un logotipo grande mantiene la atencion en el contenido. */
.layout__brand::after {
    content: "";
    display: inline-block;
    inline-size: 5px;
    block-size: 5px;
    margin-inline-start: 3px;
    border-radius: var(--radius-pill);
    background: var(--accent);
}

.layout__note {
    color: var(--text-subtle);
    font-size: var(--text-xs);
}
</style>
