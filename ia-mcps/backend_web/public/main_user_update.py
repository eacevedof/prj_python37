"""Edición de un usuario de los servidores MCP, por consola.

Hermano de `main_user_add.py`, y por lo mismo NO es una tool: aquí se cambian el
rol y el `is_enabled`, así que sería el camino corto para que un agente se
ascienda a admin. La contraseña se pide sin eco (`getpass`), nunca por argumento.

Uso:

    python public/main_user_update.py <user_tg_id> [opciones]

Opciones (lo que no se pasa, no se toca):

    --name <nombre>   cambia el nombre
    --role <1|2>      1 = admin, 2 = usuario
    --enable          lo habilita
    --disable         lo deshabilita
    --password        pide una contraseña nueva (cierra la ventana de 7 días:
                      tendrá que teclearla en su próxima petición)
    --no-password     le QUITA la contraseña: entrará solo con su id de telegram
"""

import sys
from getpass import getpass
from pathlib import Path

# Igual que en `main_stdio.py`: este fichero se lanza suelto y con un cwd que no
# controlamos, así que `src.*` no estaría en el path. De ahí los E402.
_BACKEND_WEB_PATH = str(Path(__file__).resolve().parents[1])
if _BACKEND_WEB_PATH not in sys.path:
    sys.path.insert(0, _BACKEND_WEB_PATH)

import anyio  # noqa: E402

from src.modules.users_mod.application.update_user.update_user_dto import UpdateUserDto  # noqa: E402
from src.modules.users_mod.application.update_user.update_user_service import (  # noqa: E402
    UpdateUserService,
)
from src.modules.users_mod.domain.exceptions.users_exception import UsersException  # noqa: E402

_EXIT_BAD_USAGE = 2
_EXIT_REFUSED = 1

_NAME_OPTION = "--name"
_ROLE_OPTION = "--role"
_ENABLE_FLAG = "--enable"
_DISABLE_FLAG = "--disable"
_PASSWORD_FLAG = "--password"
_NO_PASSWORD_FLAG = "--no-password"


def _get_usage_text() -> str:
    return (
        f"usage: python {Path(__file__).name} <user_tg_id>"
        f" [{_NAME_OPTION} <nombre>] [{_ROLE_OPTION} <1|2>]"
        f" [{_ENABLE_FLAG}|{_DISABLE_FLAG}] [{_PASSWORD_FLAG}|{_NO_PASSWORD_FLAG}]"
    )


def _get_option_value(arguments: list[str], option: str) -> str | None:
    """El valor que sigue a una opción, o None si la opción no está."""
    if option not in arguments:
        return None
    value_position = arguments.index(option) + 1
    if value_position >= len(arguments):
        return None
    return arguments[value_position]


def _get_is_enabled_or_none(arguments: list[str]) -> bool | None:
    if _ENABLE_FLAG in arguments:
        return True
    if _DISABLE_FLAG in arguments:
        return False
    return None


def _get_plain_password_or_none(arguments: list[str]) -> str | None:
    """None = no se toca · "" = se le quita · texto = la nueva."""
    if _NO_PASSWORD_FLAG in arguments:
        return ""
    if _PASSWORD_FLAG in arguments:
        return getpass("contraseña nueva: ")
    return None


async def _update_user_or_fail(arguments: list[str]) -> None:
    update_user_result_dto = await UpdateUserService.get_instance()(
        UpdateUserDto.from_primitives({
            "user_tg_id": arguments[0],
            "user_name": _get_option_value(arguments, _NAME_OPTION),
            "user_role_id": _get_option_value(arguments, _ROLE_OPTION),
            "is_enabled": _get_is_enabled_or_none(arguments),
            "plain_password": _get_plain_password_or_none(arguments),
        })
    )
    password_text = " (contraseña cambiada)" if update_user_result_dto.is_password_changed else ""
    print(
        f"usuario actualizado: {update_user_result_dto.user_uuid}"
        f" (telegram: {update_user_result_dto.user_tg_id},"
        f" nombre: {update_user_result_dto.user_name},"
        f" rol: {update_user_result_dto.user_role_id},"
        f" activo: {int(update_user_result_dto.is_enabled)}){password_text}"
    )


def start_user_update_or_fail() -> None:
    arguments = sys.argv[1:]
    if not arguments or arguments[0].startswith("--"):
        print(_get_usage_text(), file=sys.stderr)
        sys.exit(_EXIT_BAD_USAGE)

    try:
        anyio.run(_update_user_or_fail, arguments)
    except UsersException as users_exception:
        print(f"error: {users_exception.message}", file=sys.stderr)
        sys.exit(_EXIT_REFUSED)


if __name__ == "__main__":
    start_user_update_or_fail()
