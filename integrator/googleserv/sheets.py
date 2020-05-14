import gspread 
from oauth2client.service_account import ServiceAccountCredentials

class Sheets:

    spread_id = ''
    worksheet_num = 0

    def __init__(self, spread_id, worksheet_num=0):
        self.spread_id = spread_id
        self.worksheet_num = worksheet_num

    def get_data(self):
        scopes = ["https://spreadsheets.google.com/feeds", "https://www.googleapis.com/auth/drive"]
        credentials = ServiceAccountCredentials.from_json_keyfile_name("./config/credentials.json",scopes)
        sheet = gspread.authorize(credentials)
        wks = sheet.open(self.spread_id)
        rows = wks.get_worksheet(self.worksheet_num).get_all_records()
        return rows
