# asserts.py
# https://youtu.be/sZqxadW_E6o?list=PLjM3-neCG6qx4RFeq2X-TpWS_tJTk1qZP

import time
from selenium import webdriver

driver = webdriver.Chrome("chromedriver.exe")
driver.get("http://newtours.demoaut.com")
time.sleep(1)
# user_box = driver.find_element_by_name("userName")
user_box = driver.find_element_by_xpath("/html/body/div[1]/table/tbody/tr/td[2]/table/tbody/tr[4]/td/table/tbody/tr/td[2]/table/tbody/tr[2]/td[3]/form/table/tbody/tr[4]/td/table/tbody/tr[2]/td[2]/input")
# pass_box = driver.find_element_by_name("password")
pass_box = driver.find_element_by_xpath("/html/body/div[1]/table/tbody/tr/td[2]/table/tbody/tr[4]/td/table/tbody/tr/td[2]/table/tbody/tr[2]/td[3]/form/table/tbody/tr[4]/td/table/tbody/tr[3]/td[2]/input")
submit_button = driver.find_element_by_name("login")
user_box.send_keys("test")
pass_box.send_keys("test")
submit_button.click()
time.sleep(1)
link_registration_form = driver.find_element_by_link_text("registration form")
assert link_registration_form.text == "registration form"
assert link_registration_form.tag_name == "p"
driver.quit()