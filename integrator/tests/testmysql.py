import unittest

#import datetime
from bootstrap import decorator_warnings
from core.helpers.mysqlserv.mysql import Mysql
from core.tools.tools import prn

class MysqlTest(unittest.TestCase):

    _dbconf = {'host': 'localhost', 'port': '3306', 'user': 'root', 'password': '1234', 'database': 'db_eduardoaf'}

    @decorator_warnings
    def test_truncate(self):
        diccfg = self._dbconf
        omysql = Mysql(diccfg)

        sql = "TRUNCATE TABLE imp_post"

        prn(sql,"test_truncate")
        omysql.execute(sql)
        omysql.commit().close()
        
    
    @decorator_warnings
    def test_insert(self):
        diccfg = self._dbconf
        omysql = Mysql(diccfg)

        sql = "INSERT INTO imp_post (publish_date, last_update, title, content, excerpt, id_status, slug) VALUES ( %s, %s, %s, %s, %s, %s, %s )"
        prn(sql,"test_insert")

        lastid = omysql.insert_tpl(sql,
            (
                "pd", 
                "lu", 
                'a','b','c','d','e',
            )
        )
        omysql.commit().close()
        self.assertGreater(lastid, 0, "assert insert")


    @decorator_warnings
    def test_select(self):
        diccfg = self._dbconf
        omysql = Mysql(diccfg)
        
        sql = "SELECT * FROM imp_post WHERE title='a'"
        prn(sql,"test_select")

        r = omysql.query(sql)
        prn(r, "result")
        omysql.close()

        ilen = 0 if r is None else len(r)
        self.assertGreater(ilen, 0, "assert select")


if __name__ == "__main__":
    # o = MysqlTest();o.test_truncate();o.test_insert();o.test_select()
    unittest.main()