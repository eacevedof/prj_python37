import asyncio
import json
import os
import secrets
from datetime import datetime
from typing import Optional, final

from app.shared.infrastructure.components.date_timer import DateTimer
from app.shared.infrastructure.components.server import Server  
from app.shared.infrastructure.components.slugger import Slugger
from app.shared.infrastructure.enums.environment_enum import EnvironmentEnum
from app.shared.infrastructure.repositories.configuration.environment_reader_raw_repository import EnvironmentReaderRawRepository
from app.shared.infrastructure.repositories.configuration.env_var_type import EnvVarType

from app.modules.elastic.domain.enums.log_level_enum import LogLevelEnum
from app.modules.elastic.domain.types.elastic_meta_type import ElasticMetaType
from app.modules.elastic.domain.types.elastic_response_type import ElasticResponseType
from app.modules.elastic.domain.types.elastic_doc_type import ElasticDocType


@final
class ElasticWriterApiRepository:
    _instance: Optional['ElasticWriterApiRepository'] = None
    _date_timer: Optional[DateTimer] = None
    _env_vars: Optional[EnvVarType] = None
    _path_log_elk_file: str = ""
    _meta_data: Optional[ElasticMetaType] = None

    def __init__(self):
        pass

    @classmethod
    def get_instance(cls, meta_data: Optional[ElasticMetaType] = None) -> 'ElasticWriterApiRepository':
        if cls._instance:
            return cls._instance

        cls._date_timer = DateTimer.get_instance()
        cls._env_vars = EnvironmentReaderRawRepository.get_instance().get_env_vars()
        today = cls._date_timer.get_today()
        
        cls._path_log_elk_file = f"{cls._env_vars['log_paths']}/elk-{today}.log"
        cls._meta_data = meta_data
        
        cls._instance = cls()
        return cls._instance

    async def log_error(self, content: str) -> ElasticResponseType:
        """Log error level message"""
        post_payload = await self._get_elastic_document(content, LogLevelEnum.ERROR)
        return await self._get_post_request_async(post_payload)

    async def log_debug(self, content: str) -> ElasticResponseType:
        """Log debug level message"""
        post_payload = await self._get_elastic_document(content, LogLevelEnum.DEBUG)
        return await self._get_post_request_async(post_payload)

    async def log_sql(self, content: str) -> ElasticResponseType:
        """Log SQL level message"""
        post_payload = await self._get_elastic_document(content, LogLevelEnum.SQL)
        return await self._get_post_request_async(post_payload)

    async def log_security(self, content: str) -> ElasticResponseType:
        """Log security level message"""
        post_payload = await self._get_elastic_document(content, LogLevelEnum.SECURITY)
        return await self._get_post_request_async(post_payload)

    async def log_warning(self, content: str) -> ElasticResponseType:
        """Log warning level message"""
        post_payload = await self._get_elastic_document(content, LogLevelEnum.WARNING)
        return await self._get_post_request_async(post_payload)

    async def _get_elastic_document(self, log_content: str, log_level: LogLevelEnum) -> ElasticDocType:
        """Build Elasticsearch document from log content and level"""
        server_instance = Server.get_instance()
        server_ip = await server_instance.get_server_ip()
        
        elastic_doc: ElasticDocType = {
            "domain": self._env_vars["base_url"],
            "environment": self._env_vars["environment"],
            "level": log_level.value,
            "date_time": self._date_timer.get_now_ymd_his(),
            "server_ip": server_ip,
            "request_ip": self._meta_data["request_ip"] if self._meta_data else "",
            "request_uri": self._meta_data["request_uri"] if self._meta_data else "",
            "log_content": self._get_cleaned_log_content(log_content),
            "timestamp": datetime.utcnow().isoformat()
        }
        
        return elastic_doc

    def _get_cleaned_log_content(self, log_content: str) -> str:
        """Clean and truncate log content"""
        return self._substring_10000(log_content)

    def _substring_10000(self, text: str) -> str:
        """Truncate string to max 100000 characters"""
        max_len = 100000
        if len(text) <= max_len:
            return text
        return text[:max_len] + f"... [string truncated to {max_len} chars]"

    async def _get_post_request_async(self, post_payload: ElasticDocType) -> ElasticResponseType:
        """Send log data to Elasticsearch via curl command"""
        database_name = self._get_database_name()
        elastic_api_url = f"{self._env_vars['elastic_api_url']}/{database_name}/_doc"
        
        curl_command = await self._get_nohup_command_in_single_line({
            "elasticApiUrl": elastic_api_url,
            "postPayload": post_payload
        })
        
        await self._log_elk(post_payload, "get_post_request_async.post_payload")
        
        # Execute curl command using subprocess
        proc = await asyncio.create_subprocess_shell(
            curl_command,
            stdout=asyncio.subprocess.PIPE,
            stderr=asyncio.subprocess.PIPE
        )
        
        stdout, stderr = await proc.communicate()
        
        cmd_result: ElasticResponseType = {
            "stdout": stdout.decode().strip(),
            "stderr": stderr.decode().strip(),
            "status": proc.returncode or 0
        }
        
        return cmd_result

    async def _get_nohup_command_in_single_line(self, elastic_request: dict) -> str:
        """Build curl command with nohup for background execution"""
        json_payload = json.dumps(elastic_request["postPayload"])
        path_tmp_file = self._get_random_tmp_file_path()
        
        # Write JSON payload to temporary file
        with open(path_tmp_file, 'w') as f:
            f.write(json_payload)
        
        log_elk = self._path_log_elk_file
        
        nohup_parts = [
            f"nohup sh -c 'curl --silent --location --request POST",
            f"--max-time 60",
            f"--url \"{elastic_request['elasticApiUrl']}\"",
            f"--header \"Content-Type: application/json\"",
            f"--data-binary @{path_tmp_file}",
            f"&& sleep 10 && rm {path_tmp_file}' >> {log_elk} 2>&1 &"
        ]
        
        return " ".join(nohup_parts)

    def _get_database_name(self) -> str:
        """Get Elasticsearch database name based on environment and app name"""
        app_env = EnvironmentEnum(self._env_vars["environment"])
        app_name = self._env_vars["app_name"]
        db_name = f"{app_env.value}-{app_name}"
        db_slug = Slugger.get_instance().get_slugged_text(db_name)
        return db_slug[:250]

    async def _log_elk(self, mixed, title: str = "") -> None:
        """Write log entry to ELK log file"""
        log_elk_file = self._path_log_elk_file
        now = self._date_timer.get_now_ymd_his()
        content = f"[{now}]"
        
        if title:
            content += f" {title}\n\t"
        
        if not isinstance(mixed, str):
            try:
                content += json.dumps(mixed, indent=2, default=str)
            except Exception:
                content += str(mixed)
        else:
            content += mixed
            
        content += "\n"
        
        try:
            # Ensure log directory exists
            os.makedirs(os.path.dirname(log_elk_file), exist_ok=True)
            with open(log_elk_file, 'a') as f:
                f.write(content)
        except Exception as e:
            print(f"ElasticWriterApiRepository._log_elk error: {e}")

    def _get_random_tmp_file_path(self) -> str:
        """Generate random temporary file path for curl data"""
        today = self._date_timer.get_today()
        random_hex = secrets.token_hex(10)
        return f"/tmp/elk-{today}-{random_hex}"