import gzip
import shutil
from pathlib import Path


class Zipper:
    @staticmethod
    def get_instance() -> 'Zipper':
        return Zipper()
    
    async def zip_files(self, raw_file_path: str, zip_file_path: str) -> None:
        """Compress a file using gzip compression"""
        raw_path = Path(raw_file_path)
        zip_path = Path(zip_file_path)
        
        # Ensure output directory exists
        zip_path.parent.mkdir(parents=True, exist_ok=True)
        
        with raw_path.open('rb') as f_in:
            with gzip.open(zip_path, 'wb') as f_out:
                shutil.copyfileobj(f_in, f_out)
    
    async def unzip_file(self, zip_file_path: str, raw_file_path: str) -> None:
        """Decompress a gzip file"""
        zip_path = Path(zip_file_path)
        raw_path = Path(raw_file_path)
        
        # Ensure output directory exists
        raw_path.parent.mkdir(parents=True, exist_ok=True)
        
        with gzip.open(zip_path, 'rb') as f_in:
            with raw_path.open('wb') as f_out:
                shutil.copyfileobj(f_in, f_out)