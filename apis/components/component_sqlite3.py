import os
import sqlite3
from sqlite3 import Error

def get_connection(db_file=None):
    """ create a database connection to a SQLite database """
    if db_file is None:
        strthispath = os.path.join(os.path.dirname(__file__), '..')+"\openloadco\db_openloadco.db"
        db_file = os.path.realpath(strthispath)
    
    conn = None
    try:
        conn = sqlite3.connect(db_file)
        print(sqlite3.version)
        return conn
    except Error as e:
        print("error")
        print(e)

  
def insert_loc_folder(tplparams):
    """
    no funciona ^^ que sorpresa!
    """
    sql = ''' INSERT INTO loc_folder(fullpath,status)
              VALUES(?,?) '''
    conn = get_connection()
    cur = conn.cursor()
    cur.execute(sql,tplparams)
    conn.commit()
    conn.close()
    return cur.lastrowid

if __name__ == '__main__':
    strthispath = os.path.join(os.path.dirname(__file__), '..')+"\openloadco\db_openloadco.db"
    strthispath = os.path.realpath(strthispath)
    #print(strthispath)
    strid = insert_loc_folder(("xx","yy",))
    print(strid)