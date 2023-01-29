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
from vue.oco.tactical_requests.infrastructure.repositories.tactical_requests_repository import TacticalRequestsRepository
from vue.oco.tactical_requests.infrastructure.repositories.tactical_requests_attributes_repository import TacticalRequestsAttributesRepository
from vue.oco.tactical_requests.infrastructure.repositories.tactical_request_groups_attributes_repository import \
    TacticalRequestGroupsAttributesRepository
from vue.oco.tactical_requests.infrastructure.repositories.tactical_requests_tags_repository import TacticalRequestTagsRepository


def invoke() -> None:
    login_usr1_or_fail()
    sleep(30)

    browser = get_chrome()
    browser.get(RoutesRepository.get_asset_add_url())
    dom = Dom(browser)
    sleep(3)

    __config_request_type(dom)
    __create_attributes_info(dom)
    __create_attributes_production(dom)
    __create_attributes_diseno(dom)
    __create_attributes_datos_opcionales(dom)
    __create_tags_documentos(dom)

    btn_id = TacticalRequestsRepository.get_id_button_save()
    btn_save = dom.find_by_id(btn_id)
    btn_save.click()
    close(25)


def __config_request_type(dom: Dom) -> None:
    el = Element(dom)
    element_id = TacticalRequestsRepository.get_id_asset_code()
    uuid = get_uuid(4)
    value = f"mat-{uuid}"
    el.set_value(element_id, value)

    element_id = TacticalRequestsRepository.get_id_asset_name()
    value = f"mat-{uuid}"
    el.set_value(element_id, value)

    dd = Dropdown(dom)
    # tipo de asset
    btn_xpath = TacticalRequestsAttributesRepository.get_sel_asset_type()
    li_xpath = TacticalRequestsAttributesRepository.get_sel_asset_type(ElementEnum.LI_XPATH)
    dd.select_by_xpath(btn_xpath, li_xpath)


def __create_attributes_info(dom: Dom) -> None:
    el = Element(dom)
    element_id = TacticalRequestsAttributesRepository.get_id_material_code()
    uuid = get_uuid(4)
    value = f"mat-{uuid}"
    el.set_value(element_id, value)

    dd = Dropdown(dom)

    # categoria
    btn_xpath = TacticalRequestsAttributesRepository.get_sel_category()
    li_xpath = TacticalRequestsAttributesRepository.get_sel_category(ElementEnum.LI_XPATH)
    dd.select_by_xpath(btn_xpath, li_xpath)

    # tipo
    btn_xpath = TacticalRequestsAttributesRepository.get_sel_type()
    li_xpath = TacticalRequestsAttributesRepository.get_sel_type(ElementEnum.LI_XPATH)
    dd.select_by_xpath(btn_xpath, li_xpath)

    # Forma Farmacéutica
    btn_xpath = TacticalRequestsAttributesRepository.get_sel_lab_form()
    li_xpath = TacticalRequestsAttributesRepository.get_sel_lab_form(ElementEnum.LI_XPATH)
    dd.select_by_xpath(btn_xpath, li_xpath)

    element_id = TacticalRequestsAttributesRepository.get_id_dosis()
    value = f"dosis-{uuid}"
    el.set_value(element_id, value)

    element_id = TacticalRequestsAttributesRepository.get_id_presentation()
    value = f"presentacion-{uuid}"
    el.set_value(element_id, value)

    # Mercado
    btn_xpath = TacticalRequestsAttributesRepository.get_sel_market()
    li_xpath = TacticalRequestsAttributesRepository.get_sel_market(ElementEnum.LI_XPATH)
    dd.select_by_xpath(btn_xpath, li_xpath)

    # Cliente
    btn_xpath = TacticalRequestsAttributesRepository.get_sel_client()
    li_xpath = TacticalRequestsAttributesRepository.get_sel_client(ElementEnum.LI_XPATH)
    dd.select_by_xpath(btn_xpath, li_xpath)

    # País
    btn_xpath = TacticalRequestsAttributesRepository.get_sel_country()
    li_xpath = TacticalRequestsAttributesRepository.get_sel_country(ElementEnum.LI_XPATH)
    dd.select_by_xpath(btn_xpath, li_xpath)

    # Fabricante
    btn_xpath = TacticalRequestsAttributesRepository.get_sel_fabricant()
    li_xpath = TacticalRequestsAttributesRepository.get_sel_fabricant(ElementEnum.LI_XPATH)
    dd.select_by_xpath(btn_xpath, li_xpath)

    element_id = TacticalRequestsAttributesRepository.get_id_principio_activo()
    value = f"pa-{uuid}"
    el.set_value(element_id, value)

    element_id = TacticalRequestsAttributesRepository.get_id_nomenclatura_extra()
    value = f"nomenclatura-{uuid}"
    el.set_value(element_id, value)


def __create_attributes_production(dom: Dom) -> None:
    # tab produccion
    tab_xpath = TacticalRequestGroupsAttributesRepository.get_tab_production()
    btn_tab = dom.find_by_xpath(tab_xpath)
    btn_tab.click()
    sleep(1)

    el = Element(dom)

    element_id = TacticalRequestsAttributesRepository.get_id_numero_de_tintas()
    value = random.randint(1, 10)
    el.set_value(element_id, value)

    element_id = TacticalRequestsAttributesRepository.get_id_acabados_especiales()
    i = random.randint(1, 10)
    value = f"acab espe {i}"
    el.set_value(element_id, value)


def __create_attributes_diseno(dom: Dom) -> None:
    # tab diseno
    tab_xpath = TacticalRequestGroupsAttributesRepository.get_tab_diseno()
    btn_tab = dom.find_by_xpath(tab_xpath)
    btn_tab.click()
    sleep(1)

    el = Element(dom)

    element_id = TacticalRequestsAttributesRepository.get_id_laetus()
    i = random.randint(1, 10)
    value = f"laetus {i}"
    el.set_value(element_id, value)

    dd = Dropdown(dom)

    # marcas visuales
    btn_xpath = TacticalRequestsAttributesRepository.get_sel_marcas_visuales()
    li_xpath = TacticalRequestsAttributesRepository.get_sel_marcas_visuales(ElementEnum.LI_XPATH)
    dd.select_by_xpath(btn_xpath, li_xpath)

    element_id = TacticalRequestsAttributesRepository.get_id_referencia_al_libro()
    i = random.randint(1, 10)
    value = f"ref {i}"
    el.set_value(element_id, value)


def __create_attributes_datos_opcionales(dom: Dom) -> None:
    tab_xpath = TacticalRequestGroupsAttributesRepository.get_tab_datos_opcionales()
    btn_tab = dom.find_by_xpath(tab_xpath)
    btn_tab.click()
    sleep(1)

    el = Element(dom)

    element_id = TacticalRequestsAttributesRepository.get_id_comentarios_opcionales()
    uuid = get_uuid(4)
    value = f"comentarios opcionales {uuid}"
    el.set_value(element_id, value)


def __create_tags_documentos(dom: Dom) -> None:
    tab_xpath = TacticalRequestGroupsAttributesRepository.get_tab_documentos()
    btn_tab = dom.find_by_xpath(tab_xpath)
    btn_tab.click()
    sleep(1)

    el = Element(dom)

    element_name = TacticalRequestTagsRepository.get_tag_artworks()
    path_file = FilesRepository.get_rnd_artworks()
    el.set_value_by_name(element_name, path_file)
