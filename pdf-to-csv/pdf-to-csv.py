# Import the required Module
import tabula
# Read a PDF File
file = f"./PROYECTO-BASICO-Y-DE-EJECUCION-EL-CASAR-19.10.22.pdf"
file_to = f"./proyecto.csv"

df = tabula.read_pdf(file, pages=[639,650])[0]
# convert PDF into CSV
tabula.convert_into(file, file_to, output_format="csv", pages=[639,650])

print(df)

