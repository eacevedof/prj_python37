<script setup lang="ts">
/**
 * Muestra un error, o nada si no lo hay.
 *
 * El mensaje que llega aqui lo escribio el caso de uso del backend, asi que
 * dice algo util ("la lista 3 tiene 2 tareas sin terminar") y no un codigo.
 *
 * `role="alert"` hace que un lector de pantalla lo anuncie al aparecer. Sin eso,
 * quien no ve la pantalla pulsa un boton y no se entera de que ha fallado.
 */
defineProps<{ message: string }>();
</script>

<template>
    <p v-if="message" class="error" role="alert">{{ message }}</p>
</template>

<style scoped>
.error {
    display: flex;
    align-items: flex-start;
    gap: var(--space-2);
    margin-block: 0 var(--space-4);
    padding: var(--space-3) var(--space-4);
    border-radius: var(--radius-md);
    /* Filete lateral en vez de borde completo: senala sin encajonar. */
    border-inline-start: 3px solid var(--danger);
    background: var(--danger-soft);
    color: var(--danger);
    font-size: var(--text-sm);
    text-wrap: pretty;
}
</style>
