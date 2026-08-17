import { SearchTasksDto } from "@/modules/tasks_mod/application/search_tasks/SearchTasksDto";
import { SearchTasksResultDto } from "@/modules/tasks_mod/application/search_tasks/SearchTasksResultDto";
import { TasksReaderApiRepository } from "@/modules/tasks_mod/infrastructure/repositories/TasksReaderApiRepository";

/** Caso de uso: listar las tareas de una lista. */
export class SearchTasksService {
    private readonly _tasksReaderApiRepository: TasksReaderApiRepository;

    private constructor() {
        this._tasksReaderApiRepository = TasksReaderApiRepository.getInstance();
    }

    public static getInstance(): SearchTasksService {
        return new SearchTasksService();
    }

    public async invoke(searchTasksDto: SearchTasksDto): Promise<SearchTasksResultDto> {
        const response = await this._tasksReaderApiRepository.getByList(searchTasksDto.idList);
        return SearchTasksResultDto.fromPrimitives(response);
    }
}
