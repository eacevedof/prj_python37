# integrator/etls/eduardoaf/eduardoaf.py
import sys
from core.etl import Etl

# =============================================
#              OLD a IMP
# =============================================
etl1 = Etl("eduardoaf.json","transfer-old-current")
etl1.add_query("""
UPDATE app_product 
SET code_cache = CONCAT(code_cache,'-',LPAD(id,8,0))
WHERE 1
AND LENGTH(code_cache)=36
""")

etl1.transfer()

