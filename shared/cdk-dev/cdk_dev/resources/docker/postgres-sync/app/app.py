import json
import boto3
import urllib.parse
import subprocess
import os
import botocore.config
import stat

# aws_config=botocore.config.Config(region_name=os.environ.get('AWS_REGION'))
# aws_access_key=os.environ.get('AWS_ACCESS_KEY_ID')
# aws_secret_key=os.environ.get('AWS_SECRET_ACCESS_KEY')
# aws_session_token=os.environ.get('AWS_SESSION_TOKEN')

# print(os.environ)
# s3 = boto3.resource('s3')
# secretsManager = boto3.client('secretsmanager', config=aws_config)

def handler(event, context):


    """ Get s3 bucket name and the key for the uploaded file """ 
    # bucket = event['Records'][0]['s3']['bucket']['name']
    # key = urllib.parse.unquote_plus(event['Records'][0]['s3']['object']['key'], encoding='utf-8')

    """ Download the uploaded file to /tmp folder """ 
    # backup_filepath = '/tmp' + key
    # s3.Object(bucket, key).download_file('/tmp/' + backup_filepath)

    """ Retrieve DB Credentials """
    secretName = os.environ.get('SECRET_NAME')
    secrets = json.loads(secretsManager.get_secret_value(SecretId=secretName)["SecretString"])
    host = secrets["DB_HOSTNAME"]
    port = 5432
    username = secrets["DB_USERNAME"]
    password = secrets["DB_PASSWORD"]

    pgpass_file_path = os.environ.get("HOME") + '/.pgpass'

    with open(pgpass_file_path, 'w') as pgpass:
        pgpass.write(":".join([str(item) for item in [host, port, "*", username, password]]))
    
    os.chmod(pgpass_file_path, stat.S_IRUSR | stat.S_IWUSR)

    """ Restore DB Backup to Destinatio DB """ 
    # backup_filepath = '/app/three_six_five.sql'
    # command_line = ["psql", "-h", host, "-p", port, "-U", username, "-f", backup_filepath]
    # subprocess.run(command_line)

    return {
        'message': 'Hello World'
    }
