# integrator/etls/eduardoaf/eduardoaf.py
import sys
from core.etl import Etl

# =============================================
#              OLD a IMP
# =============================================
etl1 = Etl("eduardoaf.json","transfer-old-current")


etl1.transfer()

