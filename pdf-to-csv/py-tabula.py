# pip uninstall tabula; install tabula-py

from files import *
from tabula import read_pdf, convert_into
import sys
from pprint import pprint
import csv
# Read a PDF File
#file = f"./PROYECTO-BASICO-Y-DE-EJECUCION-EL-CASAR-19.10.22.pdf"
#file_to = f"./proyecto.csv"

#df = tabula.read_pdf(file, pages=[639,650])[0]
#df = tabula.read_pdf(file, options="--columns 0,1,2,3,4,5,6,7,8,9", pages=[639])[0]

# area (top,left,bottom,right)
#df = tabula.read_pdf(file, lattice=True,pages=[639])
# df = tabula.read_pdf(file, stream=True, pages=[639, 640])
df = read_pdf(
    file_merged,
    guess=False,
    pages = 1,
    stream=True,
    encoding="utf-8",
    area = (96,24,558,750),
    # output_format="json",
    columns = (95, 95+76, 95+318, 95+346, 95+395,95+494,95+574,95+639)
)

#f = open(file_to, "w")
#writer = csv.writer(f)
#writer.writerows(df[0])
#f.close()
#pprint(df[0]); sys.exit()

# convert PDF into CSV
#tabula.convert_into(file, file_to, output_format="json", pages=[639])
convert_into(
    file_merged,
    file_to,
    output_format="tsv",
    pages=[1,2],
    columns = (95, 95+76, 95+318, 95+346, 95+395,95+494,95+574,95+639)
)

