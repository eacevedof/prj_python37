import time
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from vue.shared.infrastructure.facades.env import *

PATH_DRIVER = getenv(ENV_PATHPRJ)
FRONT_URL = "http://localhost:3000"
FRONT_URL = getenv(ENV_PRE_URL, getenv(ENV_DEV_URL, FRONT_URL))

FRONT_URL_HASH = f"{FRONT_URL}/#"

__webdriver = None


def get_chrome():
    global __webdriver

    if __webdriver:
        return __webdriver

    options = webdriver.ChromeOptions()
    options.add_argument("--auto-open-devtools-for-tabs")
    options.add_argument("--detach-devtools-docked-at-startup")
    # deshabilita validación cors
    options.add_argument("--disable-web-security")
    options.add_argument("start-maximized")
    #options.add_argument("--disable-blink-features=AutomationControlled")

    service = Service(f"{PATH_DRIVER}/chrome-driver-selenium/chromedriver")
    __webdriver = webdriver.Chrome(service=service, options=options)
    #__webdriver.execute_cdp_cmd("Page.setDevToolsFlattened", {"devtoolsFlattened": True})
    __webdriver.execute_script("""
    async function openDevTools() {
        const {Runtime} = await import('chrome-devtools-frontend/front_end/common/Runtime.js');
        await Runtime.evaluate({expression: `inspect(window.open())`});
    }
    openDevTools();
""")
    return __webdriver


def close(sleep: int = 0):
    time.sleep(sleep)
    global __webdriver
    if __webdriver:
        __webdriver.quit()
        __webdriver = None
