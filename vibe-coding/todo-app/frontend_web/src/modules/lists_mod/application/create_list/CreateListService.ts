import { CreateListDto } from "@/modules/lists_mod/application/create_list/CreateListDto";
import { CreateListResultDto } from "@/modules/lists_mod/application/create_list/CreateListResultDto";
import { ListsWriterApiRepository } from "@/modules/lists_mod/infrastructure/repositories/ListsWriterApiRepository";

/** Caso de uso: crear una lista. */
export class CreateListService {
    private readonly _listsWriterApiRepository: ListsWriterApiRepository;

    private constructor() {
        this._listsWriterApiRepository = ListsWriterApiRepository.getInstance();
    }

    public static getInstance(): CreateListService {
        return new CreateListService();
    }

    public async invoke(createListDto: CreateListDto): Promise<CreateListResultDto> {
        const row = await this._listsWriterApiRepository.create(createListDto.name, createListDto.color);
        return CreateListResultDto.fromPrimitives(row);
    }
}
