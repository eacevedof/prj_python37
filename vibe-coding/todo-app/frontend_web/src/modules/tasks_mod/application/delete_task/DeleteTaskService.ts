import { DeleteTaskDto } from "@/modules/tasks_mod/application/delete_task/DeleteTaskDto";
import { DeleteTaskResultDto } from "@/modules/tasks_mod/application/delete_task/DeleteTaskResultDto";
import { TasksWriterApiRepository } from "@/modules/tasks_mod/infrastructure/repositories/TasksWriterApiRepository";

/** Caso de uso: borrar una tarea. */
export class DeleteTaskService {
    private readonly _tasksWriterApiRepository: TasksWriterApiRepository;

    private constructor() {
        this._tasksWriterApiRepository = TasksWriterApiRepository.getInstance();
    }

    public static getInstance(): DeleteTaskService {
        return new DeleteTaskService();
    }

    public async invoke(deleteTaskDto: DeleteTaskDto): Promise<DeleteTaskResultDto> {
        const response = await this._tasksWriterApiRepository.softDelete(deleteTaskDto.taskId);
        return DeleteTaskResultDto.fromPrimitives(response);
    }
}
