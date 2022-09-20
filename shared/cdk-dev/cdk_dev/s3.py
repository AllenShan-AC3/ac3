from aws_cdk import (
    Stack,
    aws_s3 as s3,
    RemovalPolicy
)
from constructs import Construct

class S3Stack(Stack):
    def __init__(self, scope: Construct, construct_id: str, **kwargs) -> None:
        super().__init__(scope, construct_id, **kwargs)

        bucket = s3.Bucket(
            self, 
            "postgres-sync",
            block_public_access=s3.BlockPublicAccess.BLOCK_ALL
            )
        bucket.apply_removal_policy(RemovalPolicy.DESTROY)