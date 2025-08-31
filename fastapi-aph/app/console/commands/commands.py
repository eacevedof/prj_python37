"""Command registry mapping command names to their module paths"""

COMMANDS = {
    # Devops commands
    "lz:deploy": "app.console.commands.devops.lz_deploy_command",
    "lz:check-app": "app.console.commands.devops.lz_check_app_command", 
    "lz:check-ftp": "app.console.commands.devops.lz_check_ftp_command",
    
    # Checker commands
    "lz:check-email": "app.console.commands.checkers.lz_check_email_command",
    
    # ETL commands
    "lz:etl-risky-domains": "app.console.commands.etl.etl_risky_domains_command",
    "lz:etl-refresh-redis": "app.console.commands.etl.etl_refresh_domains_in_redis_command",
}