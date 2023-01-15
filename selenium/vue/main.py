# VUE/main.py
import time
from driver import get_chrome
from selenium.webdriver.common.by import By

browser = get_chrome()
browser.get("http://localhost:3000")
time.sleep(2)

input_email = browser.find_element(By.ID, "id-email")
input_email.send_keys("email_test1@lacia.com")

input_password = browser.find_element(By.ID, "id-password")
input_password.send_keys("123456")

submit_button = browser.find_element(By.ID, "btnSignIn")
if not submit_button:
    raise Exception("No submit button")
submit_button.click()

time.sleep(120)
#browser.quit()
print("end :)")