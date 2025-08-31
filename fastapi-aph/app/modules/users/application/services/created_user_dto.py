from typing import Dict, Any

class CreatedUserDto:
    def __init__(self, user_uuid: str):
        self.user_uuid = user_uuid
    
    @classmethod
    def from_primitives(cls, user_uuid: str) -> "CreatedUserDto":
        return cls(user_uuid)
    
    def get_user_uuid(self) -> str:
        return self.user_uuid
    
    def to_primitives(self) -> Dict[str, Any]:
        return {
            "user_uuid": self.user_uuid
        }