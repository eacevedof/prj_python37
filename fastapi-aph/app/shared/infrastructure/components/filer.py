import os
import asyncio
import aiofiles
from pathlib import Path
from typing import List, Optional
import httpx


class Filer:
    """File operations utility class"""
    
    @classmethod
    def get_instance(cls) -> 'Filer':
        return cls()
    
    async def does_file_exist(self, path_file: str) -> bool:
        """Check if a file exists"""
        try:
            path = Path(path_file)
            return path.exists() and path.is_file()
        except Exception as e:
            print(f"File does not exist: {path_file}, error: {e}")
            return False
    
    async def file_put_contents(self, path_file: str, str_data: str) -> None:
        """Write string data to a file"""
        async with aiofiles.open(path_file, 'w') as f:
            await f.write(str_data)
    
    async def file_get_content(self, path_file: str) -> str:
        """Read file content as string"""
        if not await self.does_file_exist(path_file):
            return ""
        
        async with aiofiles.open(path_file, 'r') as f:
            return await f.read()
    
    async def get_files_in_directory(self, path: str) -> List[str]:
        """Get list of files in a directory"""
        files = []
        try:
            path_obj = Path(path)
            if path_obj.exists() and path_obj.is_dir():
                for item in path_obj.iterdir():
                    if item.is_file():
                        files.append(item.name)
        except Exception as e:
            print(f"Error reading directory {path}: {e}")
        
        return files
    
    async def download_file(self, http_url: str, target_path: str) -> None:
        """Download file from HTTP URL"""
        print(f"Downloading file via httpx: {http_url} to {target_path}")
        
        async with httpx.AsyncClient() as client:
            response = await client.get(http_url)
            response.raise_for_status()
            
            async with aiofiles.open(target_path, 'wb') as f:
                await f.write(response.content)
    
    async def download_file_via_tunnel(self, http_url: str, target_path: str) -> None:
        """Download file via SSH tunnel (for blocked IPs)"""
        print(f"Downloading file via tunnel: {http_url} to {target_path}")
        
        # Get tunnel configuration from environment
        tunnel_server = os.getenv('APP_TUNNEL_SERVER')
        tunnel_port = os.getenv('APP_TUNNEL_PORT')
        tunnel_user = os.getenv('APP_TUNNEL_USER')
        tunnel_key_file = os.getenv('APP_TUNNEL_KEY_FILE')
        
        if not all([tunnel_server, tunnel_port, tunnel_user, tunnel_key_file]):
            raise Exception(
                f"Tunnel configuration is missing. Required: "
                f"APP_TUNNEL_SERVER, APP_TUNNEL_PORT, APP_TUNNEL_USER, APP_TUNNEL_KEY_FILE. "
                f"server={tunnel_server}, port={tunnel_port}, user={tunnel_user}, keyFile={tunnel_key_file}"
            )
        
        ssh_command = (
            f'ssh {tunnel_user}@{tunnel_server} -i {tunnel_key_file} '
            f'-o Port={tunnel_port} -o StrictHostKeyChecking=no '
            f'"wget -O - {http_url}" > {target_path}'
        )
        
        print("download_file_via_tunnel command:", ssh_command)
        
        proc = await asyncio.create_subprocess_shell(
            ssh_command,
            stdout=asyncio.subprocess.PIPE,
            stderr=asyncio.subprocess.PIPE
        )
        
        stdout, stderr = await proc.communicate()
        
        if proc.returncode != 0:
            error_msg = stderr.decode()
            print(f"Error: {error_msg}")
            raise Exception(f"SSH tunnel download failed: {http_url} to {target_path}")
    
    async def unlink_file(self, path_file: str) -> None:
        """Delete a file"""
        if not await self.does_file_exist(path_file):
            print(f"Warning: file does not exist, cannot unlink: {path_file}")
            return
        
        try:
            os.remove(path_file)
        except Exception as e:
            print(f"Error deleting file {path_file}: {e}")