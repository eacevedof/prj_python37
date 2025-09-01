import asyncio
import os
from pathlib import Path

from app.shared.infrastructure.components.ftper.ftper_credentials_type import FtperCredentialsType


class Ftper:
    def __init__(self, credentials: FtperCredentialsType):
        self.is_ftps = credentials.is_ftps if credentials.is_ftps is not None else True
        self.host = credentials.host
        self.port = credentials.port
        self.user = credentials.user
        self.password = credentials.password
    
    @staticmethod
    def get_instance(credentials: FtperCredentialsType):
        return Ftper(credentials)
    
    async def upload_file(self, local_file_path: str, remote_file_path: str) -> None:
        self.__fail_if_no_credentials()
        
        if self.is_ftps:
            ftp_command = f"""
            sftp -oPort={self.port} -i {Path.cwd()}/.ssh/sftp-key {self.user}@{self.host} <<EOF
            rm {remote_file_path}
            put {local_file_path} {remote_file_path}
            chmod 644 {remote_file_path}
            bye
            EOF
            """
        else:
            ftp_command = f"""
            ftp -inv {self.host} {self.port} <<EOF
            user {self.user} {self.password}
            delete {remote_file_path}
            put {local_file_path} {remote_file_path}
            site chmod 644 {remote_file_path}
            bye
            EOF
            """
        
        print(f"upload_file command: {ftp_command}")
        
        try:
            process = await asyncio.create_subprocess_shell(
                ftp_command,
                stdout=asyncio.subprocess.PIPE,
                stderr=asyncio.subprocess.PIPE
            )
            stdout, stderr = await process.communicate()
            
            if process.returncode != 0:
                error_msg = stderr.decode() if stderr else "Unknown error"
                print(f"error: {error_msg}")
                raise Exception(f"Ftper: failed uploading: {local_file_path} into {remote_file_path}")
                
        except Exception as e:
            raise Exception(f"Ftper: failed uploading: {local_file_path} into {remote_file_path}") from e
    
    def __fail_if_no_credentials(self) -> None:
        if not self.host or not self.user or not self.password:
            raise Exception("Ftper: credentials are not set")