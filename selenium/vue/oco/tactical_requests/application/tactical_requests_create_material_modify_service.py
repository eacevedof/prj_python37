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
    sleep(10)

    browser = get_chrome()
    browser.get(RoutesRepository.get_tactical_requests_add_url())
    dom = Dom(browser)
    sleep(15)

    __config_request_type(dom)
    __requests_details(dom)

    __update_attributes_tab_material_info(dom)
    __update_attributes_tab_optional_data(dom)
    #__create_tags_documentos(dom)

    btn_xpath = TacticalRequestsRepository.get_xpath_button_save()
    btn_save = dom.find_by_xpath(btn_xpath)
    btn_save.click()
    close(60)


def __config_request_type(dom: Dom) -> None:
    dd = Dropdown(dom)

    # tipo de la solicitud
    btn_xpath = TacticalRequestsRepository.get_sel_request_type_material_modify()
    li_xpath = TacticalRequestsRepository.get_sel_request_type_material_modify(ElementEnum.LI_XPATH)
    dd.select_by_xpath(btn_xpath, li_xpath)
    sleep(40)

    # activo
    btn_xpath = TacticalRequestsRepository.get_sel_asset()
    li_xpath = TacticalRequestsRepository.get_sel_asset(ElementEnum.LI_XPATH)
    dd.select_by_xpath(btn_xpath, li_xpath)
    sleep(10)


def __requests_details(dom: Dom) -> None:
    dd = Dropdown(dom)

    # motivo de solicitud
    btn_xpath = TacticalRequestsAttributesRepository.get_sel_request_reason()
    li_xpath = TacticalRequestsAttributesRepository.get_sel_request_reason(ElementEnum.LI_XPATH)
    dd.select_by_xpath(btn_xpath, li_xpath)
    sleep(15)

    # fecha
    element_id = TacticalRequestsAttributesRepository.get_id_target_date()
    value = get_ymd_plus()
    el = Element(dom)
    el.set_value(element_id, value)

    # comentarios
    xpath = TacticalRequestsAttributesRepository.get_xpath_comment()
    i = random.randint(1, 10)
    value = f"comment {i}"
    el.set_value_by_xpath(xpath, value)
    sleep(1)

    # prioridad
    btn_xpath = TacticalRequestsAttributesRepository.get_sel_request_priority()
    li_xpath = TacticalRequestsAttributesRepository.get_sel_request_priority(ElementEnum.LI_XPATH)
    dd.select_by_xpath(btn_xpath, li_xpath)
    sleep(15)


def __update_attributes_tab_material_info(dom: Dom) -> None:
    # tab attrubutes -> tab material info
    tab_xpath = TacticalRequestGroupsAttributesRepository.get_tab_attributes()
    btn_tab = dom.find_by_xpath(tab_xpath)
    btn_tab.click()
    sleep(1)

    el = Element(dom)
    btn_xpath = TacticalRequestsAttributesRepository.get_xpath_btn_pais()
    btn_tab = dom.find_by_xpath(btn_xpath)
    btn_tab.click()
    sleep(1)

    btn_xpath = TacticalRequestsAttributesRepository.get_sel_pais()
    li_xpath = TacticalRequestsAttributesRepository.get_sel_pais(ElementEnum.LI_XPATH)
    dd = Dropdown(dom)
    dd.select_by_xpath(btn_xpath, li_xpath)
    sleep(3)


def __update_attributes_tab_optional_data(dom: Dom) -> None:
    # tab diseno
    tab_xpath = TacticalRequestGroupsAttributesRepository.get_tab_datos_opcionales()
    btn_tab = dom.find_by_xpath(tab_xpath)
    btn_tab.click()
    sleep(1)

    el = Element(dom)

    el_xpath = TacticalRequestsAttributesRepository.get_xpath_optional_comment()
    i = random.randint(1, 10)
    value = f"optional commment {i}"
    el.set_value_by_xpath(el_xpath, value)
    sleep(1)


def __create_tags_documentos(dom: Dom) -> None:
    tab_xpath = TacticalRequestGroupsAttributesRepository.get_tab_documentos()
    btn_tab = dom.find_by_xpath(tab_xpath)
    btn_tab.click()
    sleep(1)

    el = Element(dom)

    element_name = TacticalRequestTagsRepository.get_tag_artworks()
    path_file = FilesRepository.get_rnd_artworks()
    el.set_value_by_name(element_name, path_file)
