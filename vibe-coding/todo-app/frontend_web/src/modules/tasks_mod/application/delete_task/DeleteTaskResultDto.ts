/** Salida del caso de uso DeleteTask. */
export class DeleteTaskResultDto {
    private constructor(
        public readonly taskId: number,
        public readonly isDeleted: boolean,
    ) {}

    public static fromPrimitives(response: { id: number; is_deleted: boolean }): DeleteTaskResultDto {
        return new DeleteTaskResultDto(response.id, response.is_deleted);
    }
}
