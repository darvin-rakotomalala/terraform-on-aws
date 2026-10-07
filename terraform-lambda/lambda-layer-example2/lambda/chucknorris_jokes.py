import json
import requests
import os

def lambda_handler(event, context):
    response = requests.get(os.environ['API_URL'])
    joke = response.json().get("value", "No joke found.")
    return {
        "statusCode": 200,
        "headers": {"Content-Type": "application/json"},
        "body": json.dumps(joke)
    }
