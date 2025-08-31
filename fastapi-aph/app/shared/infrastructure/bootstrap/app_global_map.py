from typing import Dict, Any, Optional
from app.shared.infrastructure.bootstrap.app_key_enum import AppKeyEnum

class AppGlobalMap:
    _instance: Optional['AppGlobalMap'] = None
    _dictionary: Dict[str, Any] = {}
    
    def __new__(cls):
        if cls._instance is None:
            cls._instance = super(AppGlobalMap, cls).__new__(cls)
        return cls._instance
    
    @classmethod
    def get_instance(cls) -> 'AppGlobalMap':
        if cls._instance is None:
            cls._instance = cls()
        return cls._instance
    
    def set(self, key: AppKeyEnum, value: Any) -> None:
        self._dictionary[key.value] = value
    
    def get(self, key: AppKeyEnum) -> Optional[Any]:
        return self._dictionary.get(key.value)