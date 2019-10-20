print("component_request.py")

from apis.components import *


class ComponentRequest:
  
  def __init__(self):
    pass

  def run(self):
    strcontent = get_content("./config/.env")
    print(strcontent)

if __name__=="__main__":
  o = ComponentRequest()
  o.run()
