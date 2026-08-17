/** Una tarea, tal como la usa el front. */
export type TaskEntity = {
    readonly id: number;
    readonly idList: number;
    readonly title: string;
    readonly description: string | null;
    readonly isDone: boolean;
    readonly dueDate: string | null;
    readonly position: number;
};
