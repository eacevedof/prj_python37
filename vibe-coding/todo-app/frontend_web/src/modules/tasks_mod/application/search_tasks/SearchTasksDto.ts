/** Entrada del caso de uso SearchTasks. */
export class SearchTasksDto {
    private constructor(public readonly idList: number) {}

    public static fromPrimitives(primitives: Record<string, unknown>): SearchTasksDto {
        return new SearchTasksDto(Number(primitives["idList"] ?? 0));
    }
}
