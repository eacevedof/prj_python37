from pprint import pprint
import boto3
from botocore.config import Config


def invoke_fn_b():
    #https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/sam-cli-command-reference-sam-local-start-lambda.html
    config_lambda = Config(retries={'total_max_attempts': 1}, read_timeout=1200)
    pprint(config_lambda)
    lambda_client = boto3.client('lambda',
                             config=config_lambda,
                             endpoint_url='http://docker.for.mac.localhost:3050')
    lambda_client.invoke(
        FunctionName='BFunction',
        InvocationType='RequestResponse',
        Payload='some_data'.encode('UTF-8')
    )

def fn_a(event, context):
    pprint(event)
    pprint(context)

    #invoke_fn_b()

    return (
        "Hello im function A",
    )
