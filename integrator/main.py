print("main.py")
from etls.gsheet_mysql import extract, transform, load


print("...extracting \n")
data = extract()
print(data)

# print("...transform process \n")
# transform(data)
# print("...loading")
# load(data)
# print("end")

