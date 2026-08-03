"""Repositorio de escritura de recursos en el CDN (datasource: cdn).

El CDN (upload.theframework.es) es multi-tenant por dominio: primero se hace login
(cabecera Origin = dominio del tenant) para obtener un token AES y luego se suben
ficheros por multipart (POST /upload). Los recursos quedan servidos en
resources.theframework.es. Config por .env (CDN_*). Ver doc obsidian learn-langs.
"""

from pathlib import Path
from typing import Self, final

import httpx

from ddd.shared.infrastructure.repositories.environment_reader_raw_repository import (
    EnvironmentReaderRawRepository,
)


@final
class ResourcesWriterCdnRepository:
    """Sube recursos al CDN: login (token AES) + subida multipart."""

    _LOGIN_PATH: str = "/security/login"
    _UPLOAD_PATH: str = "/upload"
    _UPLOAD_FIELD: str = "file"
    _TOKEN_POST_KEY: str = "resource-usertoken"
    _FOLDER_POST_KEY: str = "folderdomain"
    _DEFAULT_TIMEOUT: int = 120

    def __init__(self) -> None:
        environment_reader_raw_repository = (
            EnvironmentReaderRawRepository.get_instance()
        )
        self._base_url = environment_reader_raw_repository.get_cdn_upload_url().rstrip(
            "/"
        )
        self._domain = environment_reader_raw_repository.get_cdn_domain()
        self._user = environment_reader_raw_repository.get_cdn_user()
        self._password = environment_reader_raw_repository.get_cdn_password()
        self._token: str | None = None

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def upload_file(self, local_path: str) -> str:
        """Sube un fichero y devuelve su URL publica en resources.theframework.es."""
        path = Path(local_path)
        if not path.is_file():
            raise FileNotFoundError(f"CDN upload: fichero no encontrado: {path}")

        token = await self._get_login_token()
        url = f"{self._base_url}{self._UPLOAD_PATH}"
        headers = {"Origin": self._domain}
        data = {self._TOKEN_POST_KEY: token, self._FOLDER_POST_KEY: self._domain}
        files = {
            self._UPLOAD_FIELD: (
                path.name,
                path.read_bytes(),
                "application/octet-stream",
            )
        }

        async with httpx.AsyncClient(timeout=self._DEFAULT_TIMEOUT) as client:
            response = await client.post(url, data=data, files=files, headers=headers)

        body = response.json()
        payload = body.get("data") or {}
        urls = payload.get("url") or {}
        warnings = payload.get("warning") or []
        public_url = (
            next(iter(urls.values()), None) if isinstance(urls, dict) and urls else None
        )

        if response.status_code != 200 or not public_url:
            raise RuntimeError(
                f"CDN upload fallido ({response.status_code}) para {path.name}: "
                f"errors={body.get('errors')} warnings={warnings}"
            )

        return public_url

    async def _get_login_token(self) -> str:
        """Obtiene (y cachea en la instancia) el token AES del tenant."""
        if self._token:
            return self._token

        url = f"{self._base_url}{self._LOGIN_PATH}"
        headers = {"Origin": self._domain}
        form = {"user": self._user, "password": self._password}

        async with httpx.AsyncClient(timeout=self._DEFAULT_TIMEOUT) as client:
            response = await client.post(url, data=form, headers=headers)

        body = response.json()
        token = (body.get("data") or {}).get("token", "")
        if response.status_code != 200 or not token:
            raise RuntimeError(
                f"CDN login fallido ({response.status_code}): {body.get('errors') or body.get('message')}"
            )

        self._token = token
        return token
