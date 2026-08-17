<script setup lang="ts">
/**
 * Muestra un mensaje de error, o nada si no lo hay.
 *
 * Vive en `shared/infrastructure/views/` y NO en `components/`, y la distincion
 * importa: en este proyecto `components/` significa lo mismo que en el backend
 * (Logger, utilidades sin interfaz). Los trozos de pantalla reutilizables son
 * VISTAS. Si no se fija por escrito, en dos semanas `components` significa dos
 * cosas distintas en los dos repos.
 */
defineProps<{ message: string }>();
</script>

<template>
    <p v-if="message" class="error-banner" role="alert">{{ message }}</p>
</template>

<style scoped>
.error-banner {
    margin: 0 0 1rem;
    padding: 0.75rem 1rem;
    border-radius: 6px;
    background: #fdecea;
    color: #a4262c;
    border: 1px solid #f3c2c0;
}
</style>
