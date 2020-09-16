# integrator/etls/eduardoaf/eduardoaf.py
import sys
from core.etl import Etl

# =============================================
#              OLD a IMP
# =============================================
etl1 = Etl("eduardoaf.json","transfer-old-current")
etl1.add_query("""
INSERT INTO app_post (
    insert_user, insert_platform, publish_date, last_update, title, content, slug, excerpt, id_status, description
)
SELECT  
'etl' insert_user,
0 insert_platform,

publish_date,
last_update,
title,
content,
slug,
excerpt,
CASE id_status WHEN 'publish' THEN 1 ELSE 0 END id_status,
id_status

FROM imp_post
WHERE 1

""")

etl1.transfer()

