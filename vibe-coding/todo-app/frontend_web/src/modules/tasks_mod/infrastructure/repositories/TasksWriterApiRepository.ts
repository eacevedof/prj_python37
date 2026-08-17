import type { TaskRow } from "@/modules/tasks_mod/infrastructure/repositories/TasksReaderApiRepository";
import { ApiPathEnum } from "@/modules/shared/domain/enums/ApiPathEnum";
import { AbstractApiRepository } from "@/modules/shared/infrastructure/repositories/AbstractApiRepository";

/** Escritura de tareas contra la API. */
export class TasksWriterApiRepository extends AbstractApiRepository {
    public static getInstance(): TasksWriterApiRepository {
        return new TasksWriterApiRepository();
    }

    public async create(
        idList: number,
        title: string,
        description: string | null,
        dueDate: string | null,
    ): Promise<TaskRow> {
        return this.postJson<TaskRow>(ApiPathEnum.TASKS, {
            id_list: idList,
            title,
            description,
            due_date: dueDate,
        });
    }

    public async setDone(taskId: number, isDone: boolean): Promise<{ id: number; is_done: boolean }> {
        return this.patchJson<{ id: number; is_done: boolean }>(`${ApiPathEnum.TASKS}/${taskId}/done`, {
            is_done: isDone,
        });
    }

    public async softDelete(taskId: number): Promise<{ id: number; is_deleted: boolean }> {
        return this.deleteJson<{ id: number; is_deleted: boolean }>(`${ApiPathEnum.TASKS}/${taskId}`);
    }
}
