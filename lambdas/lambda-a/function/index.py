from pprint import pprint
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
    pprint(r)


def fn_a(event, context):
    print("\n")
    pprint(event)
    print("\n")
    pprint(context)
    print("\n")
    invoke_fn_b()
    print("\n\n")
    return (
        "Hello im function A",
    )
