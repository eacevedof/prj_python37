import asyncio
from pathlib import Path
from typing import Dict

from app.shared.infrastructure.components.mailer.mail_sent_result_type import MailSentResultType


class MailResult:
    def __init__(self):
        self.result_logs: Dict[str, str] = {}
        self.sent_result = MailSentResultType(
            success=False,
            error="",
            tmp_random_file=""
        )
    
    @staticmethod
    def get_instance():
        return MailResult()
    
    async def get_sent_result(self, result_logs: Dict[str, str]) -> MailSentResultType:
        self.result_logs = result_logs
        self.sent_result.tmp_random_file = result_logs["tmp_trace_log_path"]
        
        # Read and parse the trace
        trace_result = await self.__get_email_trace_content()
        self.__load_sent_result_by_trace_result(trace_result)
        
        return self.sent_result
    
    async def __get_email_trace_content(self) -> str:
        try:
            log_path = Path(self.result_logs["email_log_path"])
            if not log_path.exists():
                return ""
            
            log_content = log_path.read_text()
            start_marker = f"[{self.result_logs['tmp_trace_log_path']}][start]"
            end_marker = f"[{self.result_logs['tmp_trace_log_path']}][end]"
            
            start_index = log_content.find(start_marker)
            end_index = log_content.find(end_marker)
            
            if start_index == -1:
                return ""
            if end_index == -1:
                return log_content[start_index:]
            
            return log_content[start_index:end_index + len(end_marker)]
        except Exception as e:
            print(f"Failed to read trace from log file: {self.result_logs['email_log_path']}\n{e}")
            return ""
    
    def __load_sent_result_by_trace_result(self, trace_result: str) -> None:
        if not trace_result:
            self.sent_result.error = "No trace result found"
            return
        
        start_marker = f"[{self.result_logs['tmp_trace_log_path']}][start]"
        end_marker = f"[{self.result_logs['tmp_trace_log_path']}][end]"
        
        has_start_marker = start_marker in trace_result
        has_end_marker = end_marker in trace_result
        
        if not has_start_marker:
            self.sent_result.error = "Email sending process did not start properly"
            return
        
        if not has_end_marker:
            self.sent_result.error = "Email sending process did not complete - may still be running or failed"
            return
        
        # Check for success indicators in SMTP protocol
        success_indicators = [
            "< 235 2.0.0 OK",           # Authentication success
            "< 250 2.1.0 Ok",           # MAIL FROM accepted
            "< 250 2.1.5 Ok",           # RCPT TO accepted
            "< 250 2.0.0 Ok: queued"    # Message queued (success)
        ]
        
        has_all_success_indicators = all(indicator in trace_result for indicator in success_indicators)
        
        # Check for common error indicators
        error_indicators = [
            "< 5",                      # 5xx SMTP error codes
            "* Connection refused",     # Connection errors
            "* SSL certificate problem", # SSL/TLS errors
            "* Authentication failure", # Auth errors
            "* Timeout",               # Timeout errors
        ]
        
        has_error_indicators = any(indicator in trace_result for indicator in error_indicators)
        
        if has_all_success_indicators and not has_error_indicators:
            self.sent_result.success = True
            self.sent_result.error = ""
            
            # Extract queue ID if available
            import re
            queue_match = re.search(r'< 250 2\.0\.0 Ok: queued as ([^\s\r\n]+)', trace_result)
            if queue_match:
                print(f"Email successfully queued with ID: {queue_match.group(1)}")
        else:
            # Extract error details
            trace_lines = trace_result.split('\n')
            error_lines = [line for line in trace_lines if any(
                error_indicator in line for error_indicator in [
                    '< 5', '* Connection', '* SSL', '* Authentication', '* Timeout'
                ]
            )]
            
            if trace_lines:
                self.sent_result.error = trace_lines[-2] if len(trace_lines) > 1 else trace_lines[0]
            
            if error_lines:
                self.sent_result.error = self.__get_minified_error('; '.join(error_lines))
    
    def __get_minified_error(self, error: str) -> str:
        lines = error.split('\n')
        first_line = lines[0] if lines else error
        return first_line[:200] + "..." if len(first_line) > 200 else first_line