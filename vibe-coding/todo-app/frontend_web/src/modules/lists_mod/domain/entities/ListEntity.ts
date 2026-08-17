/**
 * Una lista, tal como la usa el front.
 *
 * Es un `type` y no una clase: en el front una entidad es la FORMA de un dato,
 * y no tiene comportamiento propio. Todas las reglas de negocio viven en el
 * backend, que es el unico sitio donde se pueden imponer de verdad; el front
 * puede validar para dar mejor experiencia, pero nunca es la autoridad.
 */
export type ListEntity = {
    readonly id: number;
    readonly name: string;
    readonly color: string | null;
    readonly position: number;
    readonly openTasksCount: number;
};
