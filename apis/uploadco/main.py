import os
import sys

from pprint import pprint
from components.component_file import *
from components.component_request import ComponentRequest
from dotenv import load_dotenv

if __name__=="__main__":
  pathenvfile = os.path.dirname(os.path.abspath(__file__))+"/config/.env"
  pathenvfile = os.path.realpath(pathenvfile)
  # print(pathenvfile)
  load_dotenv(pathenvfile)

  login = os.getenv("API_USERNAME")
  key = os.getenv("API_PASSWORD")

  objreq = ComponentRequest(login,key)
  objreq.get_list_folder()
  # objreq.get_folder_content("8348096")
  objreq.upload(
    "C:\\Users\\ioedu\\Desktop\\temp.html",
    "8306116",
  )

  #print(objreq)