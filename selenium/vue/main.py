# VUE/main.py
import time
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.common.by import By
import os

PATH_DRIVER = os.environ.get("PATHPRJ","")

service = Service(f"{PATH_DRIVER}/chrome-driver-selenium/chromedriver")
objdriver = webdriver.Chrome(service=service)
objdriver.get("http://localhost:3000")
time.sleep(2)
input_email = objdriver.find_element(By.ID,"id-email")
input_email.send_keys("email_test1@lacia.com")

input_password = objdriver.find_element(By.ID,"id-password")
input_password.send_keys("123456")

submit_button = objdriver.find_element(By.ID, "btnSignIn")
if not submit_button:
    raise Exception("No submit button")
submit_button.click()
time.sleep(60)
#objdriver.quit()
print("end :)")