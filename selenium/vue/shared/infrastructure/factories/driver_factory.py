import os
from selenium import webdriver
from selenium.webdriver.chrome.service import Service

PATH_DRIVER = os.environ.get("PATHPRJ", "")
FRONT_URL = "http://localhost:3000"
FRONT_URL_HASH = "http://localhost:3000/#"


__webdriver = None


def get_chrome():
    global __webdriver

    if __webdriver:
        return __webdriver

    service = Service(f"{PATH_DRIVER}/chrome-driver-selenium/chromedriver")
    __webdriver = webdriver.Chrome(service=service)
    return __webdriver

