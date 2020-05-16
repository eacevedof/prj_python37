from core.etl import Etl

# objetl = Etl("elchalan.json","transfer-products")
# objetl.add_query("UPDATE imp_product SET description_full=NULL WHERE description_full='NULL'")
# objetl.add_query("UPDATE imp_product SET description_full=NULL WHERE trim(description_full)=''")
# objetl.add_query("UPDATE imp_product SET error=1")


etl1 = Etl("elchalan.json","transfer-imp-to-app")
#etl1 = Etl("elchalan.json","transfer-products")
etl1.transfer()