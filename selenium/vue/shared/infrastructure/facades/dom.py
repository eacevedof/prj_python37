from dataclasses import dataclass
from selenium.webdriver.common.by import By


@dataclass
class Dom:
    __browser: object

    def __int__(self, browser):
        self.__browser = browser

    def find_by_id(self, element_id: str) -> object:
        return self.__browser.find_element(By.ID, element_id)

    def find_by_xpath(self, xpath: str) -> object:
        return self.__browser.find_element(By.XPATH, xpath)
