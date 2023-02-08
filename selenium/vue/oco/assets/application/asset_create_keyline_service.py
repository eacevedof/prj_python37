from time import sleep
import random
from vue.shared.infrastructure.factories.driver_factory import get_chrome, close
from vue.shared.infrastructure.facades.dom import Dom
from vue.shared.infrastructure.facades.dropdown import Dropdown
from vue.shared.infrastructure.facades.element import Element
from vue.shared.infrastructure.generators.uuid import get_uuid
from vue.shared.infrastructure.repositories.files_repository import FilesRepository
from vue.shared.infrastructure.repositories.routes_repository import RoutesRepository

from vue.shared.domain.element_enum import ElementEnum
from vue.oco.login.application.login_service import login_usr1_or_fail
from vue.oco.assets.infrastructure.repositories.assets_repository import AssetsRepository
from vue.oco.assets.infrastructure.repositories.asset_keyline_attributes_repository import \
    AssetKeylineAttributesRepository
from vue.oco.assets.infrastructure.repositories.asset_groups_attributes_repository import \
    AssetGroupsAttributesRepository
from vue.oco.assets.infrastructure.repositories.asset_tags_repository import AssetTagsRepository


def asset_create_keyline() -> None:
    login_usr1_or_fail()
    sleep(30)

    browser = get_chrome()
    browser.get(RoutesRepository.get_asset_add_url())
    dom = Dom(browser)
    sleep(3)

    __config_asset_type(dom)
    __create_attributes_production(dom)
    __create_attributes_measures(dom)
    __create_attributes_datos_opcionales(dom)
    __create_tags_documentos(dom)

    btn_id = AssetsRepository.get_id_button_save()
    btn_save = dom.find_by_id(btn_id)
    btn_save.click()
    close(30)


def __config_asset_type(dom: Dom) -> None:
    el = Element(dom)
    element_id = AssetsRepository.get_id_asset_code()
    uuid = get_uuid(4)
    value = f"kl-{uuid}"
    el.set_value(element_id, value)

    element_id = AssetsRepository.get_id_asset_name()
    value = f"kl-{uuid}"
    el.set_value(element_id, value)

    dd = Dropdown(dom)
    # tipo de asset
    btn_xpath = AssetKeylineAttributesRepository.get_sel_asset_type_keyline()
    li_xpath = AssetKeylineAttributesRepository.get_sel_asset_type_keyline(ElementEnum.LI_XPATH)
    dd.select_by_xpath(btn_xpath, li_xpath)


def __create_attributes_production(dom: Dom) -> None:
    el = Element(dom)
    xpath = AssetKeylineAttributesRepository.get_sel_maquina()
    uuid = get_uuid(4)
    value = f"kl-{uuid}"
    el.set_value_by_xpath(xpath, value)

    dd = Dropdown(dom)

    # maquina
    btn_xpath = AssetKeylineAttributesRepository.get_sel_maquina()
    li_xpath = AssetKeylineAttributesRepository.get_sel_maquina(ElementEnum.LI_XPATH)
    dd.select_by_xpath(btn_xpath, li_xpath)

    # plano propio
    btn_xpath = AssetKeylineAttributesRepository.get_sel_plano_propio()
    li_xpath = AssetKeylineAttributesRepository.get_sel_plano_propio(ElementEnum.LI_XPATH)
    dd.select_by_xpath(btn_xpath, li_xpath)

    # descripcion plano
    xpath = AssetKeylineAttributesRepository.get_xpath_descripcion()
    value = f"desc plano {uuid}"
    el.set_value_by_xpath(xpath, value)

    # tipo plano
    btn_xpath = AssetKeylineAttributesRepository.get_sel_tipo_plano()
    li_xpath = AssetKeylineAttributesRepository.get_sel_tipo_plano(ElementEnum.LI_XPATH)
    dd.select_by_xpath(btn_xpath, li_xpath)

    # prospecto doblado
    btn_xpath = AssetKeylineAttributesRepository.get_sel_prospecto_doblado()
    li_xpath = AssetKeylineAttributesRepository.get_sel_prospecto_doblado(ElementEnum.LI_XPATH)
    dd.select_by_xpath(btn_xpath, li_xpath)


def __create_attributes_measures(dom: Dom) -> None:
    # tab medida
    tab_xpath = AssetGroupsAttributesRepository.get_tab_keyline_medida()
    btn_tab = dom.find_by_xpath(tab_xpath)
    btn_tab.click()
    sleep(1)

    el = Element(dom)

    # medida A
    i = random.randint(1, 10)
    xpath = AssetKeylineAttributesRepository.get_xpath_medida_a()
    value = f"medida a {i}"
    el.set_value_by_xpath(xpath, value)

    # medida B
    i = random.randint(1, 10)
    xpath = AssetKeylineAttributesRepository.get_xpath_medida_b()
    value = f"medida b {i}"
    el.set_value_by_xpath(xpath, value)

    # medida C
    i = random.randint(1, 10)
    xpath = AssetKeylineAttributesRepository.get_xpath_medida_c()
    value = f"medida c {i}"
    el.set_value_by_xpath(xpath, value)

    # medida D
    i = random.randint(1, 10)
    xpath = AssetKeylineAttributesRepository.get_xpath_medida_d()
    value = f"medida d {i}"
    el.set_value_by_xpath(xpath, value)

    # capacidad
    i = random.randint(1, 10)
    xpath = AssetKeylineAttributesRepository.get_xpath_capacidad()
    value = f"capacidad {i}"
    el.set_value_by_xpath(xpath, value)

    # capacidad
    i = random.randint(1, 10)
    xpath = AssetKeylineAttributesRepository.get_xpath_diametro()
    value = f"diametro {i}"
    el.set_value_by_xpath(xpath, value)


def __create_attributes_datos_opcionales(dom: Dom) -> None:
    tab_xpath = AssetGroupsAttributesRepository.get_tab_keyline_datos_opcionales()
    btn_tab = dom.find_by_xpath(tab_xpath)
    btn_tab.click()
    sleep(1)

    el = Element(dom)

    xpath = AssetKeylineAttributesRepository.get_xpath_comentarios_opcionales()
    uuid = get_uuid(4)
    value = f"comentarios opcionales {uuid}"
    el.set_value_by_xpath(xpath, value)


def __create_tags_documentos(dom: Dom) -> None:
    tab_xpath = AssetGroupsAttributesRepository.get_tab_keyline_documentos()
    btn_tab = dom.find_by_xpath(tab_xpath)
    btn_tab.click()
    sleep(1)

    el = Element(dom)

    xpath = AssetTagsRepository.get_xpath_file_tag_artworks()
    path_file = FilesRepository.get_rnd_artworks()
    el.set_value_by_xpath(xpath, path_file)
