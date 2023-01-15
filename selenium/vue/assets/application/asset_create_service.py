from time import sleep
from vue.shared.infrastructure.factories.driver_factory import get_chrome, FRONT_URL_HASH, close
from vue.shared.infrastructure.facades.dom import Dom
from vue.assets.infrastructure.asset_repository import ASSETS_CREATION
from vue.login.application.login_service import login_usr1_or_fail


def asset_create_material() -> None:
    login_usr1_or_fail()

    create_url = f"{FRONT_URL_HASH}/assets/add"
    browser = get_chrome()
    browser.get(create_url)
    dom = Dom(browser)
    sleep(2)

    element_id = "id-asset-code"
    input_code = dom.find_by_id(element_id)
    input_code.send_keys(ASSETS_CREATION.get("mat-1").get(element_id))

    element_id = "id-asset-name"
    input_code = dom.find_by_id(element_id)
    input_code.send_keys(ASSETS_CREATION.get("mat-1").get(element_id))

    element_id = "id-assetTypes"
    #input_code = dom.find_by_id(element_id)
    #input_code.send_keys(ASSETS_CREATION.get("mat-1").get(element_id))


    close(120)


