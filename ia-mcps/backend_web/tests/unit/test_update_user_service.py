"""Edición de usuarios — contra el caso de uso, no contra una tool.

`UpdateUser` no se expone como tool a propósito (cambia rol y `is_enabled`), así
que aquí no hay HTTP: se llama al service tal cual, contra la misma base SQLite
temporal que usa el resto de la suite. La contraseña se comprueba por su efecto
—si el guardarraíl la pide o la acepta— y nunca leyendo el hash.
"""
import asyncio

import pytest

from tests.conftest import ADMIN_TG_ID, PWD_USER_TG_ID, USER_PASSWORD, USER_TG_ID


def _get_updated_user(primitives: dict):
    from src.modules.users_mod.application.update_user.update_user_dto import UpdateUserDto
    from src.modules.users_mod.application.update_user.update_user_service import UpdateUserService

    return asyncio.run(
        UpdateUserService.get_instance()(UpdateUserDto.from_primitives(primitives))
    )


def _get_authorized_user(primitives: dict):
    from src.modules.users_mod.application.authorize_user.authorize_user_dto import AuthorizeUserDto
    from src.modules.users_mod.application.authorize_user.authorize_user_service import (
        AuthorizeUserService,
    )

    return asyncio.run(
        AuthorizeUserService.get_instance()(AuthorizeUserDto.from_primitives(primitives))
    )


def test_the_name_changes_and_the_rest_stays(seeded_users) -> None:
    update_user_result_dto = _get_updated_user({"user_tg_id": USER_TG_ID, "user_name": "Eduardo A."})

    assert update_user_result_dto.user_name == "Eduardo A."
    assert update_user_result_dto.user_role_id == 2
    assert update_user_result_dto.is_enabled is True
    assert update_user_result_dto.is_password_changed is False


def test_a_user_can_be_promoted_to_admin(seeded_users) -> None:
    _get_updated_user({"user_tg_id": USER_TG_ID, "user_role_id": 1})

    # Se comprueba por lo que puede hacer, no por la columna: ya es admin cuando
    # el guardarraíl le deja operar sobre otro.
    authorize_user_result_dto = _get_authorized_user({
        "user_tg_id": USER_TG_ID,
        "target_user_tg_id": ADMIN_TG_ID,
    })
    assert authorize_user_result_dto.is_admin is True
    assert authorize_user_result_dto.owner_user_tg_id == ADMIN_TG_ID


def test_a_disabled_user_stops_entering(seeded_users) -> None:
    from src.modules.users_mod.domain.exceptions.users_exception import UsersException

    _get_updated_user({"user_tg_id": USER_TG_ID, "is_enabled": False})

    with pytest.raises(UsersException) as exception_info:
        _get_authorized_user({"user_tg_id": USER_TG_ID})
    assert "deshabilitada" in exception_info.value.message


def test_a_new_password_closes_the_window_and_replaces_the_old_one(seeded_users) -> None:
    from src.modules.users_mod.domain.exceptions.users_exception import UsersException

    # Abre la ventana con la contraseña vieja...
    _get_authorized_user({"user_tg_id": PWD_USER_TG_ID, "password": USER_PASSWORD})
    update_user_result_dto = _get_updated_user(
        {"user_tg_id": PWD_USER_TG_ID, "plain_password": "otra-mas-larga"}
    )

    assert update_user_result_dto.is_password_changed is True

    # ...y cambiarla la cierra: sin contraseña ya no pasa.
    with pytest.raises(UsersException) as exception_info:
        _get_authorized_user({"user_tg_id": PWD_USER_TG_ID})
    assert "se requiere la contraseña" in exception_info.value.message

    # La vieja ya no vale y la nueva sí.
    with pytest.raises(UsersException) as wrong_password_info:
        _get_authorized_user({"user_tg_id": PWD_USER_TG_ID, "password": USER_PASSWORD})
    assert "contraseña incorrecta" in wrong_password_info.value.message

    authorize_user_result_dto = _get_authorized_user({
        "user_tg_id": PWD_USER_TG_ID,
        "password": "otra-mas-larga",
    })
    assert authorize_user_result_dto.user_tg_id == PWD_USER_TG_ID


def test_the_password_can_be_removed(seeded_users) -> None:
    update_user_result_dto = _get_updated_user({"user_tg_id": PWD_USER_TG_ID, "plain_password": ""})

    assert update_user_result_dto.is_password_changed is True

    # Sin contraseña guardada no se le pide nunca más.
    authorize_user_result_dto = _get_authorized_user({"user_tg_id": PWD_USER_TG_ID})
    assert authorize_user_result_dto.user_tg_id == PWD_USER_TG_ID


def test_an_unknown_telegram_id_is_refused(seeded_users) -> None:
    from src.modules.users_mod.domain.exceptions.users_exception import UsersException

    with pytest.raises(UsersException) as exception_info:
        _get_updated_user({"user_tg_id": "tg-nadie", "user_name": "Nadie"})

    assert "no hay ningún usuario" in exception_info.value.message


def test_an_unknown_role_is_refused(seeded_users) -> None:
    from src.modules.users_mod.domain.exceptions.users_exception import UsersException

    with pytest.raises(UsersException) as exception_info:
        _get_updated_user({"user_tg_id": USER_TG_ID, "user_role_id": 9})

    assert "rol desconocido" in exception_info.value.message


def test_an_update_with_nothing_to_change_is_refused(seeded_users) -> None:
    from src.modules.users_mod.domain.exceptions.users_exception import UsersException

    with pytest.raises(UsersException) as exception_info:
        _get_updated_user({"user_tg_id": USER_TG_ID})

    assert "ningún cambio" in exception_info.value.message
