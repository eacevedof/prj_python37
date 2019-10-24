import os
import sqlite3
from sqlite3 import Error

def create_connection(db_file=None):
    """ create a database connection to a SQLite database """
    if db_file is None:
        strthispath = os.path.join(os.path.dirname(__file__), '..')+"\openloadco\db_openloadco.db"
        db_file = os.path.realpath(strthispath)
    
    conn = None
    try:
        conn = sqlite3.connect(db_file)
        print(sqlite3.version)
    except Error as e:
        print("error")
        print(e)
    finally:
        if conn:
            conn.close()
  
def create_project(conn, project):
    """
    Create a new project into the projects table
    :param conn:
    :param project:
    :return: project id
    """
    sql = ''' INSERT INTO projects(name,begin_date,end_date)
              VALUES(?,?,?) '''
    cur = conn.cursor()
    cur.execute(sql, project)
    return cur.lastrowid
    
if __name__ == '__main__':
    strthispath = os.path.join(os.path.dirname(__file__), '..')+"\openloadco\db_openloadco.db"
    strthispath = os.path.realpath(strthispath)
    #print(strthispath)
    create_connection(strthispath)