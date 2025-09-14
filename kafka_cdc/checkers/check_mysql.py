# python -m checkers.check_mysql

import pymysql

from config import die, err, logger
from config.mysql_config import MYSQLS

def __test_mysql_connection(mysql_id: str ="my-1") -> None:
    """Test MySQL connection using MYSQLS configuration"""
    try:
        mysql_config = MYSQLS.get(mysql_id)
        if not mysql_config:
            logger.error(f"MySQL configuration \"{mysql_id}\" not found")
            return

        print(f"Testing connection to MySQL: {mysql_id}")
        print(f"Host: {mysql_config["host"]}:{mysql_config["port"]}")
        print(f"Database: {mysql_config["database"]}")
        print(f"User: {mysql_config["user"]}")

        pymysql_cnx = pymysql.connect(
            host=mysql_config["host"],
            port=mysql_config["port"],
            user=mysql_config["user"],
            password=mysql_config["password"],
            database=mysql_config["database"],
            charset="utf8mb4"
        )

        with pymysql_cnx.cursor() as cursor:
            # Test basic connection
            cursor.execute("SELECT VERSION()")
            version = cursor.fetchone()
            logger.info(f"MySQL connection successful. Version: {version[0]}")

            # Test database
            cursor.execute("SELECT DATABASE()")
            database = cursor.fetchone()
            logger.info(f"Connected to database: {database[0]}")

            # Check tables from config
            tables_to_monitor = mysql_config.get("tables_to_monitor", {})
            if tables_to_monitor:
                print("\nChecking monitored tables:")
                for table_name, timestamp_col in tables_to_monitor.items():
                    cursor.execute("SHOW TABLES LIKE %s", (table_name,))
                    if cursor.fetchone():
                        cursor.execute(f"SELECT COUNT(*) FROM {table_name}")
                        count = cursor.fetchone()[0]
                        print(f"✓ Table \"{table_name}\" exists with {count} records")

                        # Check timestamp column
                        cursor.execute(f"SHOW COLUMNS FROM {table_name} LIKE %s", (timestamp_col,))
                        if cursor.fetchone():
                            print(f"  ✓ Timestamp column \"{timestamp_col}\" exists")
                        else:
                            print(f"  ✗ Timestamp column \"{timestamp_col}\" NOT found")
                    else:
                        print(f"✗ Table \"{table_name}\" does NOT exist")

        pymysql_cnx.close()
        print("\n✅ MySQL connection test successful!")
    except Exception as e:
        logger.error(f"MySQL connection failed: {e}")
        print(f"❌ MySQL connection test failed: {e}")


def __show_mysql_configs() -> None:
    """Show all available MySQL configurations"""
    print("Available MySQL configurations:")
    print("=" * 50)
    for mysql_id, config in MYSQLS.items():
        print(f"\nID: {mysql_id}")
        print(f"  Host: {config["host"]}:{config["port"]}")
        print(f"  Database: {config["database"]}")
        print(f"  User: {config["user"]}")
        print(f"  Tables: {list(config.get("tables_to_monitor", {}).keys())}")


if __name__ == "__main__":
    print("MySQL Connection Checker")
    print("=" * 30)
    
    __show_mysql_configs()
    print("\n" + "=" * 50)
    
    # Test all MySQL configurations
    for mysql_id in MYSQLS.keys():
        print(f"\nTesting MySQL configuration: {mysql_id}")
        __test_mysql_connection(mysql_id)
        print("-" * 30)

