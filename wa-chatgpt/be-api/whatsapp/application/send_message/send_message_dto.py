from typing import final
from dataclasses import dataclass
from typing import List

@final
@dataclass(frozen=True)
class SendMessageDto:
    to_phone_number: str
    template_name: str
    template_language: str

