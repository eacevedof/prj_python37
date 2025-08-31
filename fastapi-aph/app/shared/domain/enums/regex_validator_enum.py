import re
from typing import Dict

class RegexValidatorEnum:
    DOMAIN = re.compile(r'^(?!:\/\/)([a-zA-Z0-9-]+(-[a-zA-Z0-9]+)*\.)+[a-zA-Z]{2,}$')
    IP_ADDRESS_V4 = re.compile(r'^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$')
    IP_ADDRESS_V6 = re.compile(r'^(?:[0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}$')
    
    @classmethod
    def get_all_patterns(cls) -> Dict[str, re.Pattern]:
        return {
            'DOMAIN': cls.DOMAIN,
            'IP_ADDRESS_V4': cls.IP_ADDRESS_V4,
            'IP_ADDRESS_V6': cls.IP_ADDRESS_V6,
        }