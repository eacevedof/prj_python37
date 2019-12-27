# intro.py
print("intro.py")
import my_module

courses = ["History","Math", "Physics", "CompSci"]

search = "Math"
index = my_module.find_index(courses,search)
print(f"Indes of {search} is: {index}")