# pip install PyPDF2
from files import *
from pprint import pprint
from PyPDF2 import PdfReader
from PyPDF2 import PdfFileReader, PdfFileWriter
import os

#reader = PdfReader(file)
#page = reader.pages[639]
#pprint(page.extractText())


def pdf_splitter(path):
    fname = os.path.splitext(os.path.basename(path))[0]
    pdf = PdfFileReader(path)
    for page in range(pdf.getNumPages()):
        if page<638:
            continue
        pdf_writer = PdfFileWriter()
        pdf_writer.addPage(pdf.getPage(page))
        output_filename = f"./splitted/page_{page+1}.pdf"
        with open(output_filename, "wb") as out:
            pdf_writer.write(out)
        print("Created: {}".format(output_filename))

pdf_splitter(file)
