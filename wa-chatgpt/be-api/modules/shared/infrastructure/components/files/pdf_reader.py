import os
from PyPDF2 import PdfReader


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

