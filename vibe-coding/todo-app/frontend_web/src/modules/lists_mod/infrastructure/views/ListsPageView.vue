<script setup lang="ts">
import { onMounted, ref } from "vue";

import { useListsStore } from "@/modules/lists_mod/infrastructure/stores/useListsStore";
import { RouteNameEnum } from "@/modules/shared/domain/enums/RouteNameEnum";
import AppErrorBanner from "@/modules/shared/infrastructure/views/AppErrorBanner.vue";
import AppLayout from "@/modules/shared/infrastructure/views/AppLayout.vue";

/**
 * Pantalla de listas.
 *
 * Fijate en lo que hace esta vista y en lo que NO hace:
 *   - llama a acciones del store
 *   - lee `store.lists`, `store.isLoading` y `store.error`
 *   - NO tiene try/catch: los errores ya vienen convertidos en `store.error`
 *   - NO llama a un service ni a un repositorio directamente
 */
const listsStore = useListsStore();

const newName = ref("");
const newColor = ref("#4F8EF7");

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

        <form class="new-list" @submit.prevent="onCreate">
            <input v-model="newName" placeholder="Nombre de la lista" maxlength="80" />
            <input v-model="newColor" type="color" title="Color" />
            <button type="submit">Anadir</button>
        </form>

        <p v-if="listsStore.isLoading">Cargando...</p>

        <ul v-else class="lists">
            <li v-for="list in listsStore.lists" :key="list.id" class="lists__item">
                <span class="lists__dot" :style="{ background: list.color ?? '#ccc' }" />
                <RouterLink
                    class="lists__name"
                    :to="{ name: RouteNameEnum.LIST_TASKS, params: { id: list.id } }"
                >
                    {{ list.name }}
                </RouterLink>
                <span class="lists__count" :title="`${list.openTasksCount} tareas sin terminar`">
                    {{ list.openTasksCount }}
                </span>
                <button class="lists__delete" title="Borrar" @click="listsStore.deleteList(list.id)">
                    &times;
                </button>
            </li>
        </ul>

        <p v-if="!listsStore.isLoading && listsStore.lists.length === 0" class="empty">
            No hay listas todavia.
        </p>
    </AppLayout>
</template>

<style scoped>
.new-list {
    display: flex;
    gap: 0.5rem;
    margin-bottom: 1.5rem;
}
.new-list input[type="text"],
.new-list input:not([type]) {
    flex: 1;
}
.lists {
    list-style: none;
    margin: 0;
    padding: 0;
}
.lists__item {
    display: flex;
    align-items: center;
    gap: 0.75rem;
    padding: 0.7rem 0.25rem;
    border-bottom: 1px solid var(--border);
}
.lists__dot {
    width: 12px;
    height: 12px;
    border-radius: 50%;
    flex: none;
}
.lists__name {
    flex: 1;
    color: var(--text);
    text-decoration: none;
}
.lists__name:hover {
    text-decoration: underline;
}
.lists__count {
    min-width: 1.6rem;
    text-align: center;
    font-size: 0.8rem;
    color: var(--text-muted);
    background: var(--surface);
    border-radius: 10px;
    padding: 0.1rem 0.4rem;
}
.lists__delete {
    background: none;
    border: none;
    color: var(--text-muted);
    font-size: 1.2rem;
    cursor: pointer;
    line-height: 1;
}
.lists__delete:hover {
    color: #a4262c;
}
.empty {
    color: var(--text-muted);
}
</style>
