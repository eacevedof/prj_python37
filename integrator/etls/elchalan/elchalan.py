import sys
from core.etl import Etl

option = 1

# =============================================
#              SOURCE a IMP TABLE
# =============================================
if option==1:
    # lee config/mapping/<id>
    etl1 = Etl("elchalan.json","json-to-imp-products")
    etl1.add_query("UPDATE imp_product SET description_full=NULL WHERE description_full='NULL'")
    etl1.add_query("UPDATE imp_product SET description_full=NULL WHERE trim(description_full)=''")
    # etl1.add_query("UPDATE imp_product SET error=1")
    #etl1.transfer()

# hace petición a API google sheet
if option==2:
    etl1 = Etl("elchalan.json","gsheet-to-imp-products")

etl1.transfer()

# =============================================
#              imagenes
# =============================================
etl1 = Etl("elchalan.json","products-pictures-to-db")
etl1.transfer()

# =============================================
#              IMP a APP
# =============================================
etl1 = Etl("elchalan.json","transfer-imp-to-app")
etl1.add_query("UPDATE app_product SET code_cache=uuid() WHERE code_cache IS NULL")
etl1.add_query("""
UPDATE app_product 
SET code_cache = CONCAT(code_cache,'-',LPAD(id,8,0))
WHERE 1
AND LENGTH(code_cache)=36
""")
etl1.add_query("UPDATE app_product SET description_full = description WHERE description_full IS NULL")
etl1.add_query("UPDATE app_product SET description = LOWER(description), description_full = LOWER(description_full)")
etl1.transfer()

