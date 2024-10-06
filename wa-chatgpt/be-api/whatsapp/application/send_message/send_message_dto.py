from typing import final
from dataclasses import dataclass
from typing import List


@final
@dataclass(frozen=True)
class SendMessageDto:
    phone_number: str
    message: str

