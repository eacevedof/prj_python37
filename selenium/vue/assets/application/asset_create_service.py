from time import sleep
from vue.shared.infrastructure.factories.driver_factory import get_chrome, FRONT_URL
from vue.shared.infrastructure.facades.dom import Dom
from vue.assets.infrastructure.asset_repository import ASSETS_CREATION
from vue.login.application.login_service import login_usr1_or_fail


def __login() -> None:
    login_usr1_or_fail()


def asset_create() -> None:
    __login()
    create_url = f"{FRONT_URL}/#/assets/add"
    browser = get_chrome()
    browser.get(create_url)
    sleep(60)


