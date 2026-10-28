import type { RouteRecordRaw } from "vue-router";

import ListsPageView from "@/modules/lists_mod/infrastructure/views/ListsPageView.vue";
import TasksPageView from "@/modules/tasks_mod/infrastructure/views/TasksPageView.vue";
import { RouteNameEnum } from "@/modules/shared/domain/enums/RouteNameEnum";

/**
 * Tabla de rutas del navegador. Gemela de `Routes.BY_PATH` del backend.
 *
 * Mismo principio: TODAS las pantallas declaradas en un fichero, para poder ver
 * de un vistazo por donde se puede navegar. Para anadir una pantalla, se importa
 * la vista arriba y se anade una entrada aqui.
 */
export const Routes: RouteRecordRaw[] = [
    {
        path: "/",
        name: RouteNameEnum.LISTS,
        component: ListsPageView,
    },
    {
        path: "/lists/:id/tasks",
        name: RouteNameEnum.LIST_TASKS,
        component: TasksPageView,
    },
];
