from dataclasses import dataclass


@dataclass
class MailSmtpConfigType:
    email_from: str
    email_from_name: str
    protocol: str
    smtp_host: str
    smtp_port: int
    smtp_user: str
    smtp_pass: str
    smtp_crypto: str
    mail_type: str
    charset: str