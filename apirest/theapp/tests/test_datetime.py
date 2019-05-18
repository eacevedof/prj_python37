# theapp/tests/test_datetime.py
import os
from datetime import datetime
from pytz import timezone

from django.test import TestCase

class DatetimeTest(TestCase):
    # https://www.saltycrane.com/blog/2009/05/converting-time-zones-datetime-objects-python/

    strdate = "20190102153348"

    def test_strdate(self):
        strdate = self.strdate
        sc("test_strdate:")
        pr(strdate,"strdate")
        objdatetime = datetime.strptime(strdate,'%Y%m%d%H%M%S')#.strftime('%m/%d/%Y')
        prtype(objdatetime)  # datetime.datetime
        # print(dir(objdatetime))
        bug(objdatetime,"objdatetime")
        # pr(type(objdatetime),"type")
        # print(objdatetime)
        strdatetime = datetime.strptime(strdate,'%Y%m%d%H%M%S').strftime('%Y-%m-%d %H:%M:%S')
        pr(strdatetime)
        #  self.assertEqual(1,True)

    def test_tzinfo(self):
        sc("test_tzinfo:")
        obj = datetime.tzinfo
        pr(obj,"datetime.tzinfo")
        strdate = self.strdate
        objdatetime = datetime.strptime(strdate,'%Y%m%d%H%M%S')
        objdatetimeutc = timezone('UTC').localize(objdatetime)
        bug(objdatetimeutc,"objdatetimeutc")    
    
    def test_tzinfo2(self):
        # https://stackoverflow.com/questions/79797/how-to-convert-local-time-string-to-utc
        # import pytz, datetime
        local = pytz.timezone ("America/Los_Angeles")
        naive = datetime.datetime.strptime ("2001-2-3 10:11:12", "%Y-%m-%d %H:%M:%S")
        local_dt = local.localize(naive, is_dst=None)
        utc_dt = local_dt.astimezone(pytz.utc)
        utc_dt.strftime ("%Y-%m-%d %H:%M:%S")

"""
py manage.py test theapp.tests.test_datetime
"""

