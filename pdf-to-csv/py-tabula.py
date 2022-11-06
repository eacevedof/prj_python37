# pip uninstall tabula; install tabula-py

from files import *
import tabula
import sys
from pprint import pprint
# Read a PDF File
#file = f"./PROYECTO-BASICO-Y-DE-EJECUCION-EL-CASAR-19.10.22.pdf"
#file_to = f"./proyecto.csv"

#df = tabula.read_pdf(file, pages=[639,650])[0]
#df = tabula.read_pdf(file, options="--columns 0,1,2,3,4,5,6,7,8,9", pages=[639])[0]

# area (top,left,bottom,right)
#df = tabula.read_pdf(file, lattice=True,pages=[639])
df = tabula.read_pdf(file, stream=True, pages=[639, 640])
pprint(df); sys.exit()

# convert PDF into CSV
tabula.convert_into(file, file_to, output_format="csv", pages=[639])
#tabula.convert_into(file, file_to, output_format="csv",  pages=[600])
