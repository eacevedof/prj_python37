#  pip install textract
from files import *
import textract
from pprint import pprint

text = textract.process(file)
pprint(text)
