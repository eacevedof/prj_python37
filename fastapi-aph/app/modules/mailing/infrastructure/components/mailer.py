import os
import smtplib
import subprocess
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
from typing import List, Dict, Any, Optional
from jinja2 import Template
from app.shared.infrastructure.components.logger import Logger

class MailSentResult:
    def __init__(self, success: bool, error: Optional[str] = None, tmp_random_file: Optional[str] = None):
        self.success = success
        self.error = error
        self.tmp_random_file = tmp_random_file

class Mailer:
    _instance = None
    
    def __new__(cls):
        if cls._instance is None:
            cls._instance = super(Mailer, cls).__new__(cls)
            cls._instance._initialize()
        return cls._instance
    
    def _initialize(self):
        self.logger = Logger.get_instance()
        self.email_to: List[str] = []
        self.email_cc: List[str] = []
        self.email_bcc: List[str] = []
        self.subject = ""
        self.body = ""
        self.template_vars: Dict[str, Any] = {}
        self.result: Optional[MailSentResult] = None
        
        # SMTP Configuration
        self.smtp_host = os.getenv("SMTP_HOST", "localhost")
        self.smtp_port = int(os.getenv("SMTP_PORT", "587"))
        self.smtp_username = os.getenv("SMTP_USERNAME", "")
        self.smtp_password = os.getenv("SMTP_PASSWORD", "")
        self.smtp_use_tls = os.getenv("SMTP_USE_TLS", "false").lower() == "true"
        self.from_email = os.getenv("SMTP_USERNAME", "no-reply@example.com")
    
    @classmethod
    def get_instance(cls):
        return cls()
    
    def set_email_to(self, email: str) -> "Mailer":
        self.email_to = [email]
        return self
    
    def add_email_cc(self, email: str) -> "Mailer":
        self.email_cc.append(email)
        return self
    
    def add_email_bcc(self, email: str) -> "Mailer":
        self.email_bcc.append(email)
        return self
    
    def set_subject(self, subject: str) -> "Mailer":
        self.subject = subject
        return self
    
    def set_default_tpl_vars(self, vars_dict: Dict[str, Any]) -> "Mailer":
        self.template_vars = vars_dict
        return self
    
    async def send_template(self):
        """Send email using template variables"""
        try:
            # Render template
            if "body" in self.template_vars:
                template = Template(self.template_vars["body"])
                self.body = template.render(**self.template_vars)
            
            await self._send_email_with_curl()
            
        except Exception as e:
            self.logger.log_error("Failed to send email", e)
            self.result = MailSentResult(success=False, error=str(e))
    
    async def _send_email_with_curl(self):
        """Send email using curl command (similar to Deno implementation)"""
        try:
            # Create email content
            email_content = f"""From: {self.from_email}
To: {', '.join(self.email_to)}"""
            
            if self.email_cc:
                email_content += f"\\nCc: {', '.join(self.email_cc)}"
            
            email_content += f"""
Subject: {self.subject}
Content-Type: text/html; charset=UTF-8

{self.body}
"""
            
            # Prepare curl command
            curl_command = [
                "curl",
                "--ssl-reqd",
                "--url", f"smtps://{self.smtp_host}:{self.smtp_port}",
                "--user", f"{self.smtp_username}:{self.smtp_password}",
                "--mail-from", self.from_email
            ]
            
            # Add recipients
            for recipient in self.email_to:
                curl_command.extend(["--mail-rcpt", recipient])
            
            for cc_recipient in self.email_cc:
                curl_command.extend(["--mail-rcpt", cc_recipient])
            
            # Execute curl command
            process = subprocess.run(
                curl_command,
                input=email_content,
                text=True,
                capture_output=True,
                timeout=30
            )
            
            if process.returncode == 0:
                self.result = MailSentResult(success=True)
                self.logger.log_info("Email sent successfully")
            else:
                error_message = process.stderr or f"Curl failed with return code {process.returncode}"
                self.result = MailSentResult(success=False, error=error_message)
                self.logger.log_error("Failed to send email via curl", Exception(error_message))
                
        except subprocess.TimeoutExpired:
            self.result = MailSentResult(success=False, error="Email sending timeout")
            self.logger.log_error("Email sending timeout")
        except Exception as e:
            self.result = MailSentResult(success=False, error=str(e))
            self.logger.log_error("Failed to send email via curl", e)
    
    def get_result(self) -> MailSentResult:
        return self.result or MailSentResult(success=False, error="No result available")