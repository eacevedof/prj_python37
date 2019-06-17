# dropdown.py
# https://youtu.be/lB9pypRYev4?list=PLjM3-neCG6qx4RFeq2X-TpWS_tJTk1qZP&t=88
import time
from selenium import webdriver
from selenium.webdriver.support.ui import Select
driver = webdriver.Chrome("chromedriver.exe")
driver.get("http://newtours.demoaut.com")
time.sleep(1)
driver.find_element_by_link_text("REGISTER").click()
countryDropDown = Select(driver.find_element_by_name("country"))
countryDropDown.select_by_index(5)
countryDropDown.select_by_value("11") #bahamas
countryDropDown.select_by_visible_text("CONGO")
time.sleep(5)
driver.quit()

