from google.sheets import Sheets

def mysql_check():

    osheet = Sheets()
    data = osheet.get_data()
    print(data)

    import mysql.connector

    mydb = mysql.connector.connect(
        host="localhost",
        user="root",
        passwd="1234",
        database="db_tinymarket"
    )
    
    objcursor = mydb.cursor(dictionary=True)
    sql = """
            INSERT INTO imp_products (code, description, description_full, price, price2, display) 
            VALUES (%s, %s,%s, %s,%s, %s)
          """
    values = ("a","b","c","d","e","f")
    objcursor.execute(sql,values)

    sql = "SELECT * FROM imp_products"
    objcursor.execute(sql)
    res = objcursor.fetchall()
    print(res)
    for row in res:
        print(row)

if __name__ == '__main__':
    # two()
    mysql_check();