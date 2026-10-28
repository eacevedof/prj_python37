/**
 * Entrada del caso de uso SearchLists. Gemelo de `search_lists_dto.py`.
 *
 * Misma forma que en Python: campos de solo lectura, constructor privado y una
 * factoria `fromPrimitives` que convierte lo que llega de la interfaz.
 */
export class SearchListsDto {
    private constructor(public readonly nameContains: string) {}

    public static fromPrimitives(primitives: Record<string, unknown>): SearchListsDto {
        return new SearchListsDto(String(primitives["nameContains"] ?? "").trim());
    }
}
