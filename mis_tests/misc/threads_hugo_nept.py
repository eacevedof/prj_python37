# Curso de Python Intermedio Hilos o threads by Hugo Nept
# https://youtu.be/zVguVMZOOrQ

import threading
import time

class MiHilo(threading.Thread):
    
    def run(self):
        print("{} run.inicio".format(self.getName()))
        time.sleep(2)
        print("{} run.terminado desp 2 sec".format(self.getName()))

if __name__=="__main__":
    for x in range(4):
        objhilo = MiHilo(name="Thread in for-{}".format(x+1))
        objhilo.start()
        time.sleep(.1)

"""
tiempo   |-------|-------|-------|
         0       1       2       3 
hilo1    |---------------|
hilo2     |---------------|
hilo3      |---------------|
hilo4       |---------------|

"""