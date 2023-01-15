from dataclasses import dataclass
from time import sleep
from vue.shared.infrastructure.facades.dom import Dom


@dataclass
class Dropdown:
    __dom: Dom

    def __int__(self, dom: Dom):
        self.__dom = dom

    def select_by_xpath(self, btn_xpath: str, li_xpath: str) -> None:
        if not self.__dom:
            return None

        btn_dropdown = self.__dom.find_by_xpath(btn_xpath)
        btn_dropdown.click()
        sleep(1)

        li_material = self.__dom.find_by_xpath(li_xpath)
        li_material.click()
        sleep(1)
