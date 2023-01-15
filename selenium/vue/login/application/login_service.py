from time import sleep
from vue.shared.infrastructure.factories.driver_factory import get_chrome, FRONT_URL
from vue.login.infrastructure.login_repository import LOGIN_DATA
from vue.login.domain.exceptions.login_exception import LoginException
from selenium.webdriver.common.by import By


def login_usr1_or_fail() -> None:
    browser = get_chrome()
    browser.get(FRONT_URL)
    sleep(2)

    input_email = browser.find_element(By.ID, "id-email")
    if not input_email:
        LoginException.fail_if_no_input("no id:id-mail")
    input_email.send_keys(LOGIN_DATA.get("usr1").get("email"))

    input_password = browser.find_element(By.ID, "id-password")
    if not input_password:
        LoginException.fail_if_no_input("no id:id-password")
    input_password.send_keys(LOGIN_DATA.get("usr1").get("secret"))

    submit_button = browser.find_element(By.ID, "btnSignIn")
    if not submit_button:
        LoginException.fail_if_no_button("no id:btnSignIn")
    submit_button.click()
    sleep(25)

    div_assets = browser.find_element(By.ID, "commons-assetsk")
    if not div_assets:
        LoginException.fail_if_not_logged("not logged")
    sleep(120)
