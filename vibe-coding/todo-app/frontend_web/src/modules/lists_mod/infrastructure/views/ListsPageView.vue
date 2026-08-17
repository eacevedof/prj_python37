<script setup lang="ts">
import { onMounted, ref } from "vue";

import { useListsStore } from "@/modules/lists_mod/infrastructure/stores/useListsStore";
import { RouteNameEnum } from "@/modules/shared/domain/enums/RouteNameEnum";
import AppEmptyState from "@/modules/shared/infrastructure/views/AppEmptyState.vue";
import AppErrorBanner from "@/modules/shared/infrastructure/views/AppErrorBanner.vue";
import AppLayout from "@/modules/shared/infrastructure/views/AppLayout.vue";

/**
 * Pantalla de listas.
 *
 * Lo que hace esta vista y, sobre todo, lo que NO hace:
 *   - llama a acciones del store
 *   - lee `store.lists`, `store.isLoading` y `store.error`
 *   - NO tiene try/catch: los errores ya vienen convertidos en `store.error`
 *   - NO llama a un service ni a un repositorio directamente
 */
const listsStore = useListsStore();

const newName = ref("");
const newColor = ref("#0f6b62");

onMounted(() => {
    void listsStore.searchLists();
});

async function onCreate(): Promise<void> {
    if (!newName.value.trim()) {
        return;
    }
    const isCreated = await listsStore.createList(newName.value, newColor.value);
    if (isCreated) {
        newName.value = "";
    }
}
</script>

<template>
    <AppLayout>
        <h1>Listas</h1>

        <AppErrorBanner :message="listsStore.error" />

        <form class="new" @submit.prevent="onCreate">
            <input
                v-model="newName"
                type="text"
                placeholder="Nombre de la lista"
                maxlength="80"
                aria-label="Nombre de la lista"
            />
            <input v-model="newColor" type="color" aria-label="Color de la lista" />
            <button type="submit" :disabled="!newName.trim()">Añadir</button>
        </form>

        <AppEmptyState v-if="listsStore.isLoading" message="Cargando…" />

        <template v-else-if="listsStore.lists.length > 0">
            <ul class="rows">
                <li v-for="list in listsStore.lists" :key="list.id" class="row">
                    <span class="row__mark" :style="{ background: list.color ?? 'var(--border-strong)' }" />

                    <RouterLink
                        class="row__name"
                        :to="{ name: RouteNameEnum.LIST_TASKS, params: { id: list.id } }"
                    >
                        {{ list.name }}
                    </RouterLink>

                    <!-- El contador viene del modulo de tareas, por el puerto
                         TasksCounter. En monoespaciada para que las cifras se
                         alineen en columna y se comparen de un vistazo. -->
                    <span
                        class="row__count"
                        :class="{ 'row__count--zero': list.openTasksCount === 0 }"
                        :title="`${list.openTasksCount} sin terminar`"
                    >
                        {{ list.openTasksCount }}
                    </span>

                    <button
                        type="button"
                        class="is-quiet"
                        :aria-label="`Borrar la lista ${list.name}`"
                        @click="listsStore.deleteList(list.id)"
                    >
                        &times;
                    </button>
                </li>
            </ul>

            <p class="summary">
                {{ listsStore.lists.length }}
                {{ listsStore.lists.length === 1 ? "lista" : "listas" }}
            </p>
        </template>

        <AppEmptyState v-else message="Todavía no hay listas. Crea la primera arriba." />
    </AppLayout>
</template>

<style scoped>
.new {
    display: flex;
    gap: var(--space-2);
    margin-block-end: var(--space-5);
}

.new input[type="text"] {
    flex: 1;
    min-inline-size: 0;
}

/* Filas separadas por un filete, no tarjetas: menos ruido visual y el ojo baja
   por la lista sin saltar de caja en caja. */
.rows {
    list-style: none;
    margin: 0;
    padding: 0;
    border-block-start: 1px solid var(--border);
}

.row {
    display: flex;
    align-items: center;
    gap: var(--space-3);
    padding-block: var(--space-3);
    padding-inline: var(--space-2);
    border-block-end: 1px solid var(--border);
    transition: background-color 0.12s;
}

.row:hover {
    background: var(--surface-hover);
}

.row__mark {
    flex: none;
    inline-size: 3px;
    block-size: 1.35rem;
    border-radius: var(--radius-pill);
}

.row__name {
    flex: 1;
    min-inline-size: 0;
    color: var(--text);
    text-decoration: none;
    overflow-wrap: anywhere;
}

.row:hover .row__name {
    color: var(--accent);
}

.row__count {
    flex: none;
    min-inline-size: 1.75rem;
    padding-block: 1px;
    padding-inline: var(--space-2);
    border-radius: var(--radius-pill);
    background: var(--accent-soft);
    color: var(--accent);
    font-family: var(--font-mono);
    font-size: var(--text-xs);
    font-variant-numeric: tabular-nums;
    text-align: center;
}

/* Cero pendientes se apaga: solo destaca lo que pide atencion. */
.row__count--zero {
    background: var(--surface-raised);
    color: var(--text-subtle);
}

.summary {
    margin-block: var(--space-4) 0;
    color: var(--text-subtle);
    font-size: var(--text-xs);
}
</style>
