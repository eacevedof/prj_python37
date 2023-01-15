# newtourtest.py
# https://youtu.be/k3eq4RnVCDQ?list=PLjM3-neCG6qx4RFeq2X-TpWS_tJTk1qZP

import time
import unittest
from selenium import webdriver
from selenium.webdriver.support.ui import Select
from pageindex import PageIndex

class NewTours(unittest.TestCase):

    def setUp(self):
        self.driver = webdriver.Chrome("chromedriver.exe")
        self.driver.get("http://newtours.demoaut.com")
        self.page_index = PageIndex(self.driver)
        time.sleep(1)

    def test_dropdown(self):
        self.driver.find_element_by_link_text("REGISTER").click()
        countryDropDown = Select(self.driver.find_element_by_name("country"))
        countryDropDown.select_by_index(5)
        countryDropDown.select_by_value("11") #bahamas
        countryDropDown.select_by_visible_text("CONGO") 
        # self.assertEquals(countryDropDown.first_selected_option.text.strip(),"CONGO")
        self.assertTrue(countryDropDown.first_selected_option.text.strip() == "CONGO")    
        self.assertFalse(countryDropDown.first_selected_option.text.strip() == "ARGENTINA")

    def test_register(self):
        self.page_index.login("test","test")
        link_registration_form = self.driver.find_element_by_link_text("registration form")
        self.assertEquals(link_registration_form.text,"registration form")


    def teardown(self):
        self.driver.quit()


if __name__ == '__main__':
    unittest.main()        
