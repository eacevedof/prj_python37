import { CreateTaskDto } from "@/modules/tasks_mod/application/create_task/CreateTaskDto";
import { CreateTaskResultDto } from "@/modules/tasks_mod/application/create_task/CreateTaskResultDto";
import { TasksWriterApiRepository } from "@/modules/tasks_mod/infrastructure/repositories/TasksWriterApiRepository";

/** Caso de uso: crear una tarea. */
export class CreateTaskService {
    private readonly _tasksWriterApiRepository: TasksWriterApiRepository;

    private constructor() {
        this._tasksWriterApiRepository = TasksWriterApiRepository.getInstance();
    }

    public static getInstance(): CreateTaskService {
        return new CreateTaskService();
    }

    public async invoke(createTaskDto: CreateTaskDto): Promise<CreateTaskResultDto> {
        const row = await this._tasksWriterApiRepository.create(
            createTaskDto.idList,
            createTaskDto.title,
            createTaskDto.description,
            createTaskDto.dueDate,
        );
        return CreateTaskResultDto.fromPrimitives(row);
    }
}
