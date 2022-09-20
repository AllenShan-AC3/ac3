from aws_cdk import (
    Stack,
    aws_stepfunctions as sfn,
    aws_sns as sns,
    aws_stepfunctions_tasks as sfn_tasks
)
from constructs import Construct

class SFN(Stack):
    def __init__(self, scope: Construct, construct_id: str, **kwargs) -> None:
        super().__init__(scope, construct_id, **kwargs)

        my_topic = sns.Topic(self, "MyTopic")

        sns.Subscription(self, "Subscription",
            topic=my_topic,
            endpoint='allen.shan@outlook.com',
            protocol=sns.SubscriptionProtocol.EMAIL
        )

        publish_message = sfn_tasks.SnsPublish(self, "Publish Message",
        topic=my_topic,
        message = sfn.TaskInput.from_json_path_at("$.payload")
        )

        sfn.StateMachine(self, "StateMachine",
            definition=publish_message
        )