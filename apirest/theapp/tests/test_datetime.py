# theapp/tests/test_datetime.py
import os
from datetime import datetime
from django.test import TestCase


class DatetimeTest(TestCase):
    
    def test_strdate(self):
        strdate = "20190102153348"
        pr(strdate,"strdate")
        objdatetime = datetime.strptime(strdate,'%Y%m%d%H%M%S')#.strftime('%m/%d/%Y')
        print(type(objdatetime))  # datetime.datetime
        # print(dir(objdatetime))
        pr(objdatetime,"objdatetime")
        # pr(type(objdatetime),"type")
        # print(objdatetime)
        
        #  self.assertEqual(1,True)


"""
py manage.py test theapp.tests.test_datetime
"""

