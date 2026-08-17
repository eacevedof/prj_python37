/** Entrada del caso de uso CreateTask. */
export class CreateTaskDto {
    private constructor(
        public readonly idList: number,
        public readonly title: string,
        public readonly description: string | null,
        public readonly dueDate: string | null,
    ) {}

    public static fromPrimitives(primitives: Record<string, unknown>): CreateTaskDto {
        const description = String(primitives["description"] ?? "").trim();
        const dueDate = String(primitives["dueDate"] ?? "").trim();
        return new CreateTaskDto(
            Number(primitives["idList"] ?? 0),
            String(primitives["title"] ?? "").trim(),
            description || null,
            dueDate || null,
        );
    }
}
