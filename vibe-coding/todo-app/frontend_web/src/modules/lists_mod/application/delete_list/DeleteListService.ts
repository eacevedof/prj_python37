import { DeleteListDto } from "@/modules/lists_mod/application/delete_list/DeleteListDto";
import { DeleteListResultDto } from "@/modules/lists_mod/application/delete_list/DeleteListResultDto";
import { ListsWriterApiRepository } from "@/modules/lists_mod/infrastructure/repositories/ListsWriterApiRepository";

/** Caso de uso: borrar una lista. */
export class DeleteListService {
    private readonly _listsWriterApiRepository: ListsWriterApiRepository;

    private constructor() {
        this._listsWriterApiRepository = ListsWriterApiRepository.getInstance();
    }

    public static getInstance(): DeleteListService {
        return new DeleteListService();
    }

    public async invoke(deleteListDto: DeleteListDto): Promise<DeleteListResultDto> {
        const response = await this._listsWriterApiRepository.softDelete(deleteListDto.listId);
        return DeleteListResultDto.fromPrimitives(response);
    }
}
