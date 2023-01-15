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
time.sleep(5)


user_box = objdriver.find_element(By.ID,"id-email")
user_box.send_keys("test")
#pass_box.send_keys("test")
#submit_button.click()
time.sleep(5)
objdriver.quit()