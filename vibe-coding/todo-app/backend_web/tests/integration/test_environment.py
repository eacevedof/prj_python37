"""Configuracion por entorno.

Los tres entornos del proyecto son **local**, **develop** y **production**, y ese
nombre es el mismo en todas partes: en `APP_ENV`, en los ficheros de docker, en
los nombres de imagen y de contenedor, y en las rutas del proxy.

Aqui se protege la regla del modo depuracion, que NO depende solo de la variable
`APP_DEBUG`. Es una regla de seguridad, y las reglas de seguridad se prueban.
"""

import pytest

from src.modules.shared.infrastructure.repositories.configuration.environment_reader_raw_repository import (
    EnvironmentReaderRawRepository,
)


def _get_reader() -> EnvironmentReaderRawRepository:
    return EnvironmentReaderRawRepository.get_instance()


def test_en_production_nunca_hay_debug_aunque_la_variable_diga_que_si(
    monkeypatch: pytest.MonkeyPatch,
) -> None:
    # LA PRUEBA IMPORTANTE. Un `APP_DEBUG=1` olvidado en produccion es de las
    # cosas que pasan de verdad, y expondria trazas y datos internos a cualquiera.
    # La regla vive en codigo justo para que no dependa de que alguien se acuerde.
    monkeypatch.setenv("APP_ENV", "production")
    monkeypatch.setenv("APP_DEBUG", "1")

    assert _get_reader().is_debug() is False


def test_en_local_siempre_hay_debug_aunque_la_variable_diga_que_no(
    monkeypatch: pytest.MonkeyPatch,
) -> None:
    # Si estas desarrollando, quieres ver el error entero. No se puede apagar.
    monkeypatch.setenv("APP_ENV", "local")
    monkeypatch.setenv("APP_DEBUG", "0")

    assert _get_reader().is_debug() is True


def test_en_develop_el_debug_depende_de_la_variable(monkeypatch: pytest.MonkeyPatch) -> None:
    monkeypatch.setenv("APP_ENV", "develop")

    monkeypatch.setenv("APP_DEBUG", "1")
    assert _get_reader().is_debug() is True

    monkeypatch.setenv("APP_DEBUG", "0")
    assert _get_reader().is_debug() is False

    monkeypatch.delenv("APP_DEBUG", raising=False)
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


def test_el_logger_escribe_en_storage_logs(monkeypatch: pytest.MonkeyPatch) -> None:
    # La ruta por defecto es relativa a backend_web/, la misma en tu maquina y
    # dentro del contenedor. En develop y production esa carpeta se monta desde el
    # host: si la ruta cambiara, los logs se irian con el contenedor.
    monkeypatch.delenv("APP_LOG_PATH", raising=False)

    assert _get_reader().get_log_path() == "storage/logs"
