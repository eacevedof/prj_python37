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