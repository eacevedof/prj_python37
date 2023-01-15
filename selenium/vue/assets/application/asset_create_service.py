from time import sleep
from vue.shared.infrastructure.factories.driver_factory import get_chrome, FRONT_URL_HASH, close
from vue.shared.infrastructure.facades.dom import Dom
from vue.shared.infrastructure.facades.element import Element
from vue.assets.infrastructure.asset_repository import ASSETS_CREATION
from vue.login.application.login_service import login_usr1_or_fail


def asset_create_material() -> None:
    login_usr1_or_fail()

    create_url = f"{FRONT_URL_HASH}/assets/add"
    browser = get_chrome()
    browser.get(create_url)
    dom = Dom(browser)
    sleep(5)

    element_id = "id-asset-code"
    input_code = dom.find_by_id(element_id)
    input_code.send_keys(ASSETS_CREATION.get("mat-1").get(element_id))

    element_id = "id-asset-name"
    input_code = dom.find_by_id(element_id)
    input_code.send_keys(ASSETS_CREATION.get("mat-1").get(element_id))

    xpath = "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[1]/div/div[2]/div[3]/div/div/div/div[2]/button"
    btn_dropdown = dom.find_by_xpath(xpath)
    btn_dropdown.click()
    # element_id = "id-assetTypes"
    sleep(1)

    xpath = "/html/body/div[1]/main/div/div[1]/div[3]/section/div[2]/div/div[1]/div/div[2]/div[3]/div/div/div/div[3]/ul/li[1]"
    li_material = dom.find_by_xpath(xpath)
    li_material.click()
    ##input_code.send_keys(ASSETS_CREATION.get("mat-1").get(element_id))
    #  driver.findElement(By.name("country-1")).click()

    __create_attributes_info(dom)
    close(60)


def __create_attributes_info(dom:Dom):
    el = Element()
    element_id = "id-Código Material - Versión"
    input_text = dom.find_by_id(element_id)
    el.set_value_in_input(input_text, "matxxx")

