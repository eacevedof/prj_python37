import os
import sys
import time

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
  objdict = objreq.get_folder_list()
  folders = objdict["result"]["folders"]
  pprint(folders)
  sys.exit()

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