# Curso de Python Intermedio Hilos o threads by Hugo Nept
# https://youtu.be/zVguVMZOOrQ

import threading
import time

class MiHilo(threading.Trhead):
    
    def run(self):
        print("{} inició".format(self.getName()))
        time.sleep(2)
        print("{} terminado".format(self.getName())


if __name__=="__main__":
    for x in range(4):
        objhilo = MiHilo(name="Thread-{}".format(x+1))
        objhilo.start()
        time.sleep(.5)



