# Python: 3.2 - Multi threading
# https://www.youtube.com/watch?v=xz3KgbftMes

"""
threading.Thread()          # create a new Thread
threading.active_count()    # see how many running threads
threading.current_thread()  # current thread number
threading.enumerate()       # list active threads
threading.lock()            # create a new lock
"""

# https://youtu.be/xz3KgbftMes?t=740
import threading

def worker(inum):
    # print("worker.Thread {}".format(inum))
    print("worker.Thread %s" % inum)

lstthreads = []
for i in range(5):
    objthread = threading.Thread(target=worker,args=(i,))
    lstthreads.append(objthread)
    objthread.start()



