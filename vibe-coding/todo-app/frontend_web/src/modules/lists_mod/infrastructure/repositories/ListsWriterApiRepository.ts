import { ApiPathEnum } from "@/modules/shared/domain/enums/ApiPathEnum";
import { AbstractApiRepository } from "@/modules/shared/infrastructure/repositories/AbstractApiRepository";
import type { ListRow } from "@/modules/lists_mod/infrastructure/repositories/ListsReaderApiRepository";

/** Escritura de listas contra la API. */
export class ListsWriterApiRepository extends AbstractApiRepository {
    public static getInstance(): ListsWriterApiRepository {
        return new ListsWriterApiRepository();
    }

    public async create(name: string, color: string | null): Promise<ListRow> {
        return this.postJson<ListRow>(ApiPathEnum.LISTS, { name, color });
    }

    public async update(listId: number, name: string, color: string | null, position: number): Promise<ListRow> {
        return this.putJson<ListRow>(`${ApiPathEnum.LISTS}/${listId}`, { name, color, position });
    }

    public async softDelete(listId: number): Promise<{ id: number; is_deleted: boolean }> {
        return this.deleteJson<{ id: number; is_deleted: boolean }>(`${ApiPathEnum.LISTS}/${listId}`);
    }
}
