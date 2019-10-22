
import requests
import json
from pprint import pprint

class ComponentRequest:
  
  # https://api.openload.co/1/account/info?login={login}&key={key}
  # https://api.openload.co/1/file/listfolder?login={login}&key={key}&folder={folder}
  def __init__(self,login,key):
    self.login = login
    self.key = key

  def run(self):
    print("run")

  def get_list_folder(self):
    print("get_list_folder")
    strurl = "https://api.openload.co/1/file/listfolder?login={}&key={}"
    strurl = strurl.format(self.login,self.key,5)
    print(strurl)
    objresp = requests.get(strurl)
    # print(objresp.content)
    dictjson = json.loads(objresp.content)
    print(dictjson["result"]["folders"])
    return dictjson["result"]["folders"]

  def get_folder_content(self,ifolder):
    print("get_folder_content")
    strurl = "https://api.openload.co/1/file/listfolder?login={}&key={}&folder={}"
    strurl = strurl.format(self.login,self.key,ifolder)
    objresp = requests.get(strurl)
    dictjson = json.loads(objresp.content)
    pprint(dictjson)
    return dictjson

  def upload(self,pathlocal,ifolder,sha1,httponly=False):
    print("upload")
    strurl = "https://api.openload.co/1/file/ul?login={}&key={}&folder={}&sha1={}&httponly={}"
    strurl = strurl.format(self.login,self.key,ifolder,sha1,httponly)
    files = {"file":open(pathlocal,"rb")}
    r = requests.post(strurl,files=files)
    print(r.text)

if __name__=="__main__":
  o = ComponentRequest()
  o.run()
