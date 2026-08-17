/** Entrada del caso de uso CreateList. */
export class CreateListDto {
    private constructor(
        public readonly name: string,
        public readonly color: string | null,
    ) {}

    public static fromPrimitives(primitives: Record<string, unknown>): CreateListDto {
        const color = String(primitives["color"] ?? "").trim();
        return new CreateListDto(String(primitives["name"] ?? "").trim(), color || null);
    }
}
