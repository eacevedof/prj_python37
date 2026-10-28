import { SetTaskDoneDto } from "@/modules/tasks_mod/application/set_task_done/SetTaskDoneDto";
import { SetTaskDoneResultDto } from "@/modules/tasks_mod/application/set_task_done/SetTaskDoneResultDto";
import { TasksWriterApiRepository } from "@/modules/tasks_mod/infrastructure/repositories/TasksWriterApiRepository";

/** Caso de uso: marcar una tarea como hecha o pendiente. */
export class SetTaskDoneService {
    private readonly _tasksWriterApiRepository: TasksWriterApiRepository;

    private constructor() {
        this._tasksWriterApiRepository = TasksWriterApiRepository.getInstance();
    }

    public static getInstance(): SetTaskDoneService {
        return new SetTaskDoneService();
    }

    public async invoke(setTaskDoneDto: SetTaskDoneDto): Promise<SetTaskDoneResultDto> {
        const response = await this._tasksWriterApiRepository.setDone(
            setTaskDoneDto.taskId,
            setTaskDoneDto.isDone,
        );
        return SetTaskDoneResultDto.fromPrimitives(response);
    }
}
