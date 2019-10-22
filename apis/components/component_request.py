
import requests
import json

class ComponentRequest:
  
  # https://api.openload.co/1/account/info?login={login}&key={key}
  # https://api.openload.co/1/file/listfolder?login={login}&key={key}&folder={folder}
  def __init__(self,login,key):
    self.login = login
    self.key = key

  def run(self):
    print("run")

  def get_list_folder(self):
    strurl = "https://api.openload.co/1/file/listfolder?login={}&key={}"
    strurl = strurl.format(self.login,self.key,5)
    print(strurl)
    objresp = requests.get(strurl)
    # print(objresp.content)
    dictjson = json.loads(objresp.content)

    print(dictjson["result"]["folders"])

  def get_folder_content(self,ifolder="8348114"):
    strurl = "https://api.openload.co/1/file/listfolder?login={}&key={}&folder={}"
    strurl = strurl.format(self.login,self.key,ifolder)
    objresp = requests.get(strurl)
    print(objresp.content)

if __name__=="__main__":
  o = ComponentRequest()
  o.run()
