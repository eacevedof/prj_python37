
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

  def upload(self,pathlocal,ifolder):
    print("upload")
    filepath = '/scripts/wordpress/240p.mp4'
    filepath = pathlocal

    sha1 = hashlib.sha1()

    BLOCKSIZE = 65536
    with open(filepath, 'rb') as afile:
        buf = afile.read(BLOCKSIZE)
        while len(buf) > 0:
            sha1.update(buf)
            buf = afile.read(BLOCKSIZE)

    sha1_hash = sha1.hexdigest()

    url = "https://api.openload.co/1/file/ul?login={login}&key={key}&sha1={sha1}&folder=8306116".format(
        login=self.login,
        key=self.key,
        sha1=sha1_hash,
    )

    p = {
        'url': url,
        'headers': {
            #'User-Agent': self.ua,
        }
    }
    r = requests.get(url=p['url'], headers=p['headers'])
    j = r.json()

    upload_link = j['result']['url']

    p = {
        'url': upload_link,
        'headers': {
            # 'user-agent': self.ua,
        },
        'files': {
            'file1': open(filepath, 'rb'),
        }
    }
    r = requests.post(url=p['url'], headers=p['headers'], files=p['files'])
    print(r.text)
  # upload

if __name__=="__main__":
  o = ComponentRequest()
  o.run()
