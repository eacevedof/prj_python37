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
    # fname = os.path.splitext(os.path.basename(path))[0]
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

def merge():
    input_paths = []
    scanned = os.scandir(dir_splitted)
    for item in scanned:
        if item.is_file():
            input_paths.append(f"{dir_splitted}/{item.name}")

    input_paths.sort()
    # pprint(input_paths)
    pdf_writer = PdfFileWriter()
    for path in input_paths:
        pdf_reader = PdfFileReader(path)
        for page in range(pdf_reader.getNumPages()):
            pdf_writer.addPage(pdf_reader.getPage(page))

    with open(file_merged, "wb") as fh:
        pdf_writer.write(fh)

# pdf_splitter(file)
#merge()

def get_text():
    reader = PdfFileReader(file_merged)
    texts = []
    for i_page in range(reader.getNumPages()):
        page = reader.pages[i_page]
        texts.append(page.extract_text())

    print(texts[2])

get_text()
