import sys
import gspread 
from core.core import Core as core
from oauth2client.service_account import ServiceAccountCredentials

class Sheets:

    spread_id = ""
    worksheet_num = 0
    credentialfile = ""

    def __init__(self, spread_id, worksheet_num=0):
        self.spread_id = spread_id
        self.worksheet_num = worksheet_num

    def get_data(self):
        scopes = ["https://spreadsheets.google.com/feeds", "https://www.googleapis.com/auth/drive"]
        pathjson = core.get_path_credential(self.credentialfile)
        credentials = ServiceAccountCredentials.from_json_keyfile_name(pathjson, scopes)
        sheet = gspread.authorize(credentials)
        wks = sheet.open(self.spread_id)
        rows = wks.get_worksheet(self.worksheet_num).get_all_records()
        print(rows);sys.exit()
        return rows

    def set_credential(self,strvalue):
        self.credentialfile = strvalue