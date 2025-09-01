import csv
import os
from typing import List, Dict, Union, Optional
from pathlib import Path


class Csver:
    @staticmethod
    def get_instance():
        return Csver()
    
    async def create_csv_file_from_array(
        self,
        data: List[Dict[str, Union[str, int, None]]],
        file_path: str,
        delimiter: str = ",",
        headers: Optional[List[str]] = None
    ) -> None:
        if not data:
            return
        
        if not headers:
            headers = list(data[0].keys()) if data else []
        
        # Clean data - remove null characters from strings
        clean_data = []
        for row in data:
            clean_row = {}
            for k, v in row.items():
                if isinstance(v, str):
                    clean_row[k] = v.replace('\0', '')
                else:
                    clean_row[k] = v
            clean_data.append(clean_row)
        
        # Ensure directory exists
        path_obj = Path(file_path)
        path_obj.parent.mkdir(parents=True, exist_ok=True)
        
        # Write CSV file
        with open(file_path, 'w', newline='', encoding='utf-8') as csvfile:
            writer = csv.DictWriter(csvfile, fieldnames=headers, delimiter=delimiter)
            writer.writeheader()
            writer.writerows(clean_data)