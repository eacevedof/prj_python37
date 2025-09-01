from dataclasses import dataclass


@dataclass
class MailAttachmentType:
    path: str
    filename: str