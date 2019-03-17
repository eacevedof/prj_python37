import os
import sys
from pprint import pprint
import csv
from clients.models import Client


class ClientService:
    def __init__(self,table_name):
        self.table_name = table_name

    def create_client(self,oClient):
        with open(self.table_name,mode="a") as f:
            oWriter = csv.DictWriter(f,Client.schema())
            #pprint(oWriter)
            # print(oClient.to_dictionary())
            # oWriter.writerow(oClient.to_dictionary())
            oWriter.writerow(oClient.to_dict())
            # oWriter.writerow(vars(oClient))


    def list_clients(self):
        with open(self.table_name, mode="r") as f:
            oReader = csv.DictReader(f,fieldnames=Client.schema())    
            
            return list(oReader)


    def update_client(self, oClient):
        lstClients = self.list_clients()
        # print(lstClients)
        # sys.exit()
        lstUpdated = []
        for dicClient  in lstClients:
            if dicClient["uid"] == oClient.uid:
                lstUpdated.append(oClient.to_dict())
            else:
                lstUpdated.append(dicClient)
        
        self._save_to_disk(lstUpdated)
            
    def delete_client(self,oClient):
        lstClients = self.list_clients()
        lstNondel = []
        for dicClient  in lstClients:
            if dicClient["uid"] != oClient.uid:
                lstNondel.append(dicClient)
        
        self._save_to_disk(lstNondel)                  
    

    def _save_to_disk(self,lstClients):
        tmpTablename = self.table_name + ".tmp"
        with open(tmpTablename, mode="a") as f:
            oWriter = csv.DictWriter(f,fieldnames=Client.schema())
            oWriter.writerows(lstClients)

        os.remove(self.table_name)
        os.rename(tmpTablename,self.table_name)

