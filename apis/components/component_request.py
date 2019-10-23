
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

  def _get_content(self,strurl):
    objresp = requests.get(strurl)
    dictjson = json.loads(objresp.content)    
    return dictjson

  def get_list_folder(self):
    print("\nget_list_folder:")
    strurl = "https://api.openload.co/1/file/listfolder?login={login}&key={key}"
    strurl = strurl.format(login=self.login,key=self.key)

    dictjson = self._get_content(strurl)
    print(dictjson)
    return dictjson
  #get_list_folder

  def get_folder_content(self,ifolder):
    print("\nget_folder_content:")
    strurl = "https://api.openload.co/1/file/listfolder?login={}&key={}&folder={}"
    strurl = strurl.format(self.login,self.key,ifolder)
    dictjson = self._get_content(strurl)
    return dictjson
  #get_folder_content

  def get_account_info(self):
    print("\nget_account_info:")
    strurl = "https://api.openload.co/1/account/info?login={login}&key={key}"
    strurl = strurl.format(login=self.login,key=self.key)
    dictjson = self._get_content(strurl)
    return dictjson
  # get_account_info

  def upload(self,pathlocal,ifolder):
    print("\nupload:")
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

    dictjson = self._get_content(strurl)
    strurlup = dictjson["result"]["url"]
    # print(strurlup)
    objresp = requests.post(url=strurlup, headers={}, files={"file1":open(pathlocal,"rb"),})
    dictjson = json.loads(objresp.text)
    return dictjson
  # upload

  def get_file_info(self,ifile):
    strurl = "https://api.openload.co/1/file/info?file={file}&login={login}&key={key}"
    strurl = strurl.format(ifile,self.login,self.key)

  # get_file_info

if __name__=="__main__":
  o = ComponentRequest()
  o.run()
