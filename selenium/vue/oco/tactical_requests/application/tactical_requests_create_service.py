from time import sleep
import random
from vue.shared.infrastructure.factories.driver_factory import get_chrome, close
from vue.shared.infrastructure.facades.dom import Dom
from vue.shared.infrastructure.facades.dropdown import Dropdown
from vue.shared.infrastructure.facades.element import Element
from vue.shared.infrastructure.facades.dt import get_ymd_plus

from vue.shared.infrastructure.generators.uuid import get_uuid
from vue.shared.infrastructure.repositories.files_repository import FilesRepository
from vue.shared.infrastructure.repositories.routes_repository import RoutesRepository

from vue.shared.domain.element_enum import ElementEnum
from vue.oco.login.application.login_service import login_usr1_or_fail
from vue.oco.tactical_requests.infrastructure.repositories.tactical_requests_repository import \
    TacticalRequestsRepository
from vue.oco.tactical_requests.infrastructure.repositories.tactical_requests_attributes_repository import \
    TacticalRequestsAttributesRepository
from vue.oco.tactical_requests.infrastructure.repositories.tactical_request_groups_attributes_repository import \
    TacticalRequestGroupsAttributesRepository
from vue.oco.tactical_requests.infrastructure.repositories.tactical_requests_tags_repository import \
    TacticalRequestTagsRepository


def invoke() -> None:
    login_usr1_or_fail()
    sleep(20)

    browser = get_chrome()
    browser.get(RoutesRepository.get_tactical_requests_add_url())
    dom = Dom(browser)
    sleep(10)

    __config_request_type(dom)
    __requests_details(dom)
    sleep(7)

    __create_attributes_production(dom)
    __create_attributes_diseno(dom)
    __create_attributes_datos_opcionales(dom)
    __create_tags_documentos(dom)

    btn_id = TacticalRequestsRepository.get_id_button_save()
    btn_save = dom.find_by_id(btn_id)
    btn_save.click()
    close(25)


def __config_request_type(dom: Dom) -> None:
    dd = Dropdown(dom)

    btn_xpath = TacticalRequestsRepository.get_sel_request_type()
    li_xpath = TacticalRequestsRepository.get_sel_request_type(ElementEnum.LI_XPATH)
    dd.select_by_xpath(btn_xpath, li_xpath)
    sleep(10)

    btn_xpath = TacticalRequestsRepository.get_sel_asset()
    li_xpath = TacticalRequestsRepository.get_sel_asset(ElementEnum.LI_XPATH)
    dd.select_by_xpath(btn_xpath, li_xpath)
    sleep(25)


def __requests_details(dom: Dom) -> None:
    dd = Dropdown(dom)

    # motivo de solicitud
    btn_xpath = TacticalRequestsAttributesRepository.get_sel_request_reason()
    li_xpath = TacticalRequestsAttributesRepository.get_sel_request_reason(ElementEnum.LI_XPATH)
    dd.select_by_xpath(btn_xpath, li_xpath)

    # prioridad
    btn_xpath = TacticalRequestsAttributesRepository.get_sel_request_priority()
    li_xpath = TacticalRequestsAttributesRepository.get_sel_request_priority(ElementEnum.LI_XPATH)
    dd.select_by_xpath(btn_xpath, li_xpath)

    # fecha
    element_id = TacticalRequestsAttributesRepository.get_id_fecha()
    value = get_ymd_plus()
    el = Element(dom)
    el.set_value(element_id, value)

    # comentarios
    xpath = TacticalRequestsAttributesRepository.get_xpath_comment()
    i = random.randint(1, 10)
    value = f"comment {i}"
    el.set_value_by_xpath(xpath, value)
    sleep(100)


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
