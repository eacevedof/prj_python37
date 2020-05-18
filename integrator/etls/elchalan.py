from core.etl import Etl

option = 1

if option==1:
    etl1 = Etl("elchalan.json","json-to-imp-products")
    etl1.add_query("UPDATE imp_product SET description_full=NULL WHERE description_full='NULL'")
    etl1.add_query("UPDATE imp_product SET description_full=NULL WHERE trim(description_full)=''")
    # etl1.add_query("UPDATE imp_product SET error=1")
    etl1.transfer()

# hace petición a API google sheet
if option==2:
    etl1 = Etl("elchalan.json","gsheet-to-imp-products")
    etl1.transfer()

etl1 = Etl("elchalan.json","transfer-imp-to-app")
etl1.add_query("UPDATE app_product SET code_cache=uuid() WHERE cod_cache IS NULL")
etl1.add_query("""
UPDATE app_product 
SET code_cache = CONCAT(code_cache,'-',LPAD(id,8,0))
WHERE 1
AND LENGTH(code_cache)=36
""")
etl1.transfer()