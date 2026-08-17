import type { ListEntity } from "@/modules/lists_mod/domain/entities/ListEntity";
import type { ListRow } from "@/modules/lists_mod/infrastructure/repositories/ListsReaderApiRepository";

/** Salida del caso de uso CreateList. */
export class CreateListResultDto {
    private constructor(public readonly item: ListEntity) {}

    public static fromPrimitives(row: ListRow): CreateListResultDto {
        return new CreateListResultDto({
            id: row.id,
            name: row.name,
            color: row.color,
            position: row.position,
            // Una lista recien creada no tiene tareas. La API no devuelve el
            // contador al crear, asi que se pone 0 aqui en vez de pedirla otra vez.
            openTasksCount: row.open_tasks_count ?? 0,
        });
    }
}
