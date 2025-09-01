import subprocess
import asyncio
from typing import Dict, Union


class Systemer:
    @staticmethod
    def get_instance():
        return Systemer()
    
    async def run_command(self, command: str) -> Dict[str, Union[str, int]]:
        return await self.__run_subprocess_command(command)
    
    async def __run_subprocess_command(self, command: str) -> Dict[str, Union[str, int]]:
        try:
            process = await asyncio.create_subprocess_shell(
                command,
                stdout=asyncio.subprocess.PIPE,
                stderr=asyncio.subprocess.PIPE
            )
            stdout, stderr = await process.communicate()
            
            return {
                "stdout": stdout.decode().strip(),
                "stderr": stderr.decode().strip(),
                "status": process.returncode or 0
            }
        except Exception as e:
            return {
                "stdout": "",
                "stderr": str(e),
                "status": 1
            }
    
    async def run_command_nohup(self, command: str) -> None:
        cmd_async = f"nohup {command} > /dev/null 2>&1 &"
        result = await self.__run_subprocess_command(cmd_async)
        print(f"run_command_nohup executed: {cmd_async} output: {result}")