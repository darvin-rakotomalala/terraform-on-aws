# helloWorldPersonalized.py

import json
from helloworldlayer import hellogreeting

def lambda_handler(event, context):
	msg = hellogreeting("Darvin")
	return {
            'statusCode': 200,
            'body': json.dumps(msg)
        }
