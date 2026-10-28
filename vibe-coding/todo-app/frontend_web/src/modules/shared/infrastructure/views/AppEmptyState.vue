<script setup lang="ts">
/**
 * Lo que se ve cuando no hay nada que mostrar.
 *
 * Existe como componente propio porque una pantalla vacia es un estado de
 * primera, no un descuido. Lo peor que puede pasar al abrir una aplicacion por
 * primera vez es no ver nada y no saber si esta cargando, si ha fallado o si
 * simplemente no hay datos todavia.
 */
defineProps<{ message: string }>();
</script>

<template>
    <p class="empty">{{ message }}</p>
</template>

<style scoped>
.empty {
    margin: 0;
    padding-block: var(--space-8);
    color: var(--text-subtle);
    font-size: var(--font-size-200);
    text-align: center;
}
</style>
