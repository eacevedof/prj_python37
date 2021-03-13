from pprint import pprint
import datetime
import json
import boto3
from botocore.config import Config


def invoke_fn_b(local=1):
  config_lambda = Config(retries={'total_max_attempts': 1}, read_timeout=1200)

    if local:
        return boto3.client(
            'lambda',
            config=config_lambda,
            #endpoint_url='http://host.docker.internal:3050',
            endpoint_url='http://localhost:3050',
            use_ssl=False,
            verify=False,
        )
    else:
        return  boto3.client(
            'lambda'
        )
...
    payload = json.dumps({
            "account_id": account_id
        })

    response = lambda_client.invoke(
        FunctionName=lambda_function,
        InvocationType='RequestResponse',
        #LogType='Tail',
        Payload=payload
    )

def fn_a(event, context):

    invoke_fn_b()
    now = datetime.utcnow().strftime("%Y-%m-%d-%H:%M:%S")
    eventjson = json.dumps(event)

    return {
        "event": f"input event:\n {eventjson}",
        "success": f"This is a response succes from Lambda A {now}",
    }
