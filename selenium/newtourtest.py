# newtourtest.py
# https://youtu.be/k3eq4RnVCDQ?list=PLjM3-neCG6qx4RFeq2X-TpWS_tJTk1qZP

import time
import unittest
from selenium import webdriver
from selenium.webdriver.support.ui import Select

class NewTours(unittest.TestCase):

    def setup(self):
        self.driver = webdriver.Chrome("chromedriver.exe")
        self.driver.get("http://newtours.demoaut.com")
        time.sleep(1)

    def test_dropdown(self):
        self.driver.find_element_by_link_text("REGISTER").click()
        countryDropDown = Select(driver.find_element_by_name("country"))
        countryDropDown.select_by_index(5)
        countryDropDown.select_by_value("11") #bahamas
        countryDropDown.select_by_visible_text("CONGO") 
        self.assertEquals(countryDropDown.first_selected_option.text.strip(),"CONGO")      

    def teardown(self):
        self.driver.quit()

if __name__ == '__main__':
    unittest.main()        
