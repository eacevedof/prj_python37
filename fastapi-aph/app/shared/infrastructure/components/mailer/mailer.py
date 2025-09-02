import asyncio
import re
import secrets
from datetime import datetime
from pathlib import Path
from typing import List, Dict, Optional, final

from app.shared.infrastructure.components.mailer.mail_protocol_enum import MailProtocolEnum
from app.shared.infrastructure.components.mailer.mail_sent_result_type import MailSentResultType
from app.shared.infrastructure.components.mailer.mail_attachment_type import MailAttachmentType
from app.shared.infrastructure.components.mailer.mail_smtp_config_type import MailSmtpConfigType
from app.shared.infrastructure.components.mailer.mail_result import MailResult


@final
class Mailer:
    def __init__(self) -> None:
        self.path_log_email_file = f"{Path.cwd()}/storage/logs/email-{datetime.now().strftime('%Y-%m-%d')}.log"
        self.default_tpl_view = f"{Path.cwd()}/App/Modules/Mailings/Infrastructure/Views/System/email-default-tpl.html"
        self.path_tmp_file = ""
        
        self.email_from = ""
        self.email_from_name = ""
        self.email_to = ""
        self.emails_cc: List[str] = []
        self.subject = ""
        self.message = ""
        self.attachments: List[MailAttachmentType] = []
        
        self.tpl_view = ""
        self.tpl_vars: Dict[str, str] = {}
        
        self.smtp_config: Optional[MailSmtpConfigType] = None
        self.sent_result: Optional[MailSentResultType] = None
    
    @staticmethod
    def get_instance() -> 'Mailer':
        return Mailer()
    
    def set_subject(self, subject: str) -> 'Mailer':
        self.subject = subject
        return self
    
    def set_email_to(self, email_to: str) -> 'Mailer':
        self.email_to = email_to
        return self
    
    def set_email_from_name(self, email_from_name: str) -> 'Mailer':
        self.email_from_name = email_from_name
        return self
    
    def set_email_from(self, email_from: str) -> 'Mailer':
        self.email_from = email_from
        return self
    
    def add_email_cc(self, email_cc: str) -> 'Mailer':
        self.emails_cc.append(email_cc)
        return self
    
    def add_attachment(self, attachment: MailAttachmentType) -> 'Mailer':
        self.attachments.append(attachment)
        return self
    
    def set_attachments(self, attachments: List[MailAttachmentType]) -> 'Mailer':
        self.attachments = attachments
        return self
    
    def set_message(self, message: str) -> 'Mailer':
        self.message = message
        return self
    
    def set_smtp_config(self, smtp_config: MailSmtpConfigType) -> 'Mailer':
        self.smtp_config = smtp_config
        return self
    
    def set_tpl_view(self, tpl_view: str, tpl_vars: Dict[str, str] = None) -> 'Mailer':
        self.tpl_view = tpl_view
        self.tpl_vars = tpl_vars or {}
        return self
    
    def set_default_tpl_vars(self, tpl_vars: Dict[str, str]) -> 'Mailer':
        self.tpl_view = self.default_tpl_view
        self.tpl_vars = tpl_vars
        return self
    
    async def send_template(self) -> 'Mailer':
        self.__fail_if_wrong_input()
        self.message = await self.__get_template_html()
        await self.__send_email_with_curl()
        return self
    
    async def __send_email_with_curl(self) -> None:
        email_from = self.__get_from_email()
        email_to = self.email_to
        subject = self.subject or self.tpl_vars.get("subject", "python test")
        time_now = datetime.now().isoformat()
        
        cc_headers = ""
        cc_recipients = ""
        if self.emails_cc:
            cc_headers = f"Cc: {', '.join(self.emails_cc)}\n"
            cc_recipients = " ".join([f'--mail-rcpt "{cc}"' for cc in self.emails_cc])
        
        email_content = f"""From: {email_from.strip()}
To: {email_to.strip()} {cc_headers.strip()}
Subject: {subject.strip()}
Content-Type: text/html; charset=UTF-8
Date: {time_now}

{self.message}""".strip()
        
        print(f"email_content:\n{email_content}")
        curl_smtp_command = await self.__get_curl_email_command(email_content, cc_recipients)
        
        # Log command
        await asyncio.create_subprocess_shell(
            f'echo "{curl_smtp_command}" >> {self.path_log_email_file}'
        )
        
        # Log start marker
        await asyncio.create_subprocess_shell(
            f'echo "[{self.path_tmp_file}][start]" >> {self.path_log_email_file}'
        )
        
        # Execute curl command
        await asyncio.create_subprocess_shell(curl_smtp_command)
        
        # Log end marker
        await asyncio.create_subprocess_shell(
            f'echo "[{self.path_tmp_file}][end]" >> {self.path_log_email_file}'
        )
        
        self.sent_result = await MailResult.get_instance().get_sent_result({
            "email_log_path": self.path_log_email_file,
            "tmp_trace_log_path": self.path_tmp_file,
        })
    
    async def __get_curl_email_command(self, email_content: str, cc_recipients: str = "") -> str:
        mail_smtp_config = self.__get_default_email_config()
        smtp_url = f"{mail_smtp_config.protocol}://{mail_smtp_config.smtp_host}:{mail_smtp_config.smtp_port}"
        
        self.path_tmp_file = self.__get_random_tmp_file_path()
        
        # Write email content to temp file
        Path(self.path_tmp_file).write_text(email_content)
        
        nohup_parts = [
            "nohup sh -c 'curl --verbose --silent --show-error",
            "--max-time 60",
            f'--url "{smtp_url}"',
            f'--user "{mail_smtp_config.smtp_user}:{mail_smtp_config.smtp_pass}"',
            f'--mail-from "{self.email_from or mail_smtp_config.email_from}"',
            f'--mail-rcpt "{self.email_to}"',
            cc_recipients,
            f"--upload-file {self.path_tmp_file}",
            f"&& sleep 10 && rm {self.path_tmp_file}' >> {self.path_log_email_file} 2>&1"
        ]
        return " ".join(filter(None, nohup_parts))
    
    def __get_default_email_config(self) -> MailSmtpConfigType:
        if self.smtp_config:
            return self.smtp_config
        
        return MailSmtpConfigType(
            email_from="no-reply@cyberscp.es",
            email_from_name="Alert System",
            protocol=MailProtocolEnum.SMTPS.value,
            smtp_host="smtp.serviciodecorreo.es",
            smtp_port=465,
            smtp_user="no-reply@cyberscp.es",
            smtp_pass="5UUkbQ9Wh@!3",
            smtp_crypto="ssl",
            mail_type="html",
            charset="UTF-8"
        )
    
    async def __get_template_html(self) -> str:
        if not self.tpl_view:
            return ""
        
        template_path = Path(self.tpl_view)
        if not template_path.exists():
            return ""
        
        template_content = template_path.read_text()
        for key, value in self.tpl_vars.items():
            placeholder = f"{{{{{key}}}}}"
            template_content = template_content.replace(placeholder, value)
        
        return template_content
    
    def get_result(self) -> MailSentResultType:
        return self.sent_result or MailSentResultType(
            success=True,
            error="unknown",
            tmp_random_file=""
        )
    
    def reset(self) -> 'Mailer':
        self.subject = ""
        self.tpl_view = ""
        self.tpl_vars = {}
        self.email_to = ""
        self.email_from = ""
        self.email_from_name = ""
        self.emails_cc = []
        self.attachments = []
        self.sent_result = None
        self.message = ""
        return self
    
    def __fail_if_wrong_input(self) -> None:
        if not self.email_to:
            raise Exception("email-to is required")
        
        if not self.__is_valid_email(self.email_to):
            raise Exception(f"email-to {self.email_to} is not a valid email")
        
        if not self.subject and not self.tpl_vars:
            raise Exception("subject or vars are required")
    
    def __is_valid_email(self, email: str) -> bool:
        email_regex = r'^[^\s@]+@[^\s@]+\.[^\s@]+$'
        return bool(re.match(email_regex, email))
    
    def __get_from_email(self) -> str:
        config = self.__get_default_email_config()
        return self.email_from or config.email_from or config.smtp_user
    
    def __get_from_name(self) -> str:
        config = self.__get_default_email_config()
        return self.email_from_name or config.email_from_name or config.smtp_user
    
    def __get_random_tmp_file_path(self) -> str:
        today = datetime.now().strftime("%Y-%m-%d")
        now = datetime.now().strftime("%H%M%S")
        random_hex = secrets.token_hex(10)
        return f"/tmp/eml-{today}-{now}-{random_hex}"