# component_dirs.py
import os
import sys
import glob
from pprint import pprint 

class ComponentDirs:

  def __init__(self,pathdir=None):
    self.pathdir = pathdir
    if pathdir is None:
      self.pathdir = os.path.dirname(__file__)
  # __init__

  def _get_list_files(path):
    # returns a list of names (with extension, without full path) of all files 
    # in folder path
    files = []
    for name in os.listdir(path):
      if os.path.isfile(os.path.join(path, name)):
        files.append(name)
    return files 
  # list_files

  def get_folder_content(self):
    print(glob.glob(self.pathdir))
    for itemcontent in os.scandir(self.pathdir):
      pprint(itemcontent)
  # get_folder_content


    
        