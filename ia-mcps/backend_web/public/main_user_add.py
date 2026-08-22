"""Alta de un usuario de los servidores MCP, por consola.

El alta NO es una tool y no lo será: un agente no debe poder fabricarse un
administrador, y la contraseña no tiene por qué acabar en el historial de una
conversación. Por eso se teclea aquí, y se pide sin eco (`getpass`) en vez de
pasarla como argumento, que quedaría en el historial de la shell.

Uso:

    python public/main_user_add.py <user_tg_id> <nombre> [--admin] [--disabled]

Sin contraseña (enter en el prompt) el usuario entra siempre con solo su id de
telegram; con contraseña, se le pedirá la primera vez y cada 7 días.
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

from src.modules.users_mod.application.create_user.create_user_dto import CreateUserDto  # noqa: E402
from src.modules.users_mod.application.create_user.create_user_service import (  # noqa: E402
    CreateUserService,
)
from src.modules.users_mod.domain.enums.user_role_enum import UserRoleEnum  # noqa: E402
from src.modules.users_mod.domain.exceptions.users_exception import UsersException  # noqa: E402

_EXIT_BAD_USAGE = 2
_EXIT_REFUSED = 1
_ADMIN_FLAG = "--admin"
_DISABLED_FLAG = "--disabled"


def _get_usage_text() -> str:
    return (
        f"usage: python {Path(__file__).name} <user_tg_id> <nombre>"
        f" [{_ADMIN_FLAG}] [{_DISABLED_FLAG}]"
    )


async def _create_user_or_fail(arguments: list[str]) -> None:
    create_user_result_dto = await CreateUserService.get_instance()(
        CreateUserDto.from_primitives({
            "user_tg_id": arguments[0],
            "user_name": arguments[1],
            "plain_password": getpass("contraseña (enter = sin contraseña): "),
            "user_role_id": int(
                UserRoleEnum.ADMIN if _ADMIN_FLAG in arguments else UserRoleEnum.USER
            ),
            "is_enabled": _DISABLED_FLAG not in arguments,
        })
    )
    print(
        f"usuario creado: {create_user_result_dto.user_uuid}"
        f" (telegram: {create_user_result_dto.user_tg_id},"
        f" rol: {create_user_result_dto.user_role_id})"
    )


def start_user_add_or_fail() -> None:
    arguments = sys.argv[1:]
    if len(arguments) < 2:
        print(_get_usage_text(), file=sys.stderr)
        sys.exit(_EXIT_BAD_USAGE)

    try:
        anyio.run(_create_user_or_fail, arguments)
    except UsersException as users_exception:
        print(f"error: {users_exception.message}", file=sys.stderr)
        sys.exit(_EXIT_REFUSED)


if __name__ == "__main__":
    start_user_add_or_fail()
