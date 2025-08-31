import hashlib

class Encoder:
    @classmethod
    def get_instance(cls) -> 'Encoder':
        return cls()
    
    def get_md5_hash(self, input_string: str) -> str:
        """Generate MD5 hash of input string"""
        return hashlib.md5(input_string.encode()).hexdigest()