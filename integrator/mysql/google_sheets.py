SAMPLE_SPREADSHEET_ID = 'temp_xls'

def two():
    import gspread 
    from oauth2client.service_account import ServiceAccountCredentials
    scope = ["https://spreadsheets.google.com/feeds", "https://www.googleapis.com/auth/drive"]
    credentials = ServiceAccountCredentials.from_json_keyfile_name("credentials.json",scope)
    gc = gspread.authorize(credentials)
    wks = gc.open(SAMPLE_SPREADSHEET_ID)
    print(wks.get_worksheet(2).get_all_records())
    # print(wks.get_allrecrods())


def mysql_check():
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