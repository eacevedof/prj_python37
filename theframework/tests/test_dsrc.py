"""
@file: test_dsrc
sobre los test: https://realpython.com/python-testing/#unit-tests-vs-integration-tests
sobre el import: https://stackoverflow.com/questions/30669474/beyond-top-level-package-error-in-relative-import
"""
import sys; sys.path.append("..")
import unittest

from dsources.dsrc import Dsrc	

class  TestDsrc(unittest.TestCase):	

    def test_get_config(self):
        text = Dsrc.get_config()
        print("hola",text)	
        assert isinstance(text,str)
        #self.assertEqual(x, y, "Msg");	       
        #self.fail("TODO: Write test")


if __name__ == "__main__":
    unittest.main()
    print("Everything passed")        