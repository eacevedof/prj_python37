# pip install PyPDF2
from files import *
from pprint import pprint
from PyPDF2 import PdfReader

reader = PdfReader(file)
page = reader.pages[639]
pprint(page.extractText())
