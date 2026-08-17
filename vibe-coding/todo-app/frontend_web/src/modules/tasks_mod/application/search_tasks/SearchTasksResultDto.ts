import type { TaskEntity } from "@/modules/tasks_mod/domain/entities/TaskEntity";
import type { SearchTasksResponse } from "@/modules/tasks_mod/infrastructure/repositories/TasksReaderApiRepository";

/** Salida del caso de uso SearchTasks. Traduce snake_case -> camelCase. */
export class SearchTasksResultDto {
    private constructor(
        public readonly items: TaskEntity[],
        public readonly total: number,
    ) {}

    public static fromPrimitives(response: SearchTasksResponse): SearchTasksResultDto {
        const items: TaskEntity[] = response.items.map((row) => ({
            id: row.id,
            idList: row.id_list,
            title: row.title,
            description: row.description,
            isDone: row.is_done,
            dueDate: row.due_date,
            position: row.position,
        }));
        return new SearchTasksResultDto(items, response.total);
    }
}
