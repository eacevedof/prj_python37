import socket
import asyncio
from typing import Optional


class Server:
    _instance: Optional['Server'] = None

    def __init__(self) -> None:
        pass

    @classmethod
    def get_instance(cls) -> 'Server':
        if cls._instance is None:
            cls._instance = cls()
        return cls._instance

    def get_server_name(self) -> str:
        """Get the hostname of the server"""
        return socket.gethostname()

    async def get_server_ip(self) -> str:
        """Get the server IP address"""
        try:
            hostname = self.get_server_name()
            # Get IP address for hostname
            loop = asyncio.get_event_loop()
            ip_address = await loop.run_in_executor(
                None, socket.gethostbyname, hostname
            )
            return ip_address
        except Exception:
            return "error"