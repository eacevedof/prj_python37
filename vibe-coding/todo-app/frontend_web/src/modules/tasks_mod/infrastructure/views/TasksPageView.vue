<script setup lang="ts">
import { computed, onMounted, ref, watch } from "vue";
import { useRoute } from "vue-router";

import { useTasksStore } from "@/modules/tasks_mod/infrastructure/stores/useTasksStore";
import AppEmptyState from "@/modules/shared/infrastructure/views/AppEmptyState.vue";
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

const doneCount = computed<number>(() => tasksStore.tasks.length - tasksStore.openCount);

/**
 * Si una fecha ya paso.
 *
 * Esto es PRESENTACION, no negocio: solo decide de que color se pinta la fecha.
 * Una regla de negocio de verdad (por ejemplo "no dejar cerrar una lista con
 * tareas vencidas") iria en el caso de uso del backend, que es el unico sitio
 * donde se puede imponer.
 */
function isOverdue(dueDate: string | null, isDone: boolean): boolean {
    if (dueDate === null || isDone) {
        return false;
    }
    return dueDate < new Date().toISOString().slice(0, 10);
}

onMounted(() => {
    void tasksStore.searchTasks(getListId());
});

// Al navegar de una lista a otra sin salir de esta pantalla, Vue reutiliza el
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
        <RouterLink to="/" class="back">Listas</RouterLink>
        <h1>Tareas</h1>

        <AppErrorBanner :message="tasksStore.error" />

        <form class="new" @submit.prevent="onCreate">
            <input
                v-model="newTitle"
                type="text"
                placeholder="Qué hay que hacer"
                maxlength="200"
                aria-label="Título de la tarea"
            />
            <input v-model="newDueDate" type="date" aria-label="Fecha límite" />
            <button type="submit" :disabled="!newTitle.trim()">Añadir</button>
        </form>

        <AppEmptyState v-if="tasksStore.isLoading" message="Cargando…" />

        <template v-else-if="tasksStore.tasks.length > 0">
            <ul class="rows">
                <li
                    v-for="task in tasksStore.tasks"
                    :key="task.id"
                    class="row"
                    :class="{ 'row--done': task.isDone }"
                >
                    <input
                        type="checkbox"
                        :checked="task.isDone"
                        :aria-label="`Marcar «${task.title}» como hecha`"
                        @change="tasksStore.setTaskDone(task.id, !task.isDone, getListId())"
                    />

                    <span class="row__title">{{ task.title }}</span>

                    <!-- La fecha va en monoespaciada para que las columnas
                         cuadren, y en rojo si ya paso: el estado se ve, no hay
                         que leerlo. -->
                    <time
                        v-if="task.dueDate"
                        class="row__due"
                        :class="{ 'row__due--overdue': isOverdue(task.dueDate, task.isDone) }"
                        :datetime="task.dueDate"
                    >
                        {{ task.dueDate }}
                    </time>

                    <button
                        type="button"
                        class="is-quiet"
                        :aria-label="`Borrar la tarea ${task.title}`"
                        @click="tasksStore.deleteTask(task.id, getListId())"
                    >
                        &times;
                    </button>
                </li>
            </ul>

            <p class="summary">
                <span class="summary__bar" aria-hidden="true">
                    <span
                        class="summary__fill"
                        :style="{ inlineSize: `${(doneCount / tasksStore.tasks.length) * 100}%` }"
                    />
                </span>
                {{ doneCount }} de {{ tasksStore.tasks.length }} hechas
            </p>
        </template>

        <AppEmptyState v-else message="Esta lista no tiene tareas todavía." />
    </AppLayout>
</template>

<style scoped>
.back {
    display: inline-block;
    margin-block-end: var(--space-2);
    color: var(--text-subtle);
    font-size: var(--text-sm);
    text-decoration: none;
}

.back::before {
    content: "← ";
}

.back:hover {
    color: var(--accent);
}

.new {
    display: flex;
    gap: var(--space-2);
    margin-block-end: var(--space-5);
}

.new input[type="text"] {
    flex: 1;
    min-inline-size: 0;
}

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

.row__title {
    flex: 1;
    min-inline-size: 0;
    overflow-wrap: anywhere;
    transition: color 0.15s;
}

/* Una tarea hecha se APAGA en vez de ponerse verde: lo que tiene que destacar
   es lo que queda por hacer, no lo que ya esta. */
.row--done .row__title {
    color: var(--text-subtle);
    text-decoration: line-through;
    text-decoration-thickness: 1px;
}

.row__due {
    flex: none;
    color: var(--text-muted);
    font-family: var(--font-mono);
    font-size: var(--text-xs);
    font-variant-numeric: tabular-nums;
}

.row__due--overdue {
    color: var(--danger);
    font-weight: 500;
}

.row--done .row__due {
    color: var(--text-subtle);
}

.summary {
    display: flex;
    align-items: center;
    gap: var(--space-3);
    margin-block: var(--space-4) 0;
    color: var(--text-subtle);
    font-size: var(--text-xs);
    font-variant-numeric: tabular-nums;
}

/* Barra de avance: el mismo dato que el texto, pero legible de un vistazo. */
.summary__bar {
    flex: 1;
    max-inline-size: 8rem;
    block-size: 3px;
    border-radius: var(--radius-pill);
    background: var(--surface-raised);
    overflow: hidden;
}

.summary__fill {
    display: block;
    block-size: 100%;
    border-radius: var(--radius-pill);
    background: var(--accent);
    transition: inline-size 0.25s ease-out;
}
</style>
