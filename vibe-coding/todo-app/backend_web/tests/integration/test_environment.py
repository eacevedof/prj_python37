"""Configuracion por entorno.

Los tres entornos del proyecto son **local**, **develop** y **production**, y ese
nombre es el mismo en todas partes: en `APP_ENV`, en los ficheros de docker, en
los nombres de imagen y de contenedor, y en las rutas del proxy.

Aqui se protege la regla del modo depuracion, que NO depende solo de la variable
`APP_DEBUG`. Es una regla de seguridad, y las reglas de seguridad se prueban.
"""

import pytest

from src.modules.shared.domain.enums.env_var_enum import EnvVarEnum
from src.modules.shared.infrastructure.repositories.configuration.environment_reader_raw_repository import (
    EnvironmentReaderRawRepository,
)


def _get_reader() -> EnvironmentReaderRawRepository:
    return EnvironmentReaderRawRepository.get_instance()


def test_si_no_hay_APP_ENV_se_asume_production(monkeypatch: pytest.MonkeyPatch) -> None:
    """El olvido tipico es desplegar sin APP_ENV.

    Si el valor por defecto fuera `local`, ese olvido abriria la depuracion en un
    servidor publico y nadie se enteraria. Con production, el olvido solo hace que
    veas menos informacion de la que querias.
    """
    monkeypatch.delenv("APP_ENV", raising=False)

    reader = _get_reader()
    assert reader.is_production() is True
    assert reader.is_local() is False


def test_un_entorno_sin_configurar_nada_no_tiene_debug(monkeypatch: pytest.MonkeyPatch) -> None:
    # Dos capas fallando hacia el lado seguro: sin APP_ENV se asume production, y
    # production no mira APP_DEBUG.
    monkeypatch.delenv("APP_ENV", raising=False)
    monkeypatch.delenv("APP_DEBUG", raising=False)

    assert _get_reader().is_debug() is False


def test_los_valores_por_defecto_de_las_rutas(monkeypatch: pytest.MonkeyPatch) -> None:
    # Si faltan, la aplicacion sigue arrancando en un sitio conocido en vez de
    # reventar o escribir donde no toca.
    monkeypatch.delenv("APP_DB_PATH", raising=False)
    monkeypatch.delenv("APP_LOG_PATH", raising=False)
    monkeypatch.delenv("APP_TIME_ZONE", raising=False)

    reader = _get_reader()
    assert reader.get_db_path() == "storage/database/todo_app.db"
    assert reader.get_log_path() == "storage/logs"
    assert reader.get_time_zone() == "UTC"


def test_sin_credencial_configurada_la_api_no_se_abre(monkeypatch: pytest.MonkeyPatch) -> None:
    # La apikey es la UNICA variable sin valor por defecto util: vacia significa
    # que no pasa nadie. Una credencial por defecto seria una credencial conocida.
    monkeypatch.delenv("APP_API_KEY", raising=False)

    assert _get_reader().get_api_key() == ""


def test_en_production_nunca_hay_debug_aunque_la_variable_diga_que_si(
    monkeypatch: pytest.MonkeyPatch,
) -> None:
    # LA PRUEBA IMPORTANTE. Un `APP_DEBUG=1` olvidado en produccion es de las
    # cosas que pasan de verdad, y expondria trazas y datos internos a cualquiera.
    # La regla vive en codigo justo para que no dependa de que alguien se acuerde.
    monkeypatch.setenv("APP_ENV", "production")
    monkeypatch.setenv("APP_DEBUG", "1")

    assert _get_reader().is_debug() is False


def test_en_local_el_debug_viene_encendido_si_no_dices_nada(
    monkeypatch: pytest.MonkeyPatch,
) -> None:
    # Si estas desarrollando, lo normal es querer ver el error entero.
    monkeypatch.setenv("APP_ENV", "local")
    monkeypatch.delenv("APP_DEBUG", raising=False)

    assert _get_reader().is_debug() is True


def test_en_local_el_debug_SI_se_puede_apagar(monkeypatch: pytest.MonkeyPatch) -> None:
    # Se apaga definiendo la variable a 0. Interesa, por ejemplo, para comprobar
    # que lo que ve un cliente cuando algo revienta es el mensaje generico y no la
    # traza.
    monkeypatch.setenv("APP_ENV", "local")
    monkeypatch.setenv("APP_DEBUG", "0")

    assert _get_reader().is_debug() is False


def test_en_develop_el_debug_viene_apagado_si_no_dices_nada(
    monkeypatch: pytest.MonkeyPatch,
) -> None:
    # Esta es LA diferencia entre local y develop: el valor por defecto cuando la
    # variable no esta. Si la defines, los dos hacen lo que digas.
    monkeypatch.setenv("APP_ENV", "develop")
    monkeypatch.delenv("APP_DEBUG", raising=False)

    assert _get_reader().is_debug() is False


def test_en_develop_el_debug_se_enciende_con_la_variable(monkeypatch: pytest.MonkeyPatch) -> None:
    monkeypatch.setenv("APP_ENV", "develop")

    monkeypatch.setenv("APP_DEBUG", "1")
    assert _get_reader().is_debug() is True

    monkeypatch.setenv("APP_DEBUG", "0")
    assert _get_reader().is_debug() is False


def test_los_tres_entornos_se_reconocen_por_su_nombre_completo(
    monkeypatch: pytest.MonkeyPatch,
) -> None:
    # Se llaman `local`, `develop` y `production`. Ni `dev` ni `prod`: si alguien
    # escribe la abreviatura en un `.env`, la app no lo reconoce como ese entorno
    # y se comporta como si fuera otro. Este test fija los nombres buenos.
    monkeypatch.setenv("APP_ENV", "local")
    assert _get_reader().is_local() is True

    monkeypatch.setenv("APP_ENV", "develop")
    assert _get_reader().is_develop() is True

    monkeypatch.setenv("APP_ENV", "production")
    assert _get_reader().is_production() is True

    monkeypatch.setenv("APP_ENV", "prod")
    assert _get_reader().is_production() is False


def test_todas_las_variables_empiezan_por_app(monkeypatch: pytest.MonkeyPatch) -> None:
    """La regla del proyecto: ninguna variable de entorno sin el prefijo `APP_`.

    El proceso hereda cientos de variables de la maquina y del sistema de
    despliegue. Una llamada `DB_PATH` o `API_KEY` puede chocar con la de otra
    cosa, y el fallo que sale de ahi no revienta: coge el valor equivocado.
    """
    offenders = [
        name
        for name in vars(EnvVarEnum)
        if not name.startswith("_") and not str(vars(EnvVarEnum)[name]).startswith("APP_")
    ]

    assert not offenders, f"variables sin el prefijo APP_: {offenders}"
