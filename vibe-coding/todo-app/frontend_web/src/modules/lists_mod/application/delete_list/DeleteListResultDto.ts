/** Salida del caso de uso DeleteList. */
export class DeleteListResultDto {
    private constructor(
        public readonly listId: number,
        public readonly isDeleted: boolean,
    ) {}

    public static fromPrimitives(response: { id: number; is_deleted: boolean }): DeleteListResultDto {
        return new DeleteListResultDto(response.id, response.is_deleted);
    }
}
