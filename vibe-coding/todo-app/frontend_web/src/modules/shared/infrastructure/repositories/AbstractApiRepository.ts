import { HttpHeaderEnum } from "@/modules/shared/domain/enums/HttpHeaderEnum";
import type { HttpMethod } from "@/modules/shared/domain/enums/HttpMethodEnum";
import { HttpMethodEnum } from "@/modules/shared/domain/enums/HttpMethodEnum";
import { ResponseKeyEnum } from "@/modules/shared/domain/enums/ResponseKeyEnum";
import { HttpException } from "@/modules/shared/domain/exceptions/HttpException";
import { EnvironmentReaderRawRepository } from "@/modules/shared/infrastructure/repositories/configuration/EnvironmentReaderRawRepository";

type Primitives = Record<string, unknown>;

/**
 * Base de todos los repositorios que hablan con la API.
 * Gemelo de `AbstractSqliteRepository`: la fontaneria comun en un solo sitio.
 *
 * Se ocupa de tres cosas que si no acabarian repetidas en cada repositorio:
 * poner las cabeceras, desenvolver el sobre `{status, data}` y convertir un
 * error HTTP en una excepcion.
 *
 * SOBRE EL try/catch QUE HAY AQUI
 * -------------------------------
 * La regla dice que solo los stores capturan. Este `catch` es la excepcion, y es
 * la misma idea que `DueDate` en el backend: TRADUCE, no se traga nada.
 *
 * `fetch` tiene un comportamiento que sorprende a todo el mundo: NO falla cuando
 * el servidor responde 404 o 500. Solo falla si no se pudo llegar al servidor.
 * Por eso hacen falta las dos cosas: comprobar `response.ok` a mano, y capturar
 * el fallo de red para convertirlo en la misma excepcion que todo lo demas.
 * Despues de traducir, la excepcion SUBE: aqui no se decide nada.
 */
export abstract class AbstractApiRepository {
    private readonly _environmentReaderRawRepository: EnvironmentReaderRawRepository;

    protected constructor() {
        this._environmentReaderRawRepository = EnvironmentReaderRawRepository.getInstance();
    }

    protected async getJson<T>(path: string, queryParams: Primitives = {}): Promise<T> {
        const query = this.getQueryString(queryParams);
        return this.request<T>(HttpMethodEnum.GET, `${path}${query}`);
    }

    protected async postJson<T>(path: string, body: Primitives): Promise<T> {
        return this.request<T>(HttpMethodEnum.POST, path, body);
    }

    protected async putJson<T>(path: string, body: Primitives): Promise<T> {
        return this.request<T>(HttpMethodEnum.PUT, path, body);
    }

    protected async patchJson<T>(path: string, body: Primitives): Promise<T> {
        return this.request<T>(HttpMethodEnum.PATCH, path, body);
    }

    protected async deleteJson<T>(path: string): Promise<T> {
        return this.request<T>(HttpMethodEnum.DELETE, path);
    }

    private async request<T>(method: HttpMethod, path: string, body?: Primitives): Promise<T> {
        const url = `${this._environmentReaderRawRepository.getApiBaseUrl()}${path}`;

        let response: Response;
        try {
            response = await fetch(url, {
                method,
                headers: {
                    [HttpHeaderEnum.CONTENT_TYPE]: HttpHeaderEnum.APPLICATION_JSON,
                    [HttpHeaderEnum.API_KEY]: this._environmentReaderRawRepository.getApiKey(),
                },
                ...(body === undefined ? {} : { body: JSON.stringify(body) }),
            });
        } catch {
            // No se pudo llegar al servidor (esta apagado, no hay red...).
            HttpException.networkErrorCustom();
        }

        const envelope = (await response.json()) as Primitives;
        if (!response.ok) {
            const message = String(envelope[ResponseKeyEnum.ERROR] ?? response.statusText);
            throw HttpException.fromResponse(response.status, message);
        }
        return envelope[ResponseKeyEnum.DATA] as T;
    }

    private getQueryString(queryParams: Primitives): string {
        // Los valores vacios NO se mandan: en la API, un filtro ausente y un
        // filtro vacio significan cosas distintas (mira `is_done` en SearchTasks).
        const entries = Object.entries(queryParams).filter(
            ([, value]) => value !== undefined && value !== null && value !== "",
        );
        if (entries.length === 0) {
            return "";
        }
        const search = new URLSearchParams(entries.map(([key, value]) => [key, String(value)]));
        return `?${search.toString()}`;
    }
}
