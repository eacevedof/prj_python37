import unittest
import bootstrap

import tracemalloc

import datetime
from core.helpers.mysqlserv.mysql import Mysql

class MysqlTest(unittest.TestCase):
    
    def test_insert(self):
        diccfg = {'host': '127.0.0.1', 'port': '3306', 'user': 'root', 'passwd': '1234', 'database': 'db_eduardoaf'}
        omysql = Mysql(diccfg)
        
        sql = "TRUNCATE TABLE imp_post"
        omysql.execute(sql)

        sql = "INSERT INTO imp_post (publish_date, last_update, title, content, excerpt, id_status, slug) VALUES ( %s, %s, %s, %s, %s, %s, %s )"
        omysql.insert_tpl(sql,
            (
                "pd", 
                "lu", 
                'a','b','c','d','e',
            )
        )
        

        sql = "SELECT * FROM imp_post WHERE title='a'"
        r = omysql.execute(sql)
        omysql.close()

        ilen = 0 if r is None else len(r)
        self.assertGreater(ilen, 0, "assert insert")


if __name__ == "__main__":

    
    unittest.main()