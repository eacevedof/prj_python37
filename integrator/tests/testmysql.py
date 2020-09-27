import unittest
import bootstrap 

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
                datetime.datetime(2010, 8, 14, 10, 35, 18), 
                datetime.datetime(2010, 10, 31, 18, 50, 45), 
                'a','b','c','d','e',
            )
        )
        
        sql = "SELECT * FROM imp_post WHERE title='a'"
        r = omysql.execute(sql)
        self.assertGreater(len(r),0,"assert insert")


if __name__ == "__main__":

    
    unittest.main()