import sys
import math
import random

def _get_middle(iMin,iMax):
    iMiddle = (iMax - iMin)/2
    iMiddle = math.ceil(iMiddle)
    return iMiddle
#end _get_middle

def _get_position(iSearch,lstData):
    iSearch = int(iSearch)
    # ya vienen ordenados
    #lstData.sort()
    iChars = 70
    print("="*iChars)
    print(lstData)
    print("="*iChars)
    iLast = lstData[-1]
    
    # entrada inicial
    iMin = 0
    iMax = len(lstData)-1
    iMiddle = _get_middle(iMin,iMax)

    while (not (iMax<0 or iMin>iMax)):
        iValMiddle = lstData[iMiddle]
        print("iMin:{}, iMax:{}, iMiddle:{}, valMiddle:{} vs {}".format(iMin,iMax,iMiddle,iValMiddle,iSearch))
        if iSearch == iValMiddle:
            return iMiddle
        # no encontrado, busca por derecha
        elif iSearch > iValMiddle:
            iMin = iMiddle + 1
            iMiddle = iMin + _get_middle(iMin,iMax)
        # no encontrado busca por izquierda
        else: #iSearch < iValMiddle
            iMax = (iMiddle - 1)
            iMiddle = _get_middle(iMin,iMax)
        print("vals for next loop: iMin:{}, iMax:{}, iMiddle:{}".format(iMin,iMax,iMiddle))

    return None
#end _get_position

if __name__ == '__main__':
    # pass
    iItems = 25
    lstNumbers = [random.randint(0,100) for i in range(iItems)]
    lstNumbers.sort()
    print(lstNumbers)

    iSearch = input("\n Number to find: ")
    iFound = _get_position(iSearch,lstNumbers)
    
    if iFound != None:
        print("Number {} found at position {}".format(iSearch,iFound))
    else:
        print("Number {} not found!".format(iSearch))