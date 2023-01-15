from dataclasses import dataclass
from selenium.webdriver.common.by import By

@dataclass
class Element:
    __browser: object

    def __int__(self, browser=None):
        self.__browser = browser

    def set_value(self, element_id: str, value: str) -> None:
        if not self.__browser:
            return None

        input_element = self.__browser.find_element(By.ID, element_id)
        input_element.send_keys(value)

    @staticmethod
    def set_value_in_input(input_element:object, value: str) -> None:
        input_element.send_keys(value)