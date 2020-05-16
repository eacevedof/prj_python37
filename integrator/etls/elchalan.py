from core.etl import Etl

option = 2

if option==1:
    etl1 = Etl("elchalan.json","json-to-imp-products")
    etl1.add_query("UPDATE imp_product SET description_full=NULL WHERE description_full='NULL'")
    etl1.add_query("UPDATE imp_product SET description_full=NULL WHERE trim(description_full)=''")
    # etl1.add_query("UPDATE imp_product SET error=1")
    etl1.transfer()

if option==2:
    etl1 = Etl("elchalan.json","gsheet-to-imp-products")
    etl1.transfer()

etl1 = Etl("elchalan.json","transfer-imp-to-app")
etl1.transfer()    