from enum import Enum
from typing import final


@final
class MailProtocolEnum(Enum):
    SMTP = "smtp"
    SMTPS = "smtps"