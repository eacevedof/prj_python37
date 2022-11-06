# Import the required Module
import tabula
# Read a PDF File


df = tabula.read_pdf("IPLmatch.pdf", pages='all')[0]
# convert PDF into CSV
tabula.convert_into("IPLmatch.pdf", "iplmatch.csv", output_format="csv", pages='all')
print(df)

