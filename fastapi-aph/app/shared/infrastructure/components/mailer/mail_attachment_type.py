from dataclasses import dataclass
from typing import final


@final
@dataclass(frozen=True)
class MailAttachmentType:
    path: str
    filename: str