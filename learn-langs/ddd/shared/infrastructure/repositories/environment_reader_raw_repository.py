import os
from typing import final, Self

from ddd.shared.domain.enums.envvars_keys_enum import EnvvarsKeysEnum


@final
class EnvironmentReaderRawRepository:
    """Repository for reading environment variables required by the application."""

    # Versión de la app (sincronizada con pyproject.toml [project].version; se muestra en
    # Home arr-dcha). Dos disparadores de bump:
    #  - LOTE de migraciones de contenido pendientes → sube el dígito MEDIO dejando patch .1
    #    (1.0.1 → 1.1.1 → 1.2.1); un bump por lote, se mantiene hasta que entra en `migrations`.
    #  - FEATURE de código nueva → bump MINOR normal con patch 0 (x.(y+1).0), p.ej. 1.1.1 → 1.2.0.
    APP_VERSION: str = "1.6.0"

    __instance: "EnvironmentReaderRawRepository | None" = None

    @classmethod
    def get_instance(cls) -> Self:
        """Retorna la instancia singleton."""
        if cls.__instance is None:
            cls.__instance = cls()
        return cls.__instance

    def get(self, key: str, default: str = "") -> str:
        """
        Lee una variable de entorno con valor por defecto.

        Args:
            key: Nombre de la variable de entorno
            default: Valor por defecto si no existe

        Returns:
            str: Valor de la variable o default
        """
        return os.getenv(key, default)

    def get_app_version(self) -> str:
        """Retorna la versión de la app (build). Se incrementa a mano por compilado."""
        return self.APP_VERSION

    def get_azure_organization_name(self) -> str:
        return self.__get_required(EnvvarsKeysEnum.AZURE_ORGANIZATION_NAME)

    def get_azure_api_version(self) -> str:
        return self.__get_required(EnvvarsKeysEnum.AZURE_API_VERSION)

    def get_azure_pat(self) -> str:
        return self.__get_required(EnvvarsKeysEnum.AZURE_PAT)

    def get_app_default_project(self) -> str:
        return self.__get_required(EnvvarsKeysEnum.APP_DEFAULT_PROJECT)

    def get_sharepoint_client_id(self) -> str:
        return self.__get_required(EnvvarsKeysEnum.SHAREPOINT_CLIENT_ID)

    def get_sharepoint_client_secret(self) -> str:
        return self.__get_required(EnvvarsKeysEnum.SHAREPOINT_CLIENT_SECRET)

    def get_sharepoint_tenant_id(self) -> str:
        return self.__get_required(EnvvarsKeysEnum.SHAREPOINT_TENANT_ID)

    def get_sharepoint_site_id(self) -> str:
        return self.__get_required(EnvvarsKeysEnum.SHAREPOINT_SITE_ID)

    def get_local_docker_lamp_path(self) -> str:
        return self.__get_required(EnvvarsKeysEnum.LOCAL_DOCKER_LAMP_PATH)

    def get_local_www_path(self) -> str:
        return self.__get_required(EnvvarsKeysEnum.LOCAL_WWW_PATH)

    def get_local_vhosts_file(self) -> str:
        return self.__get_required(EnvvarsKeysEnum.LOCAL_VHOSTS_FILE)

    def get_local_hosts_file(self) -> str:
        return self.__get_required(EnvvarsKeysEnum.LOCAL_HOSTS_FILE)

    def get_local_base_env_file(self) -> str:
        return self.__get_required(EnvvarsKeysEnum.LOCAL_BASE_ENV_FILE)

    def get_cdn_upload_url(self) -> str:
        return self.__get_required(EnvvarsKeysEnum.CDN_UPLOAD_URL)

    def get_cdn_resources_url(self) -> str:
        return self.__get_required(EnvvarsKeysEnum.CDN_RESOURCES_URL)

    def get_cdn_domain(self) -> str:
        return self.__get_required(EnvvarsKeysEnum.CDN_DOMAIN)

    def get_cdn_user(self) -> str:
        return self.__get_required(EnvvarsKeysEnum.CDN_USER)

    def get_cdn_password(self) -> str:
        return self.__get_required(EnvvarsKeysEnum.CDN_PASSWORD)

    def __get_required(self, key: EnvvarsKeysEnum) -> str:
        value = os.getenv(key)
        if value is None:
            raise ValueError(f"Missing required environment variable: {key}")
        return value
