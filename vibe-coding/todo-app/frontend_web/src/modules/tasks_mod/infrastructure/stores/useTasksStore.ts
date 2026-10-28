import { defineStore } from "pinia";

import { CreateTaskDto } from "@/modules/tasks_mod/application/create_task/CreateTaskDto";
import { CreateTaskService } from "@/modules/tasks_mod/application/create_task/CreateTaskService";
import { DeleteTaskDto } from "@/modules/tasks_mod/application/delete_task/DeleteTaskDto";
import { DeleteTaskService } from "@/modules/tasks_mod/application/delete_task/DeleteTaskService";
import { SearchTasksDto } from "@/modules/tasks_mod/application/search_tasks/SearchTasksDto";
import { SearchTasksService } from "@/modules/tasks_mod/application/search_tasks/SearchTasksService";
import { SetTaskDoneDto } from "@/modules/tasks_mod/application/set_task_done/SetTaskDoneDto";
import { SetTaskDoneService } from "@/modules/tasks_mod/application/set_task_done/SetTaskDoneService";
import type { TaskEntity } from "@/modules/tasks_mod/domain/entities/TaskEntity";
import { HttpException } from "@/modules/shared/domain/exceptions/HttpException";

/**
 * Store de tareas. Misma forma que `useListsStore`.
 *
 * Fijate en lo que NO hace: no importa `useListsStore`. Si al terminar una tarea
 * hay que refrescar el contador de la lista, eso lo coordina la VISTA llamando a
 * los dos stores, no un store llamando al otro.
 *
 * Es la misma regla que en el backend, donde un modulo no entra en la capa de
 * aplicacion de otro. Stores que se llaman entre si acaban en dependencias
 * circulares y en refrescos en cascada que nadie sabe de donde salen.
 */
export const useTasksStore = defineStore("tasks", {
    state: () => ({
        tasks: [] as TaskEntity[],
        isLoading: false,
        error: "",
    }),

    getters: {
        openCount: (state): number => state.tasks.filter((task) => !task.isDone).length,
    },

    actions: {
        async searchTasks(idList: number): Promise<void> {
            this.isLoading = true;
            this.error = "";
            try {
                const result = await SearchTasksService.getInstance().invoke(
                    SearchTasksDto.fromPrimitives({ idList }),
                );
                this.tasks = result.items;
            } catch (exception: unknown) {
                this.error = HttpException.getMessage(exception);
            } finally {
                this.isLoading = false;
            }
        },

        async createTask(
            idList: number,
            title: string,
            description: string | null,
            dueDate: string | null,
        ): Promise<boolean> {
            this.error = "";
            try {
                await CreateTaskService.getInstance().invoke(
                    CreateTaskDto.fromPrimitives({ idList, title, description, dueDate }),
                );
                await this.searchTasks(idList);
                return true;
            } catch (exception: unknown) {
                this.error = HttpException.getMessage(exception);
                return false;
            }
        },

        async setTaskDone(taskId: number, isDone: boolean, idList: number): Promise<boolean> {
            this.error = "";
            try {
                await SetTaskDoneService.getInstance().invoke(
                    SetTaskDoneDto.fromPrimitives({ taskId, isDone }),
                );
                await this.searchTasks(idList);
                return true;
            } catch (exception: unknown) {
                this.error = HttpException.getMessage(exception);
                return false;
            }
        },

        async deleteTask(taskId: number, idList: number): Promise<boolean> {
            this.error = "";
            try {
                await DeleteTaskService.getInstance().invoke(DeleteTaskDto.fromPrimitives({ taskId }));
                await this.searchTasks(idList);
                return true;
            } catch (exception: unknown) {
                this.error = HttpException.getMessage(exception);
                return false;
            }
        },
    },
});
