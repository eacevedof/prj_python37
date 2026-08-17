/**
 * Entrada del caso de uso SetTaskDone.
 *
 * Lleva el estado DESEADO, no "cambia el estado", igual que en el backend: asi
 * pulsar dos veces la casilla deja la tarea como se pidio la ultima vez, sin
 * depender del orden en que lleguen las peticiones.
 */
export class SetTaskDoneDto {
    private constructor(
        public readonly taskId: number,
        public readonly isDone: boolean,
    ) {}

    public static fromPrimitives(primitives: Record<string, unknown>): SetTaskDoneDto {
        return new SetTaskDoneDto(Number(primitives["taskId"] ?? 0), Boolean(primitives["isDone"]));
    }
}
