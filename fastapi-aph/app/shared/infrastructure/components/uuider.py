import uuid
import random
import string
from typing import Optional


class Uuider:
    """UUID and random string generation utility"""
    
    @classmethod
    def get_instance(cls) -> 'Uuider':
        return cls()
    
    def get_random_uuid_with_prefix(self, prefix: str) -> str:
        """Generate a random UUID with prefix in the format aph-{prefix}-{uuid_without_dashes}"""
        random_uuid = str(uuid.uuid4()).replace('-', '')
        return f"aph-{prefix}-{random_uuid}"
    
    def get_random_alpha_numeric_string(self, length: int = 10) -> str:
        """Generate a random alphanumeric string of specified length"""
        chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
        return ''.join(random.choice(chars) for _ in range(length))
    
    def get_random_alpha_numeric_string_with_prefix(self, prefix: str, length: int = 10) -> str:
        """Generate a random alphanumeric string with prefix"""
        random_string = self.get_random_alpha_numeric_string(length)
        return f"aph-{prefix}-{random_string}"