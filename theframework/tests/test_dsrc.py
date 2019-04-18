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
        print("test_get_config",text)	
        assert isinstance(text,str)
        #self.assertEqual(x, y, "Msg");	       
        #self.fail("TODO: Write test")
        
    def test_loadjson(self):
        text = Dsrc.load_config()
        print("test_loadjson: ",text)
        assert isinstance(text,str)


if __name__ == "__main__":
    unittest.main()
    print("Everything passed")        