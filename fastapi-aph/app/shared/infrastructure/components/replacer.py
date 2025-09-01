import re
from typing import Dict, final


@final
class Replacer:
    @staticmethod
    def get_instance():
        return Replacer()
    
    def get_replaced_content(self, content: str, to_replace: Dict[str, str]) -> str:
        result = content
        for key, value in to_replace.items():
            result = re.sub(key, value, result)
        return result