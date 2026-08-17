<script setup lang="ts">
import { onMounted, ref, watch } from "vue";
import { useRoute } from "vue-router";

import { useTasksStore } from "@/modules/tasks_mod/infrastructure/stores/useTasksStore";
import AppErrorBanner from "@/modules/shared/infrastructure/views/AppErrorBanner.vue";
import AppLayout from "@/modules/shared/infrastructure/views/AppLayout.vue";

/** Pantalla de tareas de una lista. */
const route = useRoute();
const tasksStore = useTasksStore();

const newTitle = ref("");
const newDueDate = ref("");

function getListId(): number {
    return Number(route.params["id"] ?? 0);
}

onMounted(() => {
    void tasksStore.searchTasks(getListId());
});

// Si se navega de una lista a otra sin salir de esta pantalla, Vue reutiliza el
// componente y `onMounted` no se vuelve a ejecutar. Sin esto, se verian las
// tareas de la lista anterior.
watch(
    () => route.params["id"],
    () => {
        void tasksStore.searchTasks(getListId());
    },
);

async function onCreate(): Promise<void> {
    if (!newTitle.value.trim()) {
        return;
    }
    const isCreated = await tasksStore.createTask(
        getListId(),
        newTitle.value,
        null,
        newDueDate.value || null,
    );
    if (isCreated) {
        newTitle.value = "";
        newDueDate.value = "";
    }
}
</script>

<template>
    <AppLayout>
        <RouterLink to="/" class="back">&larr; Listas</RouterLink>
        <h1>Tareas</h1>

        <AppErrorBanner :message="tasksStore.error" />

        <form class="new-task" @submit.prevent="onCreate">
            <input v-model="newTitle" placeholder="Que hay que hacer" maxlength="200" />
            <input v-model="newDueDate" type="date" title="Fecha limite" />
            <button type="submit">Anadir</button>
        </form>

        <p v-if="tasksStore.isLoading">Cargando...</p>

        <ul v-else class="tasks">
            <li v-for="task in tasksStore.tasks" :key="task.id" class="tasks__item">
                <input
                    type="checkbox"
                    :checked="task.isDone"
                    @change="tasksStore.setTaskDone(task.id, !task.isDone, getListId())"
                />
                <span class="tasks__title" :class="{ 'tasks__title--done': task.isDone }">
                    {{ task.title }}
                </span>
                <span v-if="task.dueDate" class="tasks__due">{{ task.dueDate }}</span>
                <button class="tasks__delete" title="Borrar" @click="tasksStore.deleteTask(task.id, getListId())">
                    &times;
                </button>
            </li>
        </ul>

        <p v-if="!tasksStore.isLoading && tasksStore.tasks.length === 0" class="empty">
            Esta lista no tiene tareas.
        </p>

        <p v-else-if="!tasksStore.isLoading" class="summary">
            {{ tasksStore.openCount }} sin terminar de {{ tasksStore.tasks.length }}
        </p>
    </AppLayout>
</template>

<style scoped>
.back {
    display: inline-block;
    margin-bottom: 0.5rem;
    color: var(--text-muted);
    text-decoration: none;
    font-size: 0.9rem;
}
.new-task {
    display: flex;
    gap: 0.5rem;
    margin-bottom: 1.5rem;
}
.new-task input:not([type="date"]) {
    flex: 1;
}
.tasks {
    list-style: none;
    margin: 0;
    padding: 0;
}
.tasks__item {
    display: flex;
    align-items: center;
    gap: 0.75rem;
    padding: 0.7rem 0.25rem;
    border-bottom: 1px solid var(--border);
}
.tasks__title {
    flex: 1;
}
.tasks__title--done {
    text-decoration: line-through;
    color: var(--text-muted);
}
.tasks__due {
    font-size: 0.8rem;
    color: var(--text-muted);
}
.tasks__delete {
    background: none;
    border: none;
    color: var(--text-muted);
    font-size: 1.2rem;
    cursor: pointer;
    line-height: 1;
}
.tasks__delete:hover {
    color: #a4262c;
}
.empty,
.summary {
    color: var(--text-muted);
    font-size: 0.9rem;
}
</style>
