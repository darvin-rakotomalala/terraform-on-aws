import json
import os
import boto3

dynamodb = boto3.resource('dynamodb')

def handler(event, context):
    table_name = os.environ.get('DYNAMODB_TABLE_NAME')
    table = dynamodb.Table(table_name)

    for record in event['Records']:
        bucket_name = record['s3']['bucket']['name']
        object_key = record['s3']['object']['key']
        event_time = record['eventTime']

        item = {
            'id': f"{bucket_name}-{object_key}-{event_time}", # Unique ID for DynamoDB
            'bucket_name': bucket_name,
            'object_key': object_key,
            'event_time': event_time,
            'event_name': record['eventName']
        }

        table.put_item(Item=item)
        print(f"Saved S3 event for object: {object_key} to DynamoDB.")

    return {
        'statusCode': 200,
        'body': json.dumps('S3 event processed and data saved to DynamoDB!')
    }
