
import requests
import json
from pprint import pprint
import hashlib

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
    strurl = strurl.format(self.login,self.key)
    print(strurl)
    objresp = requests.get(strurl)
    # print(objresp.content)
    dictjson = json.loads(objresp.content)
    print(dictjson["result"]["folders"])
    return dictjson["result"]["folders"]
  #get_list_folder

  def get_folder_content(self,ifolder):
    print("get_folder_content")
    strurl = "https://api.openload.co/1/file/listfolder?login={}&key={}&folder={}"
    strurl = strurl.format(self.login,self.key,ifolder)
    objresp = requests.get(strurl)
    dictjson = json.loads(objresp.content)
    pprint(dictjson)
    return dictjson
  #get_folder_content

  def get_account_info(self):
    print("get_account_info")
    strurl = "https://api.openload.co/1/account/info?login={login}&key={key}"
    strurl = strurl.format(login=self.login,key=self.key)
    objresp = requests.get(strurl)
    dictjson = json.loads(objresp.content)
    pprint(dictjson)
    return dictjson
  # get_account_info

  def upload(self,pathlocal,ifolder):
    print("upload")

    BLOCKSIZE = 65536
    objsha1 = hashlib.sha1()
    with open(pathlocal, 'rb') as afile:
      objbuf = afile.read(BLOCKSIZE)
      while len(objbuf) > 0:
        objsha1.update(objbuf)
        objbuf = afile.read(BLOCKSIZE)

    strsha1 = objsha1.hexdigest()

    strurl = "https://api.openload.co/1/file/ul?login={login}&key={key}&sha1={sha1}&folder=8306116"
    strurl = strurl.format(login=self.login, key=self.key, sha1=strsha1)

    objresp = requests.get(url=strurl, headers={})
    dicjson = objresp.json()

    strurlup = dicjson["result"]["url"]
    # print(strurlup)
    objresp = requests.post(url=strurlup, headers={}, files={"file1":open(pathlocal,"rb"),})
    dictjson = json.loads(objresp.text)
    return dictjson
  # upload

if __name__=="__main__":
  o = ComponentRequest()
  o.run()
