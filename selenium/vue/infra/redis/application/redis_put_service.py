from datetime import datetime, timedelta
import os
import redis
import logging

logging.basicConfig(level=logging.INFO)


def put_random_values():
    pr = """
    =============
    PRODUCER
    =============
    """
    print(pr)
    objredis = redis.Redis(host=os.getenv("REDIS_SERVER"), port=os.getenv("REDIS_PORT"), db=0)
    for i in range(0, 99):
        key = f"id-{i}"
        ttl = i + 50
        now = datetime.now()
        strnow = now.strftime("%Y-%m-%d %H:%M:%S")
        enddate = (now + timedelta(seconds=ttl)).strftime("%H:%M:%S")
        value = f"some python value in string {strnow} - {enddate}"
        print(f"{key}:{value}")
        objredis.set(key, value)
        objredis.expire(key, ttl)
