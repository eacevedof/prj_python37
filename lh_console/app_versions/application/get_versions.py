from lh_console.config.config import config
from lh_console.shared.infrastructure.shell.shell_exec import ShellExec
from lh_console.shared.infrastructure.http.requests.get_request import http_get
from lh_console.app_versions.application.versions_dto import VersionsDto


def _get_login() -> str:
    pass


def make_request():
    response = http_get("https://www.example.com")
