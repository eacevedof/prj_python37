<script setup lang="ts">
/** Marco comun de todas las pantallas. */
</script>

<template>
    <div class="layout">
        <header class="layout__header">
            <RouterLink to="/" class="layout__title">todo-app</RouterLink>
            <span class="layout__hint">ejemplar de referencia del kit vibe-coding</span>
        </header>
        <main class="layout__main">
            <slot />
        </main>
    </div>
</template>

<style scoped>
.layout {
    max-width: 780px;
    margin: 0 auto;
    padding: 1.5rem 1rem 4rem;
}
.layout__header {
    display: flex;
    align-items: baseline;
    gap: 0.75rem;
    padding-bottom: 1rem;
    margin-bottom: 1.5rem;
    border-bottom: 1px solid var(--border);
}
.layout__title {
    font-size: 1.25rem;
    font-weight: 600;
    color: var(--text);
    text-decoration: none;
}
.layout__hint {
    font-size: 0.8rem;
    color: var(--text-muted);
}
</style>
