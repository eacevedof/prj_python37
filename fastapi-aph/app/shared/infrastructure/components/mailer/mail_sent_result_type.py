from dataclasses import dataclass
from typing import final


@final
@dataclass(frozen=True)
class MailSentResultType:
    success: bool
    error: str
    tmp_random_file: str