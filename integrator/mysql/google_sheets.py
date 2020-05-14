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

if __name__ == '__main__':
    two()