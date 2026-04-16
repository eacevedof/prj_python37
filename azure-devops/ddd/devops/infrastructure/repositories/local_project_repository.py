import asyncio
import re
from typing import final, Self
from pathlib import Path

from ddd.shared.infrastructure.components.logger import Logger


@final
class LocalProjectRepository:
    """Repository for local project setup operations."""

    _logger: Logger

    def __init__(self) -> None:
        self._logger = Logger.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def get_next_available_port(self, vhosts_file: str) -> int:
        """Detect the next available port from ci-apps.conf."""
        vhosts_path = Path(vhosts_file)
        content = vhosts_path.read_text(encoding="utf-8")
        ports = [int(m.group(1)) for m in re.finditer(r"Listen (\d+)", content)]

        if not ports:
            return 8080

        return max(ports) + 1

    async def clone_repository(
        self, www_path: str, repo_url: str, project_name: str
    ) -> str:
        """Clone a repository to the www directory."""
        app_folder = f"app-{project_name}"
        app_path = Path(www_path) / app_folder

        if app_path.exists():
            self._logger.write_info(
                module="LocalProjectRepository.clone_repository",
                message=f"Folder already exists: {app_path}",
            )
            return str(app_path)

        process = await asyncio.create_subprocess_exec(
            "git",
            "clone",
            repo_url,
            app_folder,
            cwd=www_path,
            stdout=asyncio.subprocess.PIPE,
            stderr=asyncio.subprocess.PIPE,
        )
        _, stderr = await process.communicate()

        if process.returncode != 0:
            raise RuntimeError(f"Failed to clone repository: {stderr.decode()}")

        return str(app_path)

    async def add_virtualhost(
        self, vhosts_file: str, project_name: str, port: int
    ) -> None:
        """Add VirtualHost configuration to ci-apps.conf."""
        app_folder = f"app-{project_name}"
        server_name = f"local-{port}"

        vhost_config = f"""
# {project_name}
Listen {port}
TimeOut 900
<VirtualHost *:{port}>
    ServerName {server_name}
    DocumentRoot /var/www/{app_folder}/html

    <Directory /var/www/{app_folder}/html>
        AllowOverride All
        Require all granted
        DirectoryIndex index.php
    </Directory>

    <FilesMatch \\.php$>
        SetHandler "proxy:fcgi://php-fpm-7.4:9000"
    </FilesMatch>

    <IfModule mod_rewrite.c>
        RewriteEngine On
        RewriteCond %{{HTTP:Authorization}} ^(.*)
        RewriteRule .* - [e=HTTP_AUTHORIZATION:%1]
        RewriteRule ^/template/(.*\\.html)$ http://host.docker.internal:{port}/template/$1 [P,L]
    </IfModule>

    RewriteEngine On
    RewriteRule ^/assets/plugins/(.*)$ /ci-commons/plugins/$1 [R=301,L]
</VirtualHost>
"""

        vhosts_path = Path(vhosts_file)
        content = vhosts_path.read_text(encoding="utf-8")

        if f"Listen {port}" in content:
            self._logger.write_info(
                module="LocalProjectRepository.add_virtualhost",
                message=f"Port {port} already exists in ci-apps.conf",
            )
            return

        with open(vhosts_path, "a", encoding="utf-8") as f:
            f.write(vhost_config)

    async def create_database(self, db_name: str) -> None:
        """Create MySQL database using Docker exec."""
        cmd = f"CREATE DATABASE IF NOT EXISTS `{db_name}` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"

        process = await asyncio.create_subprocess_exec(
            "docker",
            "exec",
            "cont-lr-mysql",
            "mysql",
            "-uroot",
            "-proot",
            "-e",
            cmd,
            stdout=asyncio.subprocess.PIPE,
            stderr=asyncio.subprocess.PIPE,
        )
        _, stderr = await process.communicate()

        if process.returncode != 0:
            raise RuntimeError(
                f"Failed to create database '{db_name}': {stderr.decode()}"
            )

    async def add_hosts_entry(
        self, hosts_file: str, port: int, project_name: str
    ) -> None:
        """Add entry to Windows hosts file."""
        server_name = f"local-{port}"
        host_entry = f"127.0.0.1 {server_name} #{port} {project_name}"

        hosts_path = Path(hosts_file)
        content = hosts_path.read_text(encoding="utf-8")

        if server_name in content:
            self._logger.write_info(
                module="LocalProjectRepository.add_hosts_entry",
                message=f"Host entry for {server_name} already exists",
            )
            return

        with open(hosts_path, "a", encoding="utf-8") as f:
            f.write(f"\n{host_entry}")

    async def create_env_file(
        self,
        www_path: str,
        base_env_file: str,
        project_name: str,
        port: int,
        db_name: str,
    ) -> str:
        """Create .env file based on plataformabase template."""
        app_folder = f"app-{project_name}"
        server_name = f"local-{port}"
        env_dest_path = Path(www_path) / app_folder / "html" / ".env"

        if env_dest_path.exists():
            self._logger.write_info(
                module="LocalProjectRepository.create_env_file",
                message=f".env file already exists: {env_dest_path}",
            )
            return str(env_dest_path)

        base_env_path = Path(base_env_file)
        content = base_env_path.read_text(encoding="utf-8")

        cookie_name = project_name.replace("-", "")

        replacements = {
            r"LAZARUS_BASE_URL=.*": f"LAZARUS_BASE_URL=http://{server_name}:{port}/",
            r"LAZARUS_DOMAIN=.*": f"LAZARUS_DOMAIN={server_name}",
            r"LAZARUS_COOKIE_NAME=.*": f"LAZARUS_COOKIE_NAME={cookie_name}",
            r"LAZARUS_DB_NAME=.*": f"LAZARUS_DB_NAME={db_name}",
            r"LAZARUS_LOG_PATH=.*": f"LAZARUS_LOG_PATH=/var/www/{app_folder}/logs/",
        }

        for pattern, replacement in replacements.items():
            content = re.sub(pattern, replacement, content)

        env_dest_path.parent.mkdir(parents=True, exist_ok=True)
        env_dest_path.write_text(content, encoding="utf-8")

        return str(env_dest_path)

    async def restart_apache(self, docker_lamp_path: str) -> None:
        """Restart Apache container using docker-compose."""
        process = await asyncio.create_subprocess_exec(
            "docker-compose",
            "restart",
            "apache",
            cwd=docker_lamp_path,
            stdout=asyncio.subprocess.PIPE,
            stderr=asyncio.subprocess.PIPE,
        )
        _, stderr = await process.communicate()

        if process.returncode != 0:
            raise RuntimeError(f"Failed to restart Apache: {stderr.decode()}")
