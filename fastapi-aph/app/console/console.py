#!/usr/bin/env python3
"""
Console command runner for the APH application
Usage: python -m app.console.console <command-name>
"""

import asyncio
import importlib
import sys
from typing import Optional

from app.shared.infrastructure.components.date_timer import DateTimer
from app.shared.infrastructure.components.logger import Logger
from app.shared.infrastructure.components.server import Server
from app.shared.infrastructure.components.cli.lz_cli_args import LzCliArgs
from app.shared.infrastructure.components.cli.cli_color import CliColor
from app.console.commands.commands import COMMANDS


async def main():
    """Main console command runner"""
    lz_cli_args = LzCliArgs.get_instance()
    date_timer = DateTimer.get_instance()
    
    now = date_timer.get_now_ymd_his()
    CliColor.echo_green(f"[{now}] command: running Python console commands")
    
    # Get the command name
    lz_command = lz_cli_args.get_arg(0)
    
    # Check if command exists
    lz_command_namespace = COMMANDS.get(lz_command)
    if not lz_command_namespace:
        CliColor.die_red(f"[{now}] command: \"{lz_command}\" not found.")
    
    # Initialize logger with server metadata
    server = Server.get_instance()
    server_ip = await server.get_server_ip()
    
    Logger.get_instance({
        "request_ip": server_ip,
        "request_uri": lz_command_namespace,
    })
    
    now = date_timer.get_now_ymd_his()
    print(f"[{now}] command: trying to run \"{lz_command_namespace}\"")
    
    try:
        # Dynamically import and instantiate the command
        module = importlib.import_module(lz_command_namespace)
        
        # Get the command class (assume class name is the module name in PascalCase)
        class_name = "".join(word.capitalize() for word in lz_command_namespace.split(".")[-1].split("_"))
        command_class = getattr(module, class_name)
        
        # Execute the command
        command_instance = command_class.get_instance()
        await command_instance.invoke(lz_cli_args)
        
    except Exception as error:
        error_message = str(error)
        
        logger = Logger.get_instance()
        await logger.log_exception(error, "console.py")
        
        now = date_timer.get_now_ymd_his()
        print(f"Error: {error}", file=sys.stderr)
        CliColor.die_red(f"[{now}] command: error \"{lz_command_namespace}\": {error_message}")


if __name__ == "__main__":
    asyncio.run(main())