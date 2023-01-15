from time import sleep
from vue.shared.infrastructure.factories.driver_factory import get_chrome, FRONT_URL_HASH, close
from vue.shared.infrastructure.facades.dom import Dom
from vue.shared.infrastructure.facades.dropdown import Dropdown
from vue.shared.infrastructure.facades.element import Element
from vue.assets.infrastructure.asset_repository import ASSETS_CREATION
from vue.login.application.login_service import login_usr1_or_fail


def asset_create_material() -> None:
    login_usr1_or_fail()
    sleep(15)

    create_url = f"{FRONT_URL_HASH}/assets/add"
    browser = get_chrome()
    browser.get(create_url)
    dom = Dom(browser)
    el = Element(dom)
    sleep(3)

    element_id = "id-asset-code"
    value = ASSETS_CREATION.get("mat-1").get(element_id)
    el.set_value(element_id, value)

    element_id = "id-asset-name"
    value = ASSETS_CREATION.get("mat-1").get(element_id)
    el.set_value(element_id, value)

    dd = Dropdown(dom)

    # tipo de asset
    btn_xpath = "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[1]/div/div[2]/div[3]/div/div/div/div[2]/button"
    li_xpath = "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[1]/div/div[2]/div[3]/div/div/div/div[3]/ul/li[1]"
    dd.select_by_xpath(btn_xpath, li_xpath)

    __create_attributes_info(dom)
    __create_attributes_production(dom)
    __create_attributes_diseno(dom)
    __create_attributes_datos_opcionales(dom)

    close(20)


def __create_attributes_info(dom) -> None:
    el = Element(dom)
    element_id = "id-Código Material - Versión"
    value = "xxx11"
    el.set_value(element_id, value)

    dd = Dropdown(dom)

    # categoria
    btn_xpath = "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div/div[1]/div/div[2]/div/div[1]/div/div/div[2]/div/div/div/div[2]/button"
    li_xpath = "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div/div[1]/div/div[2]/div/div[1]/div/div/div[2]/div/div/div/div[3]/ul/li[1]"
    dd.select_by_xpath(btn_xpath, li_xpath)

    # tipo
    btn_xpath = "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div/div[1]/div/div[2]/div/div[1]/div/div/div[3]/div/div/div/div[2]/button"
    li_xpath = "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div/div[1]/div/div[2]/div/div[1]/div/div/div[3]/div/div/div/div[3]/ul/li[1]"
    dd.select_by_xpath(btn_xpath, li_xpath)

    # Forma Farmacéutica
    btn_xpath = "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div/div[1]/div/div[2]/div/div[1]/div/div/div[4]/div/div/div/div[2]/button"
    li_xpath = "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div/div[1]/div/div[2]/div/div[1]/div/div/div[4]/div/div/div/div[3]/ul/li[1]"
    dd.select_by_xpath(btn_xpath, li_xpath)

    element_id = "id-Dosis"
    value = "dosis-1"
    el.set_value(element_id, value)

    element_id = "id-Presentación"
    value = "presentacion-1"
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
    value = "pa-1"
    el.set_value(element_id, value)

    element_id = "id-Nomenclatura Extra"
    value = "nomenclatura-1"
    el.set_value(element_id, value)


def __create_attributes_production(dom) -> None:
    # tab produccion
    tab_xpath = "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div/div[1]/div/div[1]/button[2]"
    btn_tab = dom.find_by_xpath(tab_xpath)
    btn_tab.click()
    sleep(1)

    el = Element(dom)

    element_id = "id-Número de tintas"
    value = 3
    el.set_value(element_id, value)

    element_id = "id-Acabados especiales"
    value = "acab espe 1"
    el.set_value(element_id, value)


def __create_attributes_diseno(dom) -> None:
    # tab diseno
    tab_xpath = "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div/div[1]/div/div[1]/button[3]"
    btn_tab = dom.find_by_xpath(tab_xpath)
    btn_tab.click()
    sleep(1)

    el = Element(dom)

    element_id = "id-LAETUS"
    value = "laetus 1"
    el.set_value(element_id, value)

    dd = Dropdown(dom)

    # marcas visuales
    btn_xpath = "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div/div[1]/div/div[2]/div/div[3]/div/div/div[2]/div/div/div/div[2]/button"
    li_xpath = "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div/div[1]/div/div[2]/div/div[3]/div/div/div[2]/div/div/div/div[3]/ul/li[1]"
    dd.select_by_xpath(btn_xpath, li_xpath)

    element_id = "id-Referencia al libro de estilo"
    value = "ref 1"
    el.set_value(element_id, value)


def __create_attributes_datos_opcionales(dom) -> None:
    tab_xpath = "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[2]/div/div[1]/div/div[1]/button[4]"
    btn_tab = dom.find_by_xpath(tab_xpath)
    btn_tab.click()
    sleep(1)

    el = Element(dom)

    element_id = "id-Comentarios Opcionales de Material"
    value = "comentarios opcionales xxx"
    el.set_value(element_id, value)
