/** Entrada del caso de uso DeleteList. */
export class DeleteListDto {
    private constructor(public readonly listId: number) {}

    public static fromPrimitives(primitives: Record<string, unknown>): DeleteListDto {
        return new DeleteListDto(Number(primitives["listId"] ?? 0));
    }
}
