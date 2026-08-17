import { getBuildConfig, getRuntimeConfig } from "@/core/boot/Env";
import { ApiPathEnum } from "@/modules/shared/domain/enums/ApiPathEnum";
import { AppVersionEnum } from "@/modules/shared/domain/enums/AppVersionEnum";

/**
 * Lectura de la configuracion. Gemelo de `environment_reader_raw_repository.py`.
 *
 * Un getter tipado por cada valor, y nadie mas toca `import.meta.env`. Es la
 * misma regla que en el backend y por las mismas razones: de un vistazo se ve
 * QUE hay que configurar, y la conversion ocurre en un sitio.
 */
export class EnvironmentReaderRawRepository {
    public static getInstance(): EnvironmentReaderRawRepository {
        return new EnvironmentReaderRawRepository();
    }

    /**
     * Version del front que tiene cargada el navegador.
     *
     * Se expone desde aqui, y no leyendo el enum directamente en una vista, por
     * lo mismo que en el backend: la configuracion se lee por un getter tipado y
     * en un solo sitio.
     */
    public getAppVersion(): string {
        return AppVersionEnum.CURRENT;
    }

    /**
     * Credencial de la API.
     *
     * Gana la inyectada por el servidor (contenedor) sobre la de compilacion
     * (desarrollo), para que un mismo javascript compilado valga en cualquier
     * entorno sin volver a compilarlo.
     */
    public getApiKey(): string {
        return getRuntimeConfig().apiKey || getBuildConfig().apiKey || "";
    }

    /**
     * Prefijo de las llamadas a la API.
     *
     * Vacio por defecto, y eso es lo correcto: front y API viven en el mismo
     * origen, asi que `/api/lists` ya apunta a donde tiene que apuntar. Solo hace
     * falta un valor aqui si algun dia se sirven por separado.
     */
    public getApiBaseUrl(): string {
        return getRuntimeConfig().apiBaseUrl || getBuildConfig().apiBaseUrl || "";
    }

    public getHealthCheckPath(): string {
        return `${this.getApiBaseUrl()}${ApiPathEnum.HEALTH_CHECK}`;
    }
}
