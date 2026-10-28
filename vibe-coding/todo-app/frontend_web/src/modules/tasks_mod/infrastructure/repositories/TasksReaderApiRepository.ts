import { ApiPathEnum } from "@/modules/shared/domain/enums/ApiPathEnum";
import { AbstractApiRepository } from "@/modules/shared/infrastructure/repositories/AbstractApiRepository";

type TaskRow = {
    id: number;
    id_list: number;
    title: string;
    description: string | null;
    is_done: boolean;
    due_date: string | null;
    position: number;
};

type SearchTasksResponse = { items: TaskRow[]; total: number };

/** Lectura de tareas contra la API. */
export class TasksReaderApiRepository extends AbstractApiRepository {
    public static getInstance(): TasksReaderApiRepository {
        return new TasksReaderApiRepository();
    }

    public async getByList(idList: number): Promise<SearchTasksResponse> {
        return this.getJson<SearchTasksResponse>(`${ApiPathEnum.LISTS}/${idList}/tasks`);
    }
}

export type { SearchTasksResponse, TaskRow };
