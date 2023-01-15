from time import sleep
from vue.shared.infrastructure.factories.driver_factory import get_chrome, FRONT_URL
from vue.assets.infrastructure.asset_repository import ASSETS_CREATION
from selenium.webdriver.common.by import By


def asset_create() -> None:
    browser = get_chrome()
    browser.get(FRONT_URL)
    sleep(2)

    input_email = browser.find_element(By.ID, "id-email")
    input_email.send_keys(LOGIN_DATA.get("usr1").get("email"))

    input_password = browser.find_element(By.ID, "id-password")
    input_password.send_keys(LOGIN_DATA.get("usr1").get("secret"))

    submit_button = browser.find_element(By.ID, "btnSignIn")
    submit_button.click()
    sleep(25)

    div_assets = browser.find_element(By.ID, "commons-assets")
    sleep(1)
