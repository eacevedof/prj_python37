import os
from selenium import webdriver
from selenium.webdriver.chrome.service import Service

PATH_DRIVER = os.environ.get("PATHPRJ", "")
FRONT_URL = "http://localhost:3000"


def get_chrome():
    service = Service(f"{PATH_DRIVER}/chrome-driver-selenium/chromedriver")
    return webdriver.Chrome(service=service)
