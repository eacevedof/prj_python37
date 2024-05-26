from lh_console.config.config import *
from lh_console.shared.infrastructure.shell.shell_exec import ShellExec
from lh_console.shared.infrastructure.http.requests.get_request import http_get
from lh_console.app_versions.application.versions_dto import VersionsDto


def _get_login() -> str:
    return ""


def get_versions() -> VersionsDto:
    try:
        _get_login()

        url_health = (config.get(ConfigKeysEnum.ENVIRONMENTS.value, {})
                      .get(ConfigEnvsEnum.PROD_MT.value, {})
                      .get(ConfigUrlsEnum.URL_HEALTH.value, ""))

        # '{"code":200,"message":"OK","data":{"version":"RELEASE 4.0.2"}}'
        response = http_get(url_health)
        #response = http_get("https://eduardoafx.com")
        code = response.get("code", "")
        if code != 200:
            version = "error -> " + response.get("message", "") + " | " + response.get("data", "")
            return VersionsDto(version)

        data = response.get("data", {})
        version = data.get("version", "")
        return VersionsDto(version)

    except Exception as e:
        version = "error -> " + str(e)
        return VersionsDto(version)
