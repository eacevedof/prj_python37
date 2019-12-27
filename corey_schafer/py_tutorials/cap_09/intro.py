# intro.py
print("intro.py")
import sys
# import my_module
from my_module import find_index, test
# otra forma menos recomendada es:
# from my_module import * porque no se puede hace seguimiento de lo que se esta incluyendo

courses = ["History","Math", "Physics", "CompSci"]

search = "Math"
# index = my_module.find_index(courses,search)
index = find_index(courses,search)
print(f"Indes of {search} is: {index}, test var: {test}")

print(sys.path)