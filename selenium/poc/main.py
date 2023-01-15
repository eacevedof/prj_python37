# main.py
import time
from selenium import webdriver
from selenium.webdriver.chrome.service import Service

#objdriver = webdriver.Chrome("chromedriver.exe")
service = Service("path-to-my-driver.py")
objdriver = webdriver.Chrome(service=service)
objdriver.get("http://localhost:3000")
time.sleep(5)
user_box = objdriver.find_element_by_name("userName")
pass_box = objdriver.find_element_by_name("password")
submit_button = objdriver.find_element_by_name("login")
user_box.send_keys("test")
pass_box.send_keys("test")
submit_button.click()
time.sleep(5)
objdriver.quit()