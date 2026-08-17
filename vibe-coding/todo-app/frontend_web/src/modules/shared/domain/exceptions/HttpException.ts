import { ResponseCodeEnum } from "@/modules/shared/domain/enums/ResponseCodeEnum";

/**
 * Excepcion de una llamada a la API. Gemela de las `*Exception` del backend.
 *
 * Misma forma: `code` y `message` de solo lectura, y factorias estaticas que
 * LANZAN. La diferencia con Python es que aqui el `code` viene del servidor en
 * vez de decidirlo el dominio.
 *
 * Quien la captura es el store de Pinia, que es al front lo que el controller es
 * al backend: el unico sitio con try/catch.
 */
export class HttpException extends Error {
    private readonly _code: number;

    private constructor(message: string, code: number) {
        super(message);
        this.name = "HttpException";
        this._code = code;
    }

    public get code(): number {
        return this._code;
    }

    public static fromResponse(code: number, message: string): HttpException {
        return new HttpException(message, code);
    }

    public static networkErrorCustom(): never {
        throw new HttpException(
            "No se ha podido contactar con el servidor. ¿Esta arrancado?",
            ResponseCodeEnum.INTERNAL_SERVER_ERROR,
        );
    }

    /**
     * Saca un mensaje legible de lo que sea que se haya capturado.
     *
     * En TypeScript un `catch` recibe `unknown`, no `Error`: se puede lanzar
     * cualquier cosa, incluido un numero. Por eso hay que comprobar el tipo antes
     * de leer `.message`, y por eso esto vive en un sitio y no repetido en cada
     * store.
     */
    public static getMessage(exception: unknown): string {
        if (exception instanceof HttpException || exception instanceof Error) {
            return exception.message;
        }
        return "Ha ocurrido un error inesperado";
    }
}
