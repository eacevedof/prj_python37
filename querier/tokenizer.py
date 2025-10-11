import os
import pytz
from datetime import datetime
from nacl import pwhash
from printer import *

def get_auth_raw_token():
    return os.getenv("API_AUTH_RAW_TOKEN")

def get_anubis_auth_token():
    anubis_timezone = "Europe/Berlin"

    anubis_tz = pytz.timezone(anubis_timezone)
    today = datetime.now(anubis_tz).strftime("%Y-%m-%d")

    # Fix: Create timezone-aware datetime and convert to timestamp like PHP does
    today_datetime = datetime.strptime(today, "%Y-%m-%d")
    today_datetime = anubis_tz.localize(today_datetime)
    today_timestamp = int(today_datetime.timestamp())

    anubis_domain = os.getenv("API_ANUBIS_DOMAIN")
    anubis_salt_encrypt = os.getenv("API_ANUBIS_SALT")
    raw_token = f"{anubis_domain}{anubis_salt_encrypt}{today_timestamp}".encode("utf-8")
    #die(raw_token)

    auth_token = pwhash.str(
        raw_token,
        opslimit=pwhash.OPSLIMIT_INTERACTIVE,
        memlimit=pwhash.MEMLIMIT_INTERACTIVE
    ).decode("utf-8")

    # pr_white(auth_token)
    return auth_token