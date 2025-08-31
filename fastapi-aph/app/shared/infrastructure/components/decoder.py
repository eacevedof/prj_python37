import base64
import re
from app.shared.infrastructure.components.logger import Logger

class Decoder:
    def __init__(self):
        self.logger = Logger.get_instance()
    
    @classmethod
    def get_instance(cls) -> 'Decoder':
        return cls()
    
    def get_decoded_from_base64(self, base64_string: str) -> str:
        """Decode Base64 string, return original if invalid"""
        base64_regex = re.compile(r'^[A-Za-z0-9+/=]+$')
        
        if not base64_regex.match(base64_string):
            return base64_string
        
        try:
            decoded_bytes = base64.b64decode(base64_string)
            return decoded_bytes.decode('utf-8')
        except Exception as error:
            self.logger.log_error("Error decoding Base64 string", error)
            return base64_string