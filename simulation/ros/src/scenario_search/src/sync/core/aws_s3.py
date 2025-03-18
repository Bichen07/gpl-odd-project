import boto3

AWS_ACCESS_KEY_ID = 'AKIAZYUVAUFLQWHZUNFB'
AWS_SECRET_ACCESS_KEY = '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'

# Singleton for PushModule & PullModule
s3_client = boto3.client(
    's3',
    aws_access_key_id=AWS_ACCESS_KEY_ID,
    aws_secret_access_key=AWS_SECRET_ACCESS_KEY,
)
