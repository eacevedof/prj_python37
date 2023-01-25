from time import sleep
from vue.shared.infrastructure.facades.env import *
from vue.shared.infrastructure.factories.driver_factory import get_chrome, FRONT_URL_HASH, close
from vue.shared.infrastructure.facades.dom import Dom
from vue.shared.infrastructure.facades.dropdown import Dropdown
from vue.shared.infrastructure.facades.element import Element
from vue.oco.login.application.login_service import login_usr1_or_fail
from vue.shared.infrastructure.generators.uuid import get_uuid
from vue.oco.assets.infrastructure.asset_repository import AssetRepository
from vue.shared.domain.element_enum import ElementEnum
import random


def asset_create_material() -> None:
    login_usr1_or_fail()
    sleep(30)

    create_url = f"{FRONT_URL_HASH}/assets/add"
    browser = get_chrome()
    browser.get(create_url)
    dom = Dom(browser)
    el = Element(dom)
    sleep(3)

    element_id = AssetRepository.get_id_asset_code()
    uuid = get_uuid(4)
    value = f"mat-{uuid}"
    el.set_value(element_id, value)

    element_id = AssetRepository.get_id_asset_name()
    value = f"mat-{uuid}"
    el.set_value(element_id, value)

    dd = Dropdown(dom)

    # tipo de asset
    btn_xpath = AssetRepository.get_sel_id_asset_type()
    li_xpath = AssetRepository.get_sel_asset_type(ElementEnum.LI_XPATH)
    dd.select_by_xpath(btn_xpath, li_xpath)

    __create_attributes_info(dom)
    __create_attributes_production(dom)
    __create_attributes_diseno(dom)
    __create_attributes_datos_opcionales(dom)

    __create_tags_documentos(dom)

    btn_id = AssetRepository.get_id_button_save()
    btn_save = dom.find_by_id(btn_id)
    btn_save.click()
    close(20)


def __create_attributes_info(dom: Dom) -> None:
    el = Element(dom)
    element_id = AssetRepository.get_id_material_code()
    uuid = get_uuid(4)
    value = f"mat-{uuid}"
    el.set_value(element_id, value)

    dd = Dropdown(dom)

    # categoria
    btn_xpath = AssetRepository.get_sel_category()
    li_xpath = AssetRepository.get_sel_category(ElementEnum.LI_XPATH)
    dd.select_by_xpath(btn_xpath, li_xpath)

    # tipo
    btn_xpath = AssetRepository.get_sel_type()
    li_xpath = AssetRepository.get_sel_type(ElementEnum.LI_XPATH)
    dd.select_by_xpath(btn_xpath, li_xpath)

    # Forma Farmacéutica
    btn_xpath = "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div/div[1]/div/div[2]/div/div[1]/div/div/div[4]/div/div/div/div[2]/button"
    li_xpath = "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div/div[1]/div/div[2]/div/div[1]/div/div/div[4]/div/div/div/div[3]/ul/li[1]"
    dd.select_by_xpath(btn_xpath, li_xpath)

    element_id = "id-Dosis"
    value = f"dosis-{uuid}"
    el.set_value(element_id, value)

    element_id = "id-Presentación"
    value = f"presentacion-{uuid}"
    el.set_value(element_id, value)

    # Mercado
    btn_xpath = "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div/div[1]/div/div[2]/div/div[1]/div/div/div[7]/div/div/div/div[2]/button"
    li_xpath = "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div/div[1]/div/div[2]/div/div[1]/div/div/div[7]/div/div/div/div[3]/ul/li[2]"
    dd.select_by_xpath(btn_xpath, li_xpath)

    # Cliente
    btn_xpath = "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div/div[1]/div/div[2]/div/div[1]/div/div/div[8]/div/div/div/div[2]/button"
    li_xpath = "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div/div[1]/div/div[2]/div/div[1]/div/div/div[8]/div/div/div/div[3]/ul/li[1]"
    dd.select_by_xpath(btn_xpath, li_xpath)

    # País
    btn_xpath = "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div/div[1]/div/div[2]/div/div[1]/div/div/div[9]/div/div/div/div[2]/button"
    li_xpath = "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div/div[1]/div/div[2]/div/div[1]/div/div/div[9]/div/div/div/div[3]/ul/li[3]"
    dd.select_by_xpath(btn_xpath, li_xpath)

    # Fabricante
    btn_xpath = "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div/div[1]/div/div[2]/div/div[1]/div/div/div[10]/div/div/div/div[2]/button"
    li_xpath = "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div/div[1]/div/div[2]/div/div[1]/div/div/div[10]/div/div/div/div[3]/ul/li[1]"
    dd.select_by_xpath(btn_xpath, li_xpath)

    element_id = "id-Principio Activo"
    value = f"pa-{uuid}"
    el.set_value(element_id, value)

    element_id = "id-Nomenclatura Extra"
    value = f"nomenclatura-{uuid}"
    el.set_value(element_id, value)


def __create_attributes_production(dom: Dom) -> None:
    # tab produccion
    tab_xpath = "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div/div[1]/div/div[1]/button[2]"
    btn_tab = dom.find_by_xpath(tab_xpath)
    btn_tab.click()
    sleep(1)

    el = Element(dom)

    element_id = "id-Número de tintas"
    value = random.randint(1, 10)
    el.set_value(element_id, value)

    element_id = "id-Acabados especiales"
    i = random.randint(1, 10)
    value = f"acab espe {i}"
    el.set_value(element_id, value)


def __create_attributes_diseno(dom: Dom) -> None:
    # tab diseno
    tab_xpath = "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div/div[1]/div/div[1]/button[3]"
    btn_tab = dom.find_by_xpath(tab_xpath)
    btn_tab.click()
    sleep(1)

    el = Element(dom)

    element_id = "id-LAETUS"
    i = random.randint(1, 10)
    value = f"laetus {i}"
    el.set_value(element_id, value)

    dd = Dropdown(dom)

    # marcas visuales
    btn_xpath = "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div/div[1]/div/div[2]/div/div[3]/div/div/div[2]/div/div/div/div[2]/button"
    li_xpath = "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div/div[1]/div/div[2]/div/div[3]/div/div/div[2]/div/div/div/div[3]/ul/li[1]"
    dd.select_by_xpath(btn_xpath, li_xpath)

    element_id = "id-Referencia al libro de estilo"
    i = random.randint(1, 10)
    value = f"ref {i}"
    el.set_value(element_id, value)


def __create_attributes_datos_opcionales(dom: Dom) -> None:
    tab_xpath = "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div/div[1]/div/div[1]/button[4]"
    btn_tab = dom.find_by_xpath(tab_xpath)
    btn_tab.click()
    sleep(1)

    el = Element(dom)

    element_id = "id-Comentarios Opcionales de Material"
    uuid = get_uuid(4)
    value = f"comentarios opcionales {uuid}"
    el.set_value(element_id, value)


def __create_tags_documentos(dom: Dom) -> None:
    tab_xpath = "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/ul/li[2]"
    btn_tab = dom.find_by_xpath(tab_xpath)
    btn_tab.click()
    sleep(1)

    el = Element(dom)

    element_name = "Artworks"
    home = getenv(ENV_HOME)
    path_file = f"{home}/Desktop/assets-1/mat-arch-opcionales-2-de-n.jpg"
    el.set_value_by_name(element_name, path_file)
