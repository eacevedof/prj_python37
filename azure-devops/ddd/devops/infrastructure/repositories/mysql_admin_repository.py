import asyncio
from typing import final, Self, Any

from ddd.shared.infrastructure.components.logger import Logger


@final
class MysqlAdminRepository:
    """Repository for MySQL administration operations via Docker."""

    _logger: Logger
    _container_name: str
    _mysql_user: str
    _mysql_password: str

    def __init__(self) -> None:
        self._logger = Logger.get_instance()
        self._container_name = "cont-lr-mysql"
        self._mysql_user = "root"
        self._mysql_password = "root"

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def execute_query(
        self,
        database: str,
        query: str,
    ) -> dict[str, Any]:
        """Execute a MySQL query via Docker exec and return results as JSON."""
        self._logger.write_info(
            module="MysqlAdminRepository.execute_query",
            message=f"Executing query on database: {database or '(no database)'} - query: {query[:100]}",
        )

        cmd_args = [
            "docker",
            "exec",
            self._container_name,
            "mysql",
            f"-u{self._mysql_user}",
            f"-p{self._mysql_password}",
            "--batch",
            "--raw",
            "-e",
            query,
        ]

        if database:
            cmd_args.insert(-2, database)

        try:
            process = await asyncio.create_subprocess_exec(
                *cmd_args,
                stdout=asyncio.subprocess.PIPE,
                stderr=asyncio.subprocess.PIPE,
            )
            stdout, stderr = await process.communicate()

            if process.returncode != 0:
                error_msg = stderr.decode("utf-8", errors="replace").strip()
                if "Warning: Using a password" in error_msg:
                    lines = error_msg.split("\n")
                    error_msg = "\n".join(
                        line
                        for line in lines
                        if "Warning: Using a password" not in line
                    ).strip()

                self._logger.write_error(
                    module="MysqlAdminRepository.execute_query",
                    message=f"Query failed: {error_msg}",
                    context={"query": query, "database": database},
                )
                return {
                    "success": False,
                    "message": error_msg or "Query execution failed",
                    "data": [],
                    "row_count": 0,
                }

            output = stdout.decode("utf-8", errors="replace").strip()
            data = self._parse_mysql_output(output)

            return {
                "success": True,
                "message": f"Query executed successfully. {len(data)} rows returned.",
                "data": data,
                "row_count": len(data),
            }

        except FileNotFoundError:
            error_msg = (
                "Docker command not found. Ensure Docker is installed and in PATH."
            )
            self._logger.write_error(
                module="MysqlAdminRepository.execute_query",
                message=error_msg,
            )
            return {
                "success": False,
                "message": error_msg,
                "data": [],
                "row_count": 0,
            }
        except Exception as e:
            self._logger.write_error(
                module="MysqlAdminRepository.execute_query",
                message=f"Unexpected error: {str(e)}",
                context={"query": query, "database": database},
            )
            return {
                "success": False,
                "message": f"Unexpected error: {str(e)}",
                "data": [],
                "row_count": 0,
            }

    def _parse_mysql_output(self, output: str) -> list[dict[str, Any]]:
        """Parse MySQL batch output (tab-separated) into list of dicts."""
        if not output:
            return []

        lines = output.split("\n")
        if len(lines) < 1:
            return []

        headers = lines[0].split("\t")
        data = []

        for line in lines[1:]:
            if not line.strip():
                continue
            values = line.split("\t")
            row: dict[str, str | None] = {}
            for i, header in enumerate(headers):
                value = values[i] if i < len(values) else ""
                row[header] = None if value == "NULL" else value
            data.append(row)

        return data

    async def check_connection(self) -> dict[str, Any]:
        """Check if MySQL connection via Docker is working."""
        result = await self.execute_query(
            database="",
            query="SELECT 1 AS connection_test",
        )
        return {
            "connected": result["success"],
            "message": "Connection successful"
            if result["success"]
            else result["message"],
        }
