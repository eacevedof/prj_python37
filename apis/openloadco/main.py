import os
import sys
import time

from pprint import pprint
from components.component_file import *
from components.component_request import ComponentRequest
from components.component_dirs import ComponentDirs
from dotenv import load_dotenv

def die(variable=None):
  if variable is not None:
    pprint(variable)
  sys.exit()
# die

if __name__=="__main__":
  pathenvfile = os.path.dirname(os.path.abspath(__file__))+"/config/.env"
  pathenvfile = os.path.realpath(pathenvfile)
  # print(pathenvfile)
  load_dotenv(pathenvfile)

  login = os.getenv("API_USERNAME")
  key = os.getenv("API_PASSWORD")

  objdir = ComponentDirs()
  objdir.get_folder_content()
  die()

  objreq = ComponentRequest(login,key)
  objdict = objreq.get_folder_list()
  folders = objdict["result"]["folders"]
  pprint(folders)

  for dic in folders:
    foldername = dic["name"]
    print(foldername)

    if dic["name"].find(".")==True:
      continue
    
    folderid = dic["id"]
    dicfolder = objreq.get_folder_content(folderid)
    if dic["name"] == "gstring":
      pprint(dicfolder)
      sys.exit()
    
  
  objreq.upload(
    "C:\\Users\\ioedu\\Desktop\\temp.html",
    "8306116",
  )
  objreq.get_account_info()
  #print(objreq)