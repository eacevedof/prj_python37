import { SearchListsDto } from "@/modules/lists_mod/application/search_lists/SearchListsDto";
import { SearchListsResultDto } from "@/modules/lists_mod/application/search_lists/SearchListsResultDto";
import { ListsReaderApiRepository } from "@/modules/lists_mod/infrastructure/repositories/ListsReaderApiRepository";

/**
 * Caso de uso: listar las listas. Gemelo de `search_lists_service.py`.
 *
 * Misma forma que en el backend: colaboradores declarados arriba, `getInstance()`
 * como unica forma de construirlo y un solo metodo publico.
 *
 * Es `async` porque debajo hay una llamada de red. Eso es un detalle del
 * transporte, no de la arquitectura: la forma del caso de uso no cambia.
 *
 * Sin try/catch: si la llamada falla, la excepcion sube hasta el store.
 */
export class SearchListsService {
    private readonly _listsReaderApiRepository: ListsReaderApiRepository;

    private constructor() {
        this._listsReaderApiRepository = ListsReaderApiRepository.getInstance();
    }

    public static getInstance(): SearchListsService {
        return new SearchListsService();
    }

    public async invoke(searchListsDto: SearchListsDto): Promise<SearchListsResultDto> {
        const response = await this._listsReaderApiRepository.getAll(searchListsDto.nameContains);
        return SearchListsResultDto.fromPrimitives(response);
    }
}
