from dataclasses import dataclass


@dataclass
class MailSentResultType:
    success: bool
    error: str
    tmp_random_file: str