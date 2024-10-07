from config import PATH_UPLOAD_FOLDER
from PyPDF2 import PdfReader

import os


PATH_UPLOAD_FOLDER = os.path.realpath(PATH_UPLOAD_FOLDER)
FILE_PDF_NAME = "boe-constitucion-espanola.pdf"
PATH_FILE = f"{PATH_UPLOAD_FOLDER}/{FILE_PDF_NAME}"


def get_text_from_pdf_file(path_file: str) -> str:
    if not os.path.isfile(path_file):
        raise FileNotFoundError(f"the file {path_file} does not exist.")

    pdf_stream = open(path_file, "rb")
    pdf_reader = PdfReader(pdf_stream)

    text = ""
    for page in pdf_reader.pages:
        text += page.extract_text()

    pdf_stream.close()
    return text

