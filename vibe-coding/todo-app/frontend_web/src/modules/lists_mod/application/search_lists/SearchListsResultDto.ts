import type { ListEntity } from "@/modules/lists_mod/domain/entities/ListEntity";
import type { SearchListsResponse } from "@/modules/lists_mod/infrastructure/repositories/ListsReaderApiRepository";

/**
 * Salida del caso de uso SearchLists.
 *
 * Aqui es donde se traduce el `snake_case` de la API al `camelCase` de
 * TypeScript. Se hace en UN sitio, a proposito: asi las plantillas `.vue` usan
 * los nombres normales de JavaScript y, si la API renombra un campo, solo hay
 * que tocar esta clase.
 */
export class SearchListsResultDto {
    private constructor(
        public readonly items: ListEntity[],
        public readonly total: number,
    ) {}

    public static fromPrimitives(response: SearchListsResponse): SearchListsResultDto {
        const items: ListEntity[] = response.items.map((row) => ({
            id: row.id,
            name: row.name,
            color: row.color,
            position: row.position,
            openTasksCount: row.open_tasks_count,
        }));
        return new SearchListsResultDto(items, response.total);
    }
}
