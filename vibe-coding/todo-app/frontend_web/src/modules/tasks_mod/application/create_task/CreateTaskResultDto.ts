import type { TaskEntity } from "@/modules/tasks_mod/domain/entities/TaskEntity";
import type { TaskRow } from "@/modules/tasks_mod/infrastructure/repositories/TasksReaderApiRepository";

/** Salida del caso de uso CreateTask. */
export class CreateTaskResultDto {
    private constructor(public readonly item: TaskEntity) {}

    public static fromPrimitives(row: TaskRow): CreateTaskResultDto {
        return new CreateTaskResultDto({
            id: row.id,
            idList: row.id_list,
            title: row.title,
            description: row.description,
            isDone: row.is_done,
            dueDate: row.due_date,
            position: row.position,
        });
    }
}
