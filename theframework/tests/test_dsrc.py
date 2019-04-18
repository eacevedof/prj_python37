import sys; sys.path.append("..")
import unittest

from dsources.dsrc import Dsrc	
class  TestDsrc(unittest.TestCase):	

     def test_test_context(self):
        text = Dsrc.get_config()	
        print(text)	
        #assert x != y;
        #self.assertEqual(x, y, "Msg");	       
        self.fail("TODO: Write test")