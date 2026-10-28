/** Entrada del caso de uso DeleteTask. */
export class DeleteTaskDto {
    private constructor(public readonly taskId: number) {}

    public static fromPrimitives(primitives: Record<string, unknown>): DeleteTaskDto {
        return new DeleteTaskDto(Number(primitives["taskId"] ?? 0));
    }
}
