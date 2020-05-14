import gspread 
from oauth2client.service_account import ServiceAccountCredentials

class Sheets:

    SAMPLE_SPREADSHEET_ID = 'temp_xls'

    def get_data(self):
        scope = ["https://spreadsheets.google.com/feeds", "https://www.googleapis.com/auth/drive"]
        credentials = ServiceAccountCredentials.from_json_keyfile_name("credentials.json",scope)
        gc = gspread.authorize(credentials)
        wks = gc.open(SAMPLE_SPREADSHEET_ID)
        print(wks.get_worksheet(2).get_all_records())
        # print(wks.get_allrecrods())
