import time
from vue.shared.infrastructure.factories.driver_factory import get_chrome, FRONT_URL
from vue.login.infrastructure.login_repository import LOGIN_DATA
from selenium.webdriver.common.by import By


def login_javi_or_fail() -> None:
    browser = get_chrome()
    browser.get(FRONT_URL)
    time.sleep(2)

    input_email = browser.find_element(By.ID, "id-email")
    input_email.send_keys(LOGIN_DATA.get("javi").get("email"))

    input_password = browser.find_element(By.ID, "id-password")
    input_password.send_keys(LOGIN_DATA.get("javi").get("secret"))

    submit_button = browser.find_element(By.ID, "btnSignIn")
    if not submit_button:
        raise Exception("No submit button")
    submit_button.click()
