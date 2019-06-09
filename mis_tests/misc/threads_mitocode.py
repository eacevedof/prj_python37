# Python 3 Tutorial - 15 Hilos
# https://www.youtube.com/watch?v=3Rlh6uUuQqA

import threading
import time
import datetime
import logging

# no va este import
#import thread_hilo1.Hilo1 as Hilo2
#import thread_hilo2.Hilo2 as Hilo2

# tampoco va
# from . import thread_hilo1 as Hilo1
# from . import thread_hilo2 as Hilo2

# importación des de la misma carpeta
from thread_hilo1 import Hilo1
from thread_hilo2 import Hilo2

# https://youtu.be/3Rlh6uUuQqA?t=457
logging.basicConfig(level=logging.INFO, format='[%(levelname)s] (%(threadName)-s) %(message)s')

def consultar(id_persona):
    logging.info("consultando para el id " + str(id_persona))
    time.sleep(2)
    return

def guardar(id_persona, data):
    logging.info("guardando para el id " + str(id_persona)+" data:"+str(data))
    time.sleep(5)
    return 

tiempo_ini = datetime.datetime.now()
# t1 = threading.Thread(target=consultar,args=(1,),name="Hilo_1")
# t2 = threading.Thread(target=guardar,args=(1, "Suscribete al canal",)) # python aplica un nombre: Thread-1

#https://youtu.be/3Rlh6uUuQqA?t=663  hilos con clases
t1 = Hilo1("Hilo_1",1,"")
t2 = Hilo2("Hilo_2",1,"Suscribete")

t1.start()
t2.start()

# se ejecutan a la vez, esto hace que acabe en 5 sec
t1.join()
t2.join()

#consultar(1) # ejec en hilo principal
#guardar(1, "Suscribete al canal") # ejec en hilo princ
tiempo_fin = datetime.datetime.now()
print("Tiempo transcurrido "+ str(tiempo_fin.second - tiempo_ini.second))
