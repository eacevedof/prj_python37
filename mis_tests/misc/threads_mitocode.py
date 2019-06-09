# Python 3 Tutorial - 15 Hilos
# https://www.youtube.com/watch?v=3Rlh6uUuQqA

import threading
import time
import datetime
import logging

def consultar(id_persona):
    time.sleep(2)
    return

def guardar(id_persona, data):
    time.sleep(5)
    return 

tiempo_ini = datetime.datetime.now()
t1 = threading.Thread(name="Hilo_1",target=consultar,args=(1,))
t2 = threading.Thread(name="Hilo_2",target=guardar,args=(1, "Suscribete al canal",))

t1.start()
t2.start()

# se ejecutan a la vez, esto hace que acabe en 5 sec
t1.join()
t2.join()

#consultar(1) # ejec en hilo principal
#guardar(1, "Suscribete al canal") # ejec en hilo princ
tiempo_fin = datetime.datetime.now()
print("Tiempo transcurrido "+ str(tiempo_fin.second - tiempo_ini.second))
