#!/usr/bin/env python3
from multiprocessing import context
import os

import aws_cdk as cdk

# from cdk_dev.cdk_dev_stack import PostgresSync
from cdk_dev.s3 import S3Stack
from cdk_dev.step_function import SFN
app = cdk.App(context="cdk.json")
# PostgresSync(app, "CdkDevStack")
S3Stack(app, 'S3Stack')
SFN(app, 'SFNStack')
app.synth()
