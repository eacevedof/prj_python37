from time import sleep
from vue.shared.infrastructure.factories.driver_factory import get_chrome, FRONT_URL
from vue.shared.infrastructure.facades.dom import Dom
from vue.login.infrastructure.login_repository import LOGIN_DATA


def login_usr1_or_fail() -> None:
    browser = get_chrome()
    browser.get(FRONT_URL)
    dom = Dom(browser)
    sleep(1)

    input_email = dom.find_by_id("id-email")
    if len(input_email.get_attribute("value")) == 0:
        input_email.send_keys(LOGIN_DATA.get("usr1").get("email"))

    input_password = dom.find_by_id("id-password")
    if len(input_password.get_attribute("value")) == 0:
        input_password.send_keys(LOGIN_DATA.get("usr1").get("secret"))

    submit_button = dom.find_by_id("btnSignIn")
    submit_button.click()
    # sleep(10)

    # div_assets = dom.find_by_id("commons-assets")
    # sleep(1)
