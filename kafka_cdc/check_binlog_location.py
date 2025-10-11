#!/usr/bin/env python3

import pymysql
from config.mysql_config import MYSQLS

def check_binlog_location(mysql_id="my-1"):
    """Check where MySQL binlog files are stored"""
    
    mysql_config = MYSQLS.get(mysql_id)
    if not mysql_config:
        print(f"MySQL configuration '{mysql_id}' not found")
        return
    
    try:
        conn = pymysql.connect(
            host=mysql_config['host'],
            port=mysql_config['port'],
            user=mysql_config['user'],
            password=mysql_config['password'],
            charset='utf8mb4'
        )
        
        with conn.cursor() as cursor:
            print(f"MySQL Binlog Location Information")
            print("=" * 50)
            
            # Check data directory
            cursor.execute("SHOW VARIABLES LIKE 'datadir'")
            datadir = cursor.fetchone()
            if datadir:
                print(f"MySQL Data Directory: {datadir[1]}")
            
            # Check binlog base name
            cursor.execute("SHOW VARIABLES LIKE 'log_bin_basename'")
            log_bin_basename = cursor.fetchone()
            if log_bin_basename:
                print(f"Binlog Base Name: {log_bin_basename[1]}")
            
            # Check binlog directory
            cursor.execute("SHOW VARIABLES LIKE 'log_bin_dirname'")
            log_bin_dirname = cursor.fetchone()
            if log_bin_dirname:
                print(f"Binlog Directory: {log_bin_dirname[1]}")
            
            # Show current binlog files
            cursor.execute("SHOW BINARY LOGS")
            binlogs = cursor.fetchall()
            if binlogs:
                print(f"\nCurrent Binary Log Files:")
                print("-" * 30)
                total_size = 0
                for binlog in binlogs:
                    file_name = binlog[0]
                    file_size = binlog[1]
                    size_mb = file_size / (1024 * 1024)
                    total_size += file_size
                    print(f"  {file_name:<20} {size_mb:>8.2f} MB")
                
                print(f"  {'Total:':<20} {total_size/(1024*1024):>8.2f} MB")
            
            # Show binlog format and retention
            cursor.execute("SHOW VARIABLES LIKE 'binlog_format'")
            binlog_format = cursor.fetchone()
            if binlog_format:
                print(f"\nBinlog Format: {binlog_format[1]}")
            
            cursor.execute("SHOW VARIABLES LIKE 'expire_logs_days'")
            expire_logs_days = cursor.fetchone()
            if expire_logs_days:
                print(f"Binlog Retention (days): {expire_logs_days[1]}")
            
            cursor.execute("SHOW VARIABLES LIKE 'binlog_expire_logs_seconds'")
            expire_logs_seconds = cursor.fetchone()
            if expire_logs_seconds:
                retention_days = int(expire_logs_seconds[1]) / (24 * 3600) if expire_logs_seconds[1] != '0' else 0
                print(f"Binlog Retention (seconds): {expire_logs_seconds[1]} ({retention_days:.1f} days)")
            
            # Show max binlog size
            cursor.execute("SHOW VARIABLES LIKE 'max_binlog_size'")
            max_binlog_size = cursor.fetchone()
            if max_binlog_size:
                max_size_mb = int(max_binlog_size[1]) / (1024 * 1024)
                print(f"Max Binlog Size: {max_size_mb:.0f} MB")
            
            # Show current master status
            cursor.execute("SHOW MASTER STATUS")
            master_status = cursor.fetchone()
            if master_status:
                print(f"\nCurrent Master Status:")
                print(f"  Current File: {master_status[0]}")
                print(f"  Current Position: {master_status[1]:,}")
                if len(master_status) > 2 and master_status[2]:
                    print(f"  Binlog_Do_DB: {master_status[2]}")
                if len(master_status) > 3 and master_status[3]:
                    print(f"  Binlog_Ignore_DB: {master_status[3]}")
        
        conn.close()
        
        # For Docker setup, show volume mapping
        print(f"\n" + "=" * 50)
        print("Docker Volume Information:")
        print("In your docker-compose.yml, MySQL volumes are:")
        print("  - ./mysql/mysql:/var/lib/mysql")
        print("  - ./mysql/initdb:/docker-entrypoint-initdb.d/")
        print(f"\nSo binlog files are stored in:")
        print(f"  Host: C:\\projects\\prj_docker_lamp\\mysql\\mysql\\")
        print(f"  Container: /var/lib/mysql/")
        
    except Exception as e:
        print(f"Error checking binlog location: {e}")

if __name__ == "__main__":
    check_binlog_location()