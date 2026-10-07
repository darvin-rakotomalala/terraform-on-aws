import json
import boto3

s3_client = boto3.client("s3")


def lambda_handler(event, context):
    # Retrieve File Information
    bucket_name = event["Records"][0]["s3"]["bucket"]["name"]
    s3_file_name = event["Records"][0]["s3"]["object"]["key"]

    try:
        # Load Data in object
        json_object = s3_client.get_object(Bucket=bucket_name, Key=s3_file_name)
        print(f"Successfully parsed JSON from s3://{bucket_name}/{s3_file_name}")

        json_file_reader = json_object["Body"].read().decode("utf-8")
        # Parse the JSON content
        json_dict = json.loads(json_file_reader)

        # Extract details
        customer_id = json_dict.get("customerId")
        first_name = json_dict.get("firstName")
        last_name = json_dict.get("lastName")
        status = json_dict.get("status")
        is_premium = json_dict.get("isPremium")

        # Log the details
        print(f"Customer Id: {customer_id}")
        print(f"First name: {first_name}")
        print(f"Last name: {last_name}")
        print(f"Status: {status}")
        print(f"Premium: {is_premium}")

        return {
            "statusCode": 200,
            "body": json.dumps("JSON file processed successfully!"),
        }

    except Exception as e:
        print(f"Error processing file s3://{bucket_name}/{s3_file_name}: {e}")
        return {"statusCode": 500, "body": json.dumps(f"Error processing file: {e}")}
