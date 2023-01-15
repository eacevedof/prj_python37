# VUE/login_data.py
import time
from vue.boot.driver import get_chrome, FRONT_URL
from selenium.webdriver.common.by import By
from vue.login.infrastructure.login_controller import LOGIN_DATA

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