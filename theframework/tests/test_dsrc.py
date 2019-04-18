"""
@file: test_dsrc
sobre los test: https://realpython.com/python-testing/#unit-tests-vs-integration-tests
sobre el import: https://stackoverflow.com/questions/30669474/beyond-top-level-package-error-in-relative-import
"""
import sys; sys.path.append("..")

import unittest
from pprint import pprint

from dsources.dsrc import Dsrc	

class  TestDsrc(unittest.TestCase):	

    def test_get_config(self):
        mx_var = Dsrc.get_config()
        pprint(mx_var)
        assert isinstance(mx_var,str)
        #self.assertEqual(x, y, "Msg");	       
        #self.fail("TODO: Write test")


if __name__ == "__main__":
    unittest.main()
    print("Everything passed")        