from aws_cdk import (
    Stack,
    aws_lambda as _lambda,
    aws_lambda_event_sources as eventsources,
    aws_s3 as s3
)
from constructs import Construct

class PostgresSync(Stack):

    def __init__(self, scope: Construct, construct_id: str, **kwargs) -> None:
        super().__init__(scope, construct_id, **kwargs)
        stack_lambda = _lambda.DockerImageFunction(
            self, 
            'PostgresSync', 
            code=_lambda.DockerImageCode.from_image_asset('cdk_dev/resources/docker/postgres-sync/')
            )

        bucket = s3.Bucket(
            self, 
            "postgres-sync",
            block_public_access=s3.BlockPublicAccess.BLOCK_ALL
            )
        
        stack_lambda.add_event_source(
            eventsources.S3EventSource(
                bucket,
                events=[
                    s3.EventType.OBJECT_CREATED
                    ]
        ))
        # The code that defines your stack goes here

        # example resource
        # queue = sqs.Queue(
        #     self, "CdkDevQueue",
        #     visibility_timeout=Duration.seconds(300),
        # )
