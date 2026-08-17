import { ApiPathEnum } from "@/modules/shared/domain/enums/ApiPathEnum";
import { AbstractApiRepository } from "@/modules/shared/infrastructure/repositories/AbstractApiRepository";

type ListRow = {
    id: number;
    name: string;
    color: string | null;
    position: number;
    open_tasks_count: number;
};

type SearchListsResponse = { items: ListRow[]; total: number };

/**
 * Lectura de listas contra la API.
 *
 * El nombre lleva el origen de los datos igual que en el backend, pero aqui el
 * origen es `Api` en vez de `Sqlite`. Es la misma regla y la misma utilidad: al
 * leer `ListsReaderApiRepository` sabes que esa llamada sale por la red.
 *
 * Sin try/catch: los errores los traduce `AbstractApiRepository` y los captura
 * el store.
 */
export class ListsReaderApiRepository extends AbstractApiRepository {
    public static getInstance(): ListsReaderApiRepository {
        return new ListsReaderApiRepository();
    }

    public async getAll(nameContains: string): Promise<SearchListsResponse> {
        return this.getJson<SearchListsResponse>(ApiPathEnum.LISTS, { name_contains: nameContains });
    }

    public async getById(listId: number): Promise<ListRow> {
        return this.getJson<ListRow>(`${ApiPathEnum.LISTS}/${listId}`);
    }
}

export type { ListRow, SearchListsResponse };
