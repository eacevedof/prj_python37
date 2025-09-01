from typing import Dict, Any, final
from dataclasses import dataclass

@final
@dataclass(frozen=True)
class CreatedUserDto:
    user_uuid: str
    
    @classmethod
    def from_primitives(cls, user_uuid: str) -> "CreatedUserDto":
        return cls(user_uuid=user_uuid)
    
    def get_user_uuid(self) -> str:
        return self.user_uuid
    
    def to_primitives(self) -> Dict[str, Any]:
        return {
            "user_uuid": self.user_uuid
        }