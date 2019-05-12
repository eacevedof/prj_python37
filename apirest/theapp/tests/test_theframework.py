import os
from django.test import TestCase

# https://docs.djangoproject.com/en/2.2/topics/testing/overview/
# from theframework.components import *
# import components 
from components.component_log import ComponentLog

class ComponentLogTest(TestCase):

    def get_currpath(self):
        strdirpath = os.getcwd()
        return strdirpath

    def is_file(self,pathfile):
        return os.path.exists(pathfile) 

    def get_pathlog(self):
        from datetime import datetime
        strfilename = "app_"+(datetime.now()).strftime("%Y%m%d-%H%M%S")+".log"
        pathfolder = self.get_currpath()
        pathfile = os.path.join(
                        pathfolder,
                        "debug",
                        strfilename)
        return pathfile


    def test_logdebug(self):
        p("test_logdebug")
        o = ComponentLog()
        o.save("texto de 11111")
        o.save("texto de prueba2 con titulo","Linea 2")
        pathlogfile = self.get_pathlog()
        isFile = self.is_file(pathlogfile)
        self.assertBoolean(isFile,True)


"""
Probar este test: py manage.py test ./theapp/tests
"""
