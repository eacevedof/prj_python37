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
    btn_xpath = "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[1]/div/div[2]/div[3]/div/div/div/div[2]/button"
    li_xpath = "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[1]/div/div[2]/div[3]/div/div/div/div[3]/ul/li[1]"
    dd.select_by_xpath(btn_xpath, li_xpath)

    __create_attributes_info(el)
    close(20)


def __create_attributes_info(el:Element) -> None:
    element_id = "id-Código Material - Versión"
    value = "xxx11"
    el.set_value(element_id, value)