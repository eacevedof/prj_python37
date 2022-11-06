#  pip install textract
from files import *
import textract
from pprint import pprint

text = textract.process(file_merged)
pprint(str(text,"utf-8"))
