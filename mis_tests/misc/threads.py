# https://www.youtube.com/watch?v=J9wOU5uWrjw
# Hilos en Python - Bytes Código Facilito
import threading
import time

def hola_mundo(nombre):
    print("Hola Mundo " + nombre)
    time.sleep(5)

if __name__ == '__main__':
    # hola_mundo("eaf")
    mainthread = threading.Thread(target=hola_mundo,args=("eaf",))
    mainthread.start()
    print("Hola mundo desde el hilo principal")
