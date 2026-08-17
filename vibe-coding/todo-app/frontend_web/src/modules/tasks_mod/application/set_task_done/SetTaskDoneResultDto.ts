/** Salida del caso de uso SetTaskDone. */
export class SetTaskDoneResultDto {
    private constructor(
        public readonly taskId: number,
        public readonly isDone: boolean,
    ) {}

    public static fromPrimitives(response: { id: number; is_done: boolean }): SetTaskDoneResultDto {
        return new SetTaskDoneResultDto(response.id, response.is_done);
    }
}
