from pprint import pprint
from datetime import datetime
import json


def fn_b(event, context):
    now = datetime.utcnow().strftime("%Y-%m-%d-%H:%M:%S")
    eventjson = json.dumps(event)
    return {
        "event": f"input event:\n {eventjson}",
        "sucess": f"This is a successfully response from Lambda B {now}",
    }
