## Creating an AWS Lambda and S3 Event Notifications with Terraform

In this repository, I’ll create a basic example of how to create an AWS Lambda and S3 Event Notifications to trigger a Lambda function with Terraform.

### Steps

- Create S3 Buckets
- Create a Policy
- Create a Lambda AssumeRole
- Create a Lambda Function
- Create S3 Event Notification
- Create CloudWatch Log Group
- Write python code for lambda function
- Run Terraform
- Testing
  - Uploading a file in bucket
  - Cloudwatch Log group showing the lambda function logs
- Cleanup

Everything in Terraform happens with six simple steps:

- **Initialize (terraform init)** – Install the plugins Terraform needs to manage the infrastructure.
- **Format (terraform fmt)** – Focuses on style and formatting.
- **Validate (terraform validate)** – Checks your configuration for errors.
- **Plan (terraform plan)** – Preview the changes Terraform will make to match your configuration.
- **Apply (terraform apply -auto-approve)** – Make the planned changes.
- **Destroy (terraform destroy -auto-approve)** – Removes resources when no longer needed.
