import os
import json
import time
from typing import Any, Optional, Dict
from pathlib import Path

class Cacher:
    def __init__(self, cache_file_name: str) -> None:
        self.cache_folder = Path.cwd() / "storage" / "cache"
        self.cache_file_path = self.cache_folder / cache_file_name
    
    @classmethod
    def get_instance(cls, cache_file_name: str) -> 'Cacher':
        return cls(cache_file_name)
    
    async def get(self, key: str) -> Optional[Any]:
        try:
            if not self.cache_file_path.exists():
                return None
            
            with open(self.cache_file_path, 'r') as f:
                cache_data = json.load(f)
            
            cache_entry = cache_data.get(key)
            if not cache_entry:
                return None
            
            current_time_ms = int(time.time() * 1000)
            if current_time_ms < cache_entry.get('expiry', 0):
                return cache_entry.get('value')
            
            # Entry expired, remove it and update cache file
            del cache_data[key]
            with open(self.cache_file_path, 'w') as f:
                json.dump(cache_data, f, indent=2)
            
            return None
            
        except FileNotFoundError:
            return None
        except Exception as error:
            raise error
    
    async def add(self, key: str, value: Any, ttl_minutes: int) -> None:
        cache_data: Dict[str, Dict[str, Any]] = {}
        
        try:
            if self.cache_file_path.exists():
                with open(self.cache_file_path, 'r') as f:
                    cache_data = json.load(f)
        except FileNotFoundError:
            pass
        except Exception as error:
            raise error
        
        current_time_ms = int(time.time() * 1000)
        expiry = current_time_ms + (ttl_minutes * 60 * 1000)
        
        cache_data[key] = {
            'value': value,
            'expiry': expiry
        }
        
        # Ensure cache directory exists
        self.cache_folder.mkdir(parents=True, exist_ok=True)
        
        with open(self.cache_file_path, 'w') as f:
            json.dump(cache_data, f, indent=2)