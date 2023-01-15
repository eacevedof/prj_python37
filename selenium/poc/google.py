# google.py
# https://youtu.be/YLYNThOaP9w?list=PLjM3-neCG6qx4RFeq2X-TpWS_tJTk1qZP
import time
from selenium import webdriver

driver = webdriver.Chrome("chromedriver.exe")
driver.get("http://www.google.com")
time.sleep(2)
# searchbox = driver_factory.py.find_element_by_id("lst-ib")
searchbox = driver.find_element_by_name("q")
searchbox.send_keys("Perú")
